package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
public class SuspensionHistoryResponse {
    private Integer exceptionId;
    private String classCode;       // Hiển thị: 14DHTH04
    private LocalDate exceptionDate;// Hiển thị: 15/03/2026
    private String reason;          // Hiển thị: Tham dự hội thảo...
    private String status;          // 'pending', 'approved', 'rejected'
    private LocalDateTime createdAt;// Hiển thị: Gửi lúc 10/03/2026 08:30
}