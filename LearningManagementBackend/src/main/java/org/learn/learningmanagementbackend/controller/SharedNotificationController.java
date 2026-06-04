package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.NotificationResponse;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
public class SharedNotificationController {

    private final NotificationRepository notificationRepository;

    @GetMapping("/my-notifications")
    public ResponseEntity<List<NotificationResponse>> getMyNotifications() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return ResponseEntity.ok(java.util.Collections.emptyList());
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        List<Notification> notifications = notificationRepository.findByUserIdOrderByCreatedAtDesc(userId);
        
        List<NotificationResponse> responses = notifications.stream().map(n -> {
            NotificationResponse r = new NotificationResponse();
            r.setId(n.getId());
            r.setTitle(n.getTitle());
            r.setBody(n.getBody());
            r.setType(n.getType());
            r.setIsRead(n.getIsRead());
            r.setCreatedAt(n.getCreatedAt());
            return r;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(responses);
    }

    @PutMapping("/{id}/mark-read")
    public ResponseEntity<Void> markAsRead(@PathVariable Integer id) {
        notificationRepository.findById(id).ifPresent(n -> {
            n.setIsRead(true);
            notificationRepository.save(n);
        });
        return ResponseEntity.ok().build();
    }
}
