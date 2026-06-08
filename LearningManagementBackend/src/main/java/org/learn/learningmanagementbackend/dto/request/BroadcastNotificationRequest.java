package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.NotificationType;

@Getter
@Setter
public class BroadcastNotificationRequest {
    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Body is required")
    private String body;

    private NotificationType type;
}
