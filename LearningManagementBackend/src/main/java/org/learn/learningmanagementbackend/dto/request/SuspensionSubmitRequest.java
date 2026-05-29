package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

@Data
public class SuspensionSubmitRequest {

    @NotNull(message = "Vui lòng chọn ca học cần tạm ngừng")
    private Integer scheduleId;

    @NotNull(message = "Ngày xin ngừng không được để trống")
    private LocalDate exceptionDate;

    @NotBlank(message = "Vui lòng nhập lý do xin tạm ngừng")
    private String reason;
    
}