package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class SubstituteSubmitRequest {
    @NotNull(message = "Vui lòng chọn ca học cần thay")
    private Integer scheduleId;

    @NotNull(message = "Ngày dạy cần thay không được để trống")
    private LocalDate exceptionDate;

    @NotNull(message = "Vui lòng chọn giảng viên dạy thay")
    private Integer substituteTeacherId;

    @NotBlank(message = "Vui lòng nhập nội dung bài dạy thay")
    private String substituteContent;

    @NotBlank(message = "Vui lòng nhập lý do đề xuất")
    private String reason;
}