package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class SystemErrorLogResponse {

    private Long id;
    private String endpoint;
    private String errorMessage;
    private String schoolName;
    private Boolean isResolved;
    private LocalDateTime createdAt;
}
