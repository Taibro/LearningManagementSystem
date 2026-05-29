package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class MakeupSubmitRequest {

    @NotNull(message = "Vui lòng chọn buổi nghỉ gốc")
    private Integer exceptionId;

    @NotNull(message = "Ngày dạy bù không được để trống")
    private LocalDate makeupDate;

    @NotNull(message = "Tiết bắt đầu không được để trống")
    @Min(value = 1, message = "Tiết học phải từ 1 trở lên")
    private Integer replacementStartPeriod;

    @NotNull(message = "Tiết kết thúc không được để trống")
    @Max(value = 15, message = "Tiết học không được vượt quá 15")
    private Integer replacementEndPeriod;

    private String suggestedRoom;
    private String makeupNotes;
}