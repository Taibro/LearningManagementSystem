package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.NotificationRequest;
import org.learn.learningmanagementbackend.dto.response.NotificationResponse;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.UsersRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminNotificationService")
@RequiredArgsConstructor
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final UsersRepository usersRepository;

    public List<NotificationResponse> getAllNotifications() {
        return notificationRepository.findAll().stream()
                .sorted((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()))
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public NotificationResponse createNotification(NotificationRequest request) {
        Users user = usersRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Notification notification = new Notification();
        notification.setUser(user);
        notification.setTitle(request.getTitle());
        notification.setBody(request.getBody());
        notification.setType(request.getType());
        notification.setIsRead(false);

        return mapToResponse(notificationRepository.save(notification));
    }

    public NotificationResponse markAsRead(Integer id) {
        Notification notification = notificationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Notification not found"));
        notification.setIsRead(true);
        notification.setReadAt(LocalDateTime.now());
        return mapToResponse(notificationRepository.save(notification));
    }

    public void deleteNotification(Integer id) {
        notificationRepository.deleteById(id);
    }

    private NotificationResponse mapToResponse(Notification notification) {
        NotificationResponse response = new NotificationResponse();
        response.setId(notification.getId());
        if (notification.getUser() != null) {
            response.setUserId(notification.getUser().getId());
            response.setUserName(notification.getUser().getFullName());
        }
        response.setTitle(notification.getTitle());
        response.setBody(notification.getBody());
        response.setType(notification.getType());
        response.setIsRead(notification.getIsRead());
        response.setCreatedAt(notification.getCreatedAt());
        return response;
    }
}
