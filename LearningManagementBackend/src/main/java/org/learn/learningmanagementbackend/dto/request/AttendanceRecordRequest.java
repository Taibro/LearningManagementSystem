package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;

import java.time.LocalDate;

@Getter
@Setter
public class AttendanceRecordRequest {

    @NotNull(message = "Schedule ID is required")
    private Integer scheduleId;

    @NotNull(message = "Student ID is required")
    private Integer studentId;

    @NotNull(message = "Attendance date is required")
    private LocalDate attendanceDate;

    @NotNull(message = "Status is required")
    private AttendanceStatus status;

    private String note;
    
    // Admin có thể gán ID người điểm danh (vd GV), nếu null thì lấy ID của người gọi API
    private Integer checkedById; 
}
