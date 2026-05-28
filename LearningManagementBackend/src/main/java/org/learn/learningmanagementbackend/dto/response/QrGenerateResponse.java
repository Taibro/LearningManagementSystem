package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class QrGenerateResponse {
    private String qrToken;
    private Long expiresAtMillis;
}