package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CourseRequest {

    @NotBlank(message = "Mã môn học không được để trống")
    private String code;

    @NotBlank(message = "Tên môn học không được để trống")
    private String name;

    @NotNull(message = "Số tín chỉ không được để trống")
    @Min(value = 1, message = "Số tín chỉ phải lớn hơn 0")
    private Integer credits;

    @NotNull(message = "Số tiết lý thuyết không được để trống")
    @Min(value = 0, message = "Số tiết lý thuyết không được âm")


    @NotNull(message = "Số tiết thực hành không được để trống")
    @Min(value = 0, message = "Số tiết thực hành không được âm")


    private String description;

    @NotNull(message = "Mã khoa không được để trống")
    private Integer departmentId;
}
