package org.learn.learningmanagementbackend.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Setup2faResponse {
    private String secretKey;
    private String qrCodeImageUri;
}
