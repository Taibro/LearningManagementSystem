package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class QrScanRequest {

    @NotBlank(message = "Mã QR không hợp lệ hoặc bị trống")
    private String qrToken;

    @NotNull(message = "Không xác định được sinh viên")
    private Integer studentId;
}