package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.learn.learningmanagementbackend.enums.Gender;

import java.time.LocalDate;

@Data
public class TeacherRequest {
    // Thông tin cơ bản (Users)
    @NotBlank(message = "Họ tên không được để trống")
    private String fullName;

    @NotBlank(message = "Email không được để trống")
    private String email;

    @NotBlank(message = "Số điện thoại không được để trống")
    private String phone;

    @NotBlank(message = "CCCD không được để trống")
    private String citizenIdNumber;

    private Gender gender;
    private LocalDate dateOfBirth;

    // Thông tin Giảng viên (Teacher)
    @NotBlank(message = "Mã giảng viên không được để trống")
    private String teacherCode;

    private String degree;
    private String specialization;
    private LocalDate joinedDate;
    private String bio;

    @NotNull(message = "Khoa trực thuộc không được để trống")
    private Integer departmentId;
}
