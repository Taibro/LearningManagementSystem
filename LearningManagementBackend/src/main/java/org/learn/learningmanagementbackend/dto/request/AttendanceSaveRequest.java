package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;

import java.time.LocalDate;
import java.util.List;

@Data
public class AttendanceSaveRequest {
    @NotNull(message = "Mã lịch học (Schedule) không được để trống")
    private Integer scheduleId;

    @NotNull(message = "Mã lớp học phần không được để trống")
    private Integer classId;

    @NotNull(message = "Ngày điểm danh không được để trống")
    private LocalDate attendanceDate;

    @NotNull(message = "Mã giảng viên không được để trống")
    private Integer teacherId;

    private List<StudentStatus> records;

    @Data
    public static class StudentStatus {
        private Integer studentId;
        private AttendanceStatus status;
    }
}