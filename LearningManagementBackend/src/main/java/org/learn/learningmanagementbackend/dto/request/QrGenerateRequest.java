package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class QrGenerateRequest {

    @NotNull(message = "Vui lòng chọn lớp học phần")
    private Integer classId;

    @NotNull(message = "Vui lòng nhập thời gian hiệu lực")
    @Min(value = 1, message = "Thời gian hiệu lực tối thiểu là 1 phút")
    private Integer validDurationMinutes;
}