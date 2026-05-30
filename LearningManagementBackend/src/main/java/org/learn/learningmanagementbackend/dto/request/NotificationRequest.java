package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.NotificationType;

@Getter
@Setter
public class NotificationRequest {
    @NotNull(message = "User ID is required")
    private Integer userId;

    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Body is required")
    private String body;

    private NotificationType type;
}
