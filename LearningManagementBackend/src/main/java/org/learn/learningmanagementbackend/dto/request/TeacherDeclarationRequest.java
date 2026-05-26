package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class TeacherDeclarationRequest {

    @NotNull(message = "Mã giảng viên không được để trống")
    private Integer teacherId;

    @NotNull(message = "Mã học kỳ không được để trống")
    private Integer semesterId;

    @Min(value = 0, message = "Số tiết dự kiến phải lớn hơn hoặc bằng 0")
    private Integer expectedSessions;

    @Min(value = 0, message = "Số lớp dự kiến phải lớn hơn hoặc bằng 0")
    private Integer expectedClasses;

    private String notes;
}