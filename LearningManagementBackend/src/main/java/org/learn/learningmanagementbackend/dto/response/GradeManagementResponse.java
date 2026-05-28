package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Data
@Builder
public class GradeManagementResponse {

    private double classAverage;
    private int passedCount;
    private int failedCount;
    private int excellentCount;
    private boolean isLocked;    // khóa điểm

    private List<StudentGradeDto> students;

    @Data
    @Builder
    public static class StudentGradeDto {
        private Integer enrollmentId;
        private String fullName;
        private String studentCode;
        private Double cc; // Điểm chuyên cần
        private Double gk; // Điểm giữa kỳ
        private Double ck; // Điểm cuối kỳ
        private Double total; // Tổng kết
        private String classification; // Xếp loại
    }
}