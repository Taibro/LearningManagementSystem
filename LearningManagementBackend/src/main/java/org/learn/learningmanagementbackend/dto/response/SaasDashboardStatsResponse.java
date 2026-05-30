package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class SaasDashboardStatsResponse {

    private BigDecimal mrr;
    private String mrrGrowthPercent;
    private long totalSchools;
    private long newSchoolsThisMonth;
    private long totalStudents;
    private long totalTeachers;
    private String storageUsed;
    private String storageQuota;
    private int storagePercent;
    private long unresolvedErrors;

    // Phân bổ gói cước
    private List<PlanDistribution> planDistribution;

    // Doanh thu 6 tháng
    private List<MonthlyRevenue> revenueHistory;

    // Sắp hết hạn
    private List<ExpiringSubscription> expiringSubscriptions;

    @Getter
    @Setter
    public static class PlanDistribution {
        private String planName;
        private long count;
    }

    @Getter
    @Setter
    public static class MonthlyRevenue {
        private String month;
        private BigDecimal revenue;
        private long newClients;
    }

    @Getter
    @Setter
    public static class ExpiringSubscription {
        private Integer schoolId;
        private String schoolName;
        private String planName;
        private long studentCount;
        private int daysLeft;
        private BigDecimal monthlyPrice;
    }
}
