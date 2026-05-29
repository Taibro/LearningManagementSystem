package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class StudentSemesterSummaryResponse {
    private Integer id;
    private Integer studentId;
    private String studentCode;
    private String studentName;
    private Integer semesterId;
    private String semesterName;
    private BigDecimal gpa;
    private Integer creditsEarned;
    private Integer conductScore;
    private String conductGrade;
    private String scholarshipName;
    private BigDecimal scholarshipAmount;
    private String notes;
}
