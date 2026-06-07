package org.learn.learningmanagementbackend.controller;

import lombok.Data;
import org.learn.learningmanagementbackend.model.ChatMessage;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.ChatMessageRepository;
import org.learn.learningmanagementbackend.repository.UserChatPreferenceRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import org.learn.learningmanagementbackend.model.UserChatPreference;

import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.*;

@RestController
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;
    private final ChatMessageRepository chatMessageRepository;
    private final UserRepository userRepository;
    private final UserChatPreferenceRepository preferenceRepository;

    public ChatController(SimpMessagingTemplate messagingTemplate, ChatMessageRepository chatMessageRepository, UserRepository userRepository, UserChatPreferenceRepository preferenceRepository) {
        this.messagingTemplate = messagingTemplate;
        this.chatMessageRepository = chatMessageRepository;
        this.userRepository = userRepository;
        this.preferenceRepository = preferenceRepository;
    }

    @MessageMapping("/chat.send")
    public void sendMessage(@Payload ChatMessagePayload payload, Principal principal) {
        String senderEmail = principal.getName();
        
        // Save to Database
        ChatMessage message = new ChatMessage();
        message.setSenderEmail(senderEmail);
        message.setReceiverEmail(payload.getReceiverEmail());
        message.setContent(payload.getContent());
        message.setTimestamp(LocalDateTime.now());
        message.setRead(false);
        chatMessageRepository.save(message);

        ChatMessageResponse response = new ChatMessageResponse();
        response.setSenderEmail(senderEmail);
        response.setReceiverEmail(payload.getReceiverEmail());
        response.setContent(payload.getContent());
        response.setTimestamp(message.getTimestamp().toString());

        // Gửi đến người nhận (Sẽ được routing đến /user/{receiverEmail}/queue/messages)
        messagingTemplate.convertAndSendToUser(
                payload.getReceiverEmail(),
                "/queue/messages",
                response
        );
        
        // (Tùy chọn) Gửi lại cho chính người gửi để xác nhận tin nhắn đã đi
        messagingTemplate.convertAndSendToUser(
                senderEmail,
                "/queue/messages",
                response
        );
    }

    @GetMapping("/api/chat/history")
    public ResponseEntity<List<ChatMessage>> getChatHistory(@RequestParam String userEmail, @AuthenticationPrincipal CustomUserDetails userDetails) {
        String myEmail = userDetails.getEmail();
        
        Optional<UserChatPreference> prefOpt = preferenceRepository.findByUserEmailAndTargetEmail(myEmail, userEmail);
        LocalDateTime deletedAt = prefOpt.map(UserChatPreference::getDeletedAt).orElse(null);
        
        List<ChatMessage> history = chatMessageRepository.findChatHistory(myEmail, userEmail);
        if (deletedAt != null) {
            history.removeIf(msg -> msg.getTimestamp().isBefore(deletedAt));
        }
        
        return ResponseEntity.ok(history);
    }

    @GetMapping("/api/chat/recent")
    public ResponseEntity<List<RecentChatResponse>> getRecentChats(@AuthenticationPrincipal CustomUserDetails userDetails) {
        String myEmail = userDetails.getEmail();
        List<ChatMessage> allMessages = chatMessageRepository.findRecentChatsForUser(myEmail);
        
        Map<String, ChatMessage> latestMessagesMap = new HashMap<>();
        Map<String, UserChatPreference> prefsMap = new HashMap<>();
        
        for (ChatMessage msg : allMessages) {
            String otherUser = msg.getSenderEmail().equals(myEmail) ? msg.getReceiverEmail() : msg.getSenderEmail();
            
            // Lấy preference để kiểm tra xem đã xóa chưa
            UserChatPreference pref = prefsMap.computeIfAbsent(otherUser, k -> 
                preferenceRepository.findByUserEmailAndTargetEmail(myEmail, k).orElse(new UserChatPreference())
            );
            
            // Bỏ qua tin nhắn trước thời điểm bị xóa
            if (pref.getDeletedAt() != null && msg.getTimestamp().isBefore(pref.getDeletedAt())) {
                continue;
            }
            
            if (!latestMessagesMap.containsKey(otherUser)) {
                latestMessagesMap.put(otherUser, msg);
            }
        }
        
        List<RecentChatResponse> recentChats = new ArrayList<>();
        for (Map.Entry<String, ChatMessage> entry : latestMessagesMap.entrySet()) {
            String otherUserEmail = entry.getKey();
            ChatMessage lastMessage = entry.getValue();
            
            Users otherUser = userRepository.findByEmail(otherUserEmail).orElse(null);
            UserChatPreference pref = prefsMap.get(otherUserEmail);
            
            RecentChatResponse dto = new RecentChatResponse();
            dto.setEmail(otherUserEmail);
            dto.setFullName(otherUser != null ? otherUser.getFullName() : otherUserEmail);
            String specificCode = "";
            if (otherUser != null) {
                if (otherUser.getStudent() != null && otherUser.getStudent().getStudentCode() != null) {
                    specificCode = otherUser.getStudent().getStudentCode();
                } else if (otherUser.getTeacher() != null && otherUser.getTeacher().getTeacherCode() != null) {
                    specificCode = otherUser.getTeacher().getTeacherCode();
                } else {
                    specificCode = otherUser.getCode();
                }
            }
            dto.setSpecificCode(specificCode);
            dto.setAvatarUrl(otherUser != null ? otherUser.getAvatarUrl() : null);
            dto.setLastMessage(lastMessage.getContent());
            dto.setTimestamp(lastMessage.getTimestamp().toString());
            dto.setRead(lastMessage.isRead());
            dto.setPinned(pref != null && pref.isPinned());
            
            recentChats.add(dto);
        }
        
        // Sort: Pinned first, then by timestamp descending
        recentChats.sort((a, b) -> {
            if (a.isPinned() && !b.isPinned()) return -1;
            if (!a.isPinned() && b.isPinned()) return 1;
            return b.getTimestamp().compareTo(a.getTimestamp());
        });
        
        return ResponseEntity.ok(recentChats);
    }

    @PostMapping("/api/chat/conversations/{targetEmail}/pin")
    public ResponseEntity<?> togglePinConversation(@PathVariable String targetEmail, @AuthenticationPrincipal CustomUserDetails userDetails) {
        String myEmail = userDetails.getEmail();
        UserChatPreference pref = preferenceRepository.findByUserEmailAndTargetEmail(myEmail, targetEmail)
            .orElseGet(() -> {
                UserChatPreference p = new UserChatPreference();
                p.setUserEmail(myEmail);
                p.setTargetEmail(targetEmail);
                return p;
            });
            
        pref.setPinned(!pref.isPinned());
        preferenceRepository.save(pref);
        return ResponseEntity.ok(Map.of("message", "Pin status toggled", "isPinned", pref.isPinned()));
    }

    @DeleteMapping("/api/chat/conversations/{targetEmail}")
    public ResponseEntity<?> deleteConversation(@PathVariable String targetEmail, @AuthenticationPrincipal CustomUserDetails userDetails) {
        String myEmail = userDetails.getEmail();
        UserChatPreference pref = preferenceRepository.findByUserEmailAndTargetEmail(myEmail, targetEmail)
            .orElseGet(() -> {
                UserChatPreference p = new UserChatPreference();
                p.setUserEmail(myEmail);
                p.setTargetEmail(targetEmail);
                return p;
            });
            
        pref.setDeletedAt(LocalDateTime.now());
        pref.setPinned(false); // unpin when deleted
        preferenceRepository.save(pref);
        return ResponseEntity.ok(Map.of("message", "Conversation deleted successfully"));
    }

    @PostMapping("/api/chat/conversations/bulk-delete")
    public ResponseEntity<?> bulkDeleteConversations(@RequestBody List<String> targetEmails, @AuthenticationPrincipal CustomUserDetails userDetails) {
        String myEmail = userDetails.getEmail();
        for (String targetEmail : targetEmails) {
            UserChatPreference pref = preferenceRepository.findByUserEmailAndTargetEmail(myEmail, targetEmail)
                .orElseGet(() -> {
                    UserChatPreference p = new UserChatPreference();
                    p.setUserEmail(myEmail);
                    p.setTargetEmail(targetEmail);
                    return p;
                });
                
            pref.setDeletedAt(LocalDateTime.now());
            pref.setPinned(false);
            preferenceRepository.save(pref);
        }
        return ResponseEntity.ok(Map.of("message", "Conversations deleted successfully"));
    }

    @Data
    public static class ChatMessagePayload {
        private String receiverEmail;
        private String content;
    }

    @Data
    public static class ChatMessageResponse {
        private String senderEmail;
        private String receiverEmail;
        private String content;
        private String timestamp;
    }

    @Data
    public static class RecentChatResponse {
        private String email;
        private String fullName;
        private String specificCode;
        private String avatarUrl;
        private String lastMessage;
        private String timestamp;
        private boolean isRead;
        private boolean isPinned;
    }
}
