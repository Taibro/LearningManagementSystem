package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;

import java.time.LocalDateTime;

@Getter
@Setter
public class EnrollmentRequest {

    @NotNull(message = "Student ID is required")
    private Integer studentId;

    @NotNull(message = "Class ID is required")
    private Integer classId;

    private LocalDateTime enrollmentDate;
    private EnrollmentStatus status;
    private Double gradeAttendance;
    private Double gradeMidterm;
    private Double gradeFinal;
    private Double gradeTotal;
    private String gradeLetter;
}
