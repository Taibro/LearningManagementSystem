package org.learn.learningmanagementbackend.dto.projection;

import java.time.LocalDateTime;

public interface StudentNotificationDto {

    Integer getId();
    String getTitle();
    String getBody();
    String getType();
    Boolean getIsRead();
    LocalDateTime getCreatedAt();
}
