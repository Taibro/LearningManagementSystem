package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class AuditLogResponse {

    private Long id;
    private LocalDateTime createdAt;
    private String userEmail;
    private String schoolName;
    private String action;
    private String tableName;
    private Long recordId;
    private String ipAddress;
}
