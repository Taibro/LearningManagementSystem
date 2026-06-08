package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.BroadcastNotificationRequest;
import org.learn.learningmanagementbackend.dto.request.NotificationRequest;
import org.learn.learningmanagementbackend.dto.response.NotificationResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.NotificationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminNotificationController")
@RequestMapping("/api/school-admin/notifications")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping
    public ResponseEntity<List<NotificationResponse>> getAllNotifications() {
        return ResponseEntity.ok(notificationService.getAllNotifications());
    }

    @PostMapping
    public ResponseEntity<NotificationResponse> createNotification(@RequestBody NotificationRequest request) {
        return ResponseEntity.ok(notificationService.createNotification(request));
    }

    @PostMapping("/broadcast")
    public ResponseEntity<Void> broadcastNotification(@RequestBody BroadcastNotificationRequest request) {
        notificationService.broadcastNotification(request);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}/read")
    public ResponseEntity<NotificationResponse> markAsRead(@PathVariable Integer id) {
        return ResponseEntity.ok(notificationService.markAsRead(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteNotification(@PathVariable Integer id) {
        notificationService.deleteNotification(id);
        return ResponseEntity.noContent().build();
    }
}
