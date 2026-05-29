package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SubstituteHistoryResponse {
    private Integer exceptionId;
    private String title;  // Hiển thị: "14DHTH04 - Ca chiều"
    private String status; // PENDING, APPROVED...
}