package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.NotificationType;

import java.time.LocalDateTime;

@Getter
@Setter
public class NotificationResponse {
    private Integer id;
    private Integer userId;
    private String userName;
    private String title;
    private String body;
    private NotificationType type;
    private Boolean isRead;
    private LocalDateTime createdAt;
}
