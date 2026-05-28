package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;

import java.util.List;

@Data
@Builder
public class AttendanceListResponse {
    private int totalStudents;
    private int totalPresent;
    private int totalAbsent;
    private int presentPercentage;

    private List<StudentAttendanceDto> students;

    @Data
    @Builder
    public static class StudentAttendanceDto {
        private Integer studentId;
        private String studentCode;
        private String fullName;
        private AttendanceStatus status;
    }
}