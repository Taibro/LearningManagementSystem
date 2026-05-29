package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MakeupHistoryResponse {
    private Integer exceptionId;
    private String title;         // "14DHTH04 - Bù 15/03"
    private String makeupDetails; // "Tiết 1-3, Phòng A401, 15/03/2026"
    private String status;        // "PENDING", "APPROVED"...
}