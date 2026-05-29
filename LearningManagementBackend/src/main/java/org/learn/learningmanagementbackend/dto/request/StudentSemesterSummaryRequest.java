package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class StudentSemesterSummaryRequest {

    @NotNull(message = "Student ID is required")
    private Integer studentId;

    @NotNull(message = "Semester ID is required")
    private Integer semesterId;

    private BigDecimal gpa;
    private Integer creditsEarned;
    private Integer conductScore;
    private String conductGrade;
    private String scholarshipName;
    private BigDecimal scholarshipAmount;
    private String notes;
}
