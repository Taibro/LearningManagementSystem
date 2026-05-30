package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.NotificationRequest;
import org.learn.learningmanagementbackend.dto.response.NotificationResponse;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminNotificationService")
@RequiredArgsConstructor
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<NotificationResponse> getAllNotifications() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer currentUserId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT u.school.id FROM Users u WHERE u.id = :userId", Integer.class)
                    .setParameter("userId", currentUserId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<Notification> notifications = entityManager.createQuery(
                "SELECT n FROM Notification n WHERE n.user.school.id = :schoolId ORDER BY n.createdAt DESC", Notification.class)
                .setParameter("schoolId", schoolId).getResultList();

        return notifications.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public NotificationResponse createNotification(NotificationRequest request) {
        Users user = userRepository.findById(request.getUserId())
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

