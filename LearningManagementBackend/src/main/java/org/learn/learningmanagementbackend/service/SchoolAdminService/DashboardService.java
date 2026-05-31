package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.DashboardStatsResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import jakarta.persistence.EntityManager;

import java.math.BigDecimal;
import java.time.LocalDate;

@Service("schoolAdminDashboardService")
@RequiredArgsConstructor
public class DashboardService {

    private final EntityManager entityManager;

    public DashboardStatsResponse getDashboardStats() {
        DashboardStatsResponse stats = new DashboardStatsResponse();

        // 1. Lấy thông tin User đang đăng nhập từ Token
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof CustomUserDetails)) {
            return stats;
        }
        Integer userId = ((CustomUserDetails) principal).getUserId();

        // 2. Tra cứu ID Trường mà Admin này đang quản lý
        Integer schoolId;
        try {
            schoolId = entityManager.createQuery(
                    "SELECT u.school.id FROM Users u WHERE u.id = :userId", Integer.class)
                    .setParameter("userId", userId)
                    .setMaxResults(1)
                    .getSingleResult();
        } catch (Exception e) {
            // Nếu không tìm thấy quyền quản lý trường nào, trả về 0 hết
            return stats;
        }

        // 3. Đếm Sinh viên theo Trường
        Long totalStudents = entityManager.createQuery(
                "SELECT COUNT(s) FROM Student s WHERE s.department.school.id = :schoolId", Long.class)
                .setParameter("schoolId", schoolId).getSingleResult();
        stats.setTotalStudents(totalStudents);

        // 4. Đếm Giảng viên theo Trường
        Long totalTeachers = entityManager.createQuery(
                "SELECT COUNT(t) FROM Teacher t WHERE t.department.school.id = :schoolId", Long.class)
                .setParameter("schoolId", schoolId).getSingleResult();
        stats.setTotalTeachers(totalTeachers);

        // 5. Đếm Lớp học theo Trường (thông qua Khoá học -> Khoa -> Trường)
        Long totalClasses = entityManager.createQuery(
                "SELECT COUNT(c) FROM Classes c WHERE c.course.department.school.id = :schoolId", Long.class)
                .setParameter("schoolId", schoolId).getSingleResult();
        stats.setTotalClasses(totalClasses);

        // 6. Đếm số ca Vắng mặt hôm nay của Sinh viên thuộc Trường
        Long todayAbsences = entityManager.createQuery(
                "SELECT COUNT(a) FROM AttendanceRecord a WHERE a.student.department.school.id = :schoolId AND a.attendanceDate = :today AND a.status = 'ABSENT'", Long.class)
                .setParameter("schoolId", schoolId)
                .setParameter("today", LocalDate.now())
                .getSingleResult();
        stats.setTodayAbsences(todayAbsences);

        // 7. Tính tổng Công nợ học phí của Sinh viên thuộc Trường
        BigDecimal totalDebt = entityManager.createQuery(
                "SELECT SUM(COALESCE(i.totalAmount, 0) - COALESCE(i.paidAmount, 0)) FROM TuitionInvoice i WHERE i.student.department.school.id = :schoolId AND COALESCE(i.totalAmount, 0) > COALESCE(i.paidAmount, 0)", BigDecimal.class)
                .setParameter("schoolId", schoolId).getSingleResult();
        stats.setTotalTuitionDebt(totalDebt != null ? totalDebt : BigDecimal.ZERO);

        return stats;
    }
}
