package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import java.util.List;

@Data
public class GradeSaveRequest {
    @NotNull(message = "Mã lớp học phần không được để trống")
    private Integer classId;

    private List<GradeInput> grades;

    @Data
    public static class GradeInput {
        @NotNull
        private Integer enrollmentId;

        private Double gk; // midterm grade
        private Double ck; // final grade
    }
}