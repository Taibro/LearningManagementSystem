package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class TeachingStatisticResponse {

    // Thẻ Top Cards
    private String currentSemesterLabel; // VD: "HK2 - 2025-2026"
    private int totalPeriods;
    private int theoryPeriods;
    private int theoryPercentage;
    private int labPeriods;
    private int labPercentage;
    private int examShifts;
    private int upcomingExamShifts;

    // Biểu đồ & Nhắc nhở
    private List<MonthlyChartData> chartData;
    private int overallProgress; // VD: 72
    private List<String> reminders;

    // Bảng Chi tiết môn dạy
    private List<ClassTeachingDetail> classDetails;

    @Data
    @Builder
    public static class MonthlyChartData {
        private String month; // VD: "T1", "T2"
        private int periods;  // Số tiết dạy trong tháng đó
    }

    @Data
    @Builder
    public static class ClassTeachingDetail {
        private String subjectName;     // VD: "Kiến trúc máy tính (LT)"
        private String classCode;       // VD: "16DHTH10"
        private int completedPeriods;   // VD: 29
        private int totalPeriods;       // VD: 45
        private int progressPercentage; // VD: 65
    }
}