package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DashboardStatsResponse {
    private long totalStudents;
    private long totalTeachers;
    private long totalClasses;
    private long todayAbsences;
    private BigDecimal totalTuitionDebt;
    private String schoolName;
}
