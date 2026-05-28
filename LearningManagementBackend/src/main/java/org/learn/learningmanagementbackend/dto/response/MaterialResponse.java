package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MaterialResponse {
    private Integer id;
    private String title;
    private String classInfo; // Gộp tên môn và mã lớp (VD: Kiến trúc máy tính - 14DHTH04)
    private String fileSize;  // Đã format: "2.3 MB" hoặc "450 KB"
    private String uploadDate; // Đã format: "15/01/2026"
    private String fileUrl;
    private String docType;
}