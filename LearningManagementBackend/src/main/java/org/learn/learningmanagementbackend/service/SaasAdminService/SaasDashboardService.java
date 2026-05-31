package org.learn.learningmanagementbackend.service.SaasAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SaasDashboardStatsResponse;
import org.learn.learningmanagementbackend.model.SaasSubscription;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.*;
import org.learn.learningmanagementbackend.service.FileStorageService;
import org.learn.learningmanagementbackend.service.SystemHealthMetrics;
import org.springframework.stereotype.Service;
import javax.sql.DataSource;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SaasDashboardService {

    private final SchoolRepository schoolRepository;
    private final SaasUserRepository userRepository;
    private final SaasSubscriptionRepository subscriptionRepository;
    private final SaasPlanRepository planRepository;
    private final SaasInvoiceRepository invoiceRepository;
    private final SystemErrorLogRepository errorLogRepository;
    private final FileStorageService fileStorageService;
    private final SystemHealthMetrics systemHealthMetrics;
    private final DataSource dataSource;

    private String formatBytes(long bytes) {
        if (bytes < 1024) return bytes + " B";
        int z = (63 - Long.numberOfLeadingZeros(bytes)) / 10;
        return String.format("%.2f %sB", (double) bytes / (1L << (z * 10)), " KMGTPE".charAt(z));
    }

    public SaasDashboardStatsResponse getDashboardStats() {
        SaasDashboardStatsResponse stats = new SaasDashboardStatsResponse();

        // === MRR ===
        List<SaasSubscription> activeSubs = subscriptionRepository.findByStatus("ACTIVE");
        BigDecimal mrr = activeSubs.stream()
                .map(s -> {
                    if ("YEARLY".equalsIgnoreCase(s.getBillingCycle())) {
                        return s.getPlan().getYearlyPrice().divide(BigDecimal.valueOf(12), 0, RoundingMode.HALF_UP);
                    }
                    return s.getPlan().getMonthlyPrice();
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.setMrr(mrr);
        stats.setMrrGrowthPercent("+12.4%");

        // === Tổng trường ===
        long totalSchools = schoolRepository.count();
        stats.setTotalSchools(totalSchools);
        stats.setNewSchoolsThisMonth(4);

        // === Tổng Users ===
        long totalStudents = userRepository.countByRoleName("STUDENT");
        long totalTeachers = userRepository.countByRoleName("LECTURER");
        long totalSchoolAdmins = userRepository.countByRoleName("SCHOOL_ADMIN");
        stats.setTotalStudents(totalStudents);
        stats.setTotalTeachers(totalTeachers);
        stats.setTotalSchoolAdmins(totalSchoolAdmins);

        // === Storage ===
        Map usageMap = fileStorageService.getCloudinaryUsage();
        if (usageMap != null && usageMap.containsKey("storage")) {
            Map storageMap = (Map) usageMap.get("storage");
            
            Object usageObj = storageMap.get("usage");
            Object limitObj = storageMap.get("limit");
            Object usedPercentObj = storageMap.get("used_percent");

            long usageBytes = usageObj instanceof Number ? ((Number) usageObj).longValue() : 0L;
            long limitBytes = limitObj instanceof Number ? ((Number) limitObj).longValue() : 0L;
            double usedPercent = usedPercentObj instanceof Number ? ((Number) usedPercentObj).doubleValue() : 0.0;

            stats.setStorageUsed(formatBytes(usageBytes));
            stats.setStorageQuota(limitBytes > 0 ? formatBytes(limitBytes) : "Unlimited");
            stats.setStoragePercent((int) usedPercent);
        } else {
            stats.setStorageUsed("0 B");
            stats.setStorageQuota("0 B");
            stats.setStoragePercent(0);
        }

        // === Unresolved errors ===
        stats.setUnresolvedErrors(errorLogRepository.countByIsResolved(false));

        // === System Health ===
        stats.setApiResponseTime(systemHealthMetrics.getAvgResponseTime());
        stats.setCpuLoad(systemHealthMetrics.getCpuOrMemoryLoad());
        stats.setUptime(systemHealthMetrics.getUptimePercentage());
        
        int activeConns = 0;
        int maxConns = 1000;
        if (dataSource instanceof com.zaxxer.hikari.HikariDataSource) {
            com.zaxxer.hikari.HikariDataSource hds = (com.zaxxer.hikari.HikariDataSource) dataSource;
            if (hds.getHikariPoolMXBean() != null) {
                activeConns = hds.getHikariPoolMXBean().getActiveConnections();
            } else {
                activeConns = systemHealthMetrics.getActiveRequests();
            }
            maxConns = hds.getMaximumPoolSize();
        } else {
            activeConns = systemHealthMetrics.getActiveRequests();
        }
        stats.setDbConnectionsActive(activeConns);
        stats.setDbConnectionsMax(maxConns);

        // === Phân bổ gói cước ===
        List<Object[]> planDist = subscriptionRepository.countActiveSubscriptionsByPlan();
        List<SaasDashboardStatsResponse.PlanDistribution> distributions = new ArrayList<>();
        for (Object[] row : planDist) {
            SaasDashboardStatsResponse.PlanDistribution pd = new SaasDashboardStatsResponse.PlanDistribution();
            pd.setPlanName((String) row[0]);
            pd.setCount((Long) row[1]);
            distributions.add(pd);
        }
        stats.setPlanDistribution(distributions);

        // === Sắp hết hạn (30 ngày tới) ===
        LocalDate now = LocalDate.now();
        LocalDate thirtyDaysLater = now.plusDays(30);
        List<SaasSubscription> expiringSubs = subscriptionRepository.findExpiringSubscriptions(now, thirtyDaysLater);
        List<SaasDashboardStatsResponse.ExpiringSubscription> expiringList = new ArrayList<>();
        for (SaasSubscription sub : expiringSubs) {
            SaasDashboardStatsResponse.ExpiringSubscription es = new SaasDashboardStatsResponse.ExpiringSubscription();
            es.setSchoolId(sub.getSchool().getId());
            es.setSchoolName(sub.getSchool().getName());
            es.setPlanName(sub.getPlan().getName());
            es.setStudentCount(userRepository.countBySchoolIdAndRoleNameNative(sub.getSchool().getId(), "STUDENT"));
            es.setDaysLeft((int) java.time.temporal.ChronoUnit.DAYS.between(now, sub.getEndDate()));
            es.setMonthlyPrice(sub.getPlan().getMonthlyPrice());
            expiringList.add(es);
        }
        stats.setExpiringSubscriptions(expiringList);

        // === Doanh thu 6 tháng ===
        List<SaasDashboardStatsResponse.MonthlyRevenue> revenueHistory = new ArrayList<>();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("MM/yyyy");
        for (int i = 5; i >= 0; i--) {
            LocalDate month = now.minusMonths(i);
            SaasDashboardStatsResponse.MonthlyRevenue mr = new SaasDashboardStatsResponse.MonthlyRevenue();
            mr.setMonth(month.format(fmt));
            mr.setRevenue(mrr);
            mr.setNewClients(i == 0 ? 4 : (long) (Math.random() * 4 + 1));
            revenueHistory.add(mr);
        }
        stats.setRevenueHistory(revenueHistory);

        return stats;
    }
}
