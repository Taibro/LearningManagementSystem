package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class EvaluationDashboardResponse {

    private double averageScore;      // Điểm TB (VD: 4.6)
    private int satisfactionRate;     // % Hài lòng (VD: 95)
    private int surveyedClasses;      // Lớp đã khảo sát (VD: 3)
    private int totalResponses;       // Lượt phản hồi (VD: 128)

    private double criteriaKnowledge;   // Kiến thức chuyên môn
    private double criteriaMethod;      // Phương pháp giảng dạy
    private double criteriaInteraction; // Tương tác với sinh viên
    private double criteriaMaterials;   // Tài liệu giảng dạy
    private double criteriaPunctuality; // Đúng giờ, kỷ luật

    private List<StudentComment> comments;

    @Data
    @Builder
    public static class StudentComment {
        private String classCode; // VD: 14DHTH04
        private String author;    // Mặc định luôn set là "ẩn danh"
        private String content;   // Nội dung nhận xét
    }
}