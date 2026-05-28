package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class MaterialUploadRequest {

    @NotNull(message = "Mã lớp học phần không được để trống")
    private Integer classId;

    @NotNull(message = "Mã giảng viên không được để trống")
    private Integer teacherId;

    @NotBlank(message = "Tiêu đề tài liệu không được để trống")
    private String title;

    @NotBlank(message = "Loại tài liệu không được để trống")
    private String docType;

    @NotNull(message = "Vui lòng đính kèm tệp tin")
    private MultipartFile file;
}