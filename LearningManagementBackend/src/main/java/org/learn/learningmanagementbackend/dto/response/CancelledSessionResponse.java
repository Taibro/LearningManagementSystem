package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CancelledSessionResponse {
    private Integer exceptionId;
    private String displayLabel; // Dùng cho Dropdown: "22/02/2026 - 14DHTH04"
}