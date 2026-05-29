package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class DepartmentRequest {
    @NotBlank(message = "Mã khoa không được để trống")
    private String code;

    @NotBlank(message = "Tên khoa không được để trống")
    private String name;

    private String description;

    private Integer schoolId; // ID của trường mà admin đang quản lý
}
