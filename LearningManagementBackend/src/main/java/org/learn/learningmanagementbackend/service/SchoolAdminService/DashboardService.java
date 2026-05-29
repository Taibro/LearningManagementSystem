package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.DashboardStatsResponse;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.*;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;

@Service("schoolAdminDashboardService")
@RequiredArgsConstructor
public class DashboardService {

    private final StudentRepository studentRepository;
    private final TeacherRepository teacherRepository;
    private final ClassesRepository classesRepository;
    private final AttendanceRecordRepository attendanceRepository;
    private final TuitionInvoiceRepository invoiceRepository;

    public DashboardStatsResponse getDashboardStats() {
        DashboardStatsResponse stats = new DashboardStatsResponse();
        
        stats.setTotalStudents(studentRepository.count());
        stats.setTotalTeachers(teacherRepository.count());
        stats.setTotalClasses(classesRepository.count());
        
        // Count absences today
        LocalDate today = LocalDate.now();
        long absences = attendanceRepository.findAll().stream()
                .filter(a -> a.getAttendanceDate() != null && a.getAttendanceDate().isEqual(today))
                .filter(a -> "ABSENT".equals(a.getStatus().name()))
                .count();
        stats.setTodayAbsences(absences);
        
        // Calculate total debt (totalAmount - paidAmount)
        BigDecimal totalDebt = invoiceRepository.findAll().stream()
                .map(inv -> {
                    BigDecimal total = inv.getTotalAmount() != null ? inv.getTotalAmount() : BigDecimal.ZERO;
                    BigDecimal paid = inv.getPaidAmount() != null ? inv.getPaidAmount() : BigDecimal.ZERO;
                    return total.subtract(paid);
                })
                .filter(debt -> debt.compareTo(BigDecimal.ZERO) > 0)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
                
        stats.setTotalTuitionDebt(totalDebt);
        
        return stats;
    }
}
