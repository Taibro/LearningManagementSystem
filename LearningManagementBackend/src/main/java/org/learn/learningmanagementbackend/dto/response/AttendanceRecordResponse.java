package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class AttendanceRecordResponse {
    private Integer id;
    
    private Integer scheduleId;
    private String scheduleDetails; // Ví dụ: "INT101 - Thứ 2"
    
    private Integer studentId;
    private String studentName;
    private String studentCode;
    
    private LocalDate attendanceDate;
    private AttendanceStatus status;
    private String note;
    
    private Integer checkedById;
    private String checkedByName;
    private LocalDateTime checkedAt;
}
