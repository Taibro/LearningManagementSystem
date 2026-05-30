package org.learn.learningmanagementbackend.service.SaasAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SaasDashboardStatsResponse;
import org.learn.learningmanagementbackend.model.SaasSubscription;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.*;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SaasDashboardService {

    private final SchoolRepository schoolRepository;
    private final SaasUserRepository userRepository;
    private final SaasSubscriptionRepository subscriptionRepository;
    private final SaasPlanRepository planRepository;
    private final SaasInvoiceRepository invoiceRepository;
    private final SystemErrorLogRepository errorLogRepository;

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
        stats.setTotalStudents(totalStudents);
        stats.setTotalTeachers(totalTeachers);

        // === Storage ===
        stats.setStorageUsed("1.84TB");
        stats.setStorageQuota("3TB");
        stats.setStoragePercent(61);

        // === Unresolved errors ===
        stats.setUnresolvedErrors(errorLogRepository.countByIsResolved(false));

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
            es.setStudentCount(userRepository.countBySchoolIdAndRoleName(sub.getSchool().getId(), "STUDENT"));
            es.setDaysLeft((int) java.time.temporal.ChronoUnit.DAYS.between(now, sub.getEndDate()));
            es.setMonthlyPrice(sub.getPlan().getMonthlyPrice());
            expiringList.add(es);
        }
        stats.setExpiringSubscriptions(expiringList);

        // === Doanh thu 6 tháng (simple placeholder — real implementation would query invoices by month) ===
        List<SaasDashboardStatsResponse.MonthlyRevenue> revenueHistory = new ArrayList<>();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("MM/yyyy");
        for (int i = 5; i >= 0; i--) {
            LocalDate month = now.minusMonths(i);
            SaasDashboardStatsResponse.MonthlyRevenue mr = new SaasDashboardStatsResponse.MonthlyRevenue();
            mr.setMonth(month.format(fmt));
            mr.setRevenue(mrr); // simplified
            mr.setNewClients(i == 0 ? 4 : (long)(Math.random() * 4 + 1));
            revenueHistory.add(mr);
        }
        stats.setRevenueHistory(revenueHistory);

        return stats;
    }
}
