package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;

import java.time.LocalDateTime;

@Getter
@Setter
public class EnrollmentResponse {
    private Integer id;
    private Integer studentId;
    private String studentName;
    private String studentCode;
    private Integer classId;
    private String classCode;
    private LocalDateTime enrollmentDate;
    private EnrollmentStatus status;
    private Double gradeAttendance;
    private Double gradeMidterm;
    private Double gradeFinal;
    private Double gradeTotal;
    private String gradeLetter;
}
