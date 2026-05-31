package org.learn.learningmanagementbackend.service.StudentService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.StudentCourseRegDto;
import org.learn.learningmanagementbackend.dto.request.CourseRegistrationRequest;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;
import org.learn.learningmanagementbackend.enums.TuitionInvoiceStatus;
import org.learn.learningmanagementbackend.model.*;
import org.learn.learningmanagementbackend.repository.LecturerRepository.*;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CourseRegistrationService {

    private static final BigDecimal PRICE_PER_CREDIT = new BigDecimal("1135000");

    private final StudentRepository      studentRepository;
    private final ClassRepository        classRepository;
    private final EnrollmentRepository   enrollmentRepository;
    private final TuitionInvoiceRepository tuitionInvoiceRepository;
    private final ScheduleRepository     scheduleRepository;

    // ── LẤY DANH SÁCH LỚP ──────────────────────────────────────────────────────
    public List<StudentCourseRegDto> getCourseList(String studentCode, Integer semesterId, String type) {
        int sid = (semesterId == null) ? 0 : semesterId;
        return switch (type == null ? "NORMAL" : type.toUpperCase()) {
            case "RETAKE"  -> studentRepository.getRetakeClasses(studentCode, sid);
            case "IMPROVE" -> studentRepository.getImproveClasses(studentCode, sid);
            default        -> studentRepository.getAvailableClasses(studentCode, sid);
        };
    }

    // ── ĐĂNG KÝ MÔN ────────────────────────────────────────────────────────────
    @Transactional
    public void register(String studentCode, CourseRegistrationRequest req) {
        // 1. Lấy sinh viên
        Student student = studentRepository.findByStudentCode(studentCode)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy sinh viên."));

        // 2. Lấy lớp
        Classes cls = classRepository.findById(req.getClassId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy lớp học phần."));

        // 3. Kiểm tra lớp còn mở
        if (!"OPEN".equals(cls.getStatus().name())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Lớp học phần này đã đóng đăng ký.");
        }

        // 4. Kiểm tra sĩ số
        long enrolledCount = enrollmentRepository.countByClassesIdAndStatusIn(
                cls.getId(), List.of(EnrollmentStatus.ENROLLED, EnrollmentStatus.PENDING));
        if (enrolledCount >= cls.getMaxStudents()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Lớp học phần đã đầy chỗ.");
        }

        // 5. Kiểm tra đã đăng ký lớp này chưa
        boolean alreadyInClass = enrollmentRepository.existsByStudentIdAndClassesIdAndStatusIn(
                student.getId(), cls.getId(), List.of(EnrollmentStatus.ENROLLED, EnrollmentStatus.PENDING));
        if (alreadyInClass) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Bạn đã đăng ký lớp học phần này rồi.");
        }

        // 6. Kiểm tra trùng lịch
        List<Schedule> newSchedules = scheduleRepository.findByClasses_Id(cls.getId());
        if (!newSchedules.isEmpty()) {
            // Lấy tất cả schedule của các lớp sinh viên đang học
            List<Schedule> mySchedules = scheduleRepository
                    .findActiveSchedulesForStudent(student.getId());

            for (Schedule ns : newSchedules) {
                for (Schedule ms : mySchedules) {
                    if (ns.getDayOfWeek().equals(ms.getDayOfWeek()) &&
                        ns.getStartPeriod() != null && ms.getEndPeriod() != null &&
                        ns.getStartPeriod() <= ms.getEndPeriod() &&
                        ns.getEndPeriod()   >= ms.getStartPeriod()) {
                        throw new ResponseStatusException(HttpStatus.CONFLICT,
                                "Trùng lịch học với môn đã đăng ký (Thứ " + ns.getDayOfWeek() +
                                ", tiết " + ns.getStartPeriod() + "–" + ns.getEndPeriod() + ").");
                    }
                }
            }
        }

        // 7. Tạo Enrollment
        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student);
        enrollment.setClasses(cls);
        enrollment.setStatus(EnrollmentStatus.ENROLLED);
        enrollment.setEnrollmentDate(LocalDateTime.now());
        enrollmentRepository.save(enrollment);

        // 8. Cập nhật TuitionInvoice
        BigDecimal fee = PRICE_PER_CREDIT.multiply(
                BigDecimal.valueOf(cls.getCourse().getCredits() == null ? 0 : cls.getCourse().getCredits()));

        Semester semester = cls.getSemester();
        TuitionInvoice invoice = tuitionInvoiceRepository
                .findByStudentIdAndSemesterId(student.getId(), semester.getId())
                .orElseGet(() -> {
                    TuitionInvoice newInv = new TuitionInvoice();
                    newInv.setStudent(student);
                    newInv.setSemester(semester);
                    newInv.setTotalAmount(BigDecimal.ZERO);
                    newInv.setPaidAmount(BigDecimal.ZERO);
                    newInv.setStatus(TuitionInvoiceStatus.UNPAID);
                    newInv.setDueDate(semester.getEndDate() != null
                            ? semester.getEndDate().minusDays(14)
                            : LocalDate.now().plusMonths(2));
                    return newInv;
                });

        invoice.setTotalAmount(invoice.getTotalAmount().add(fee));
        // Cập nhật trạng thái
        BigDecimal debt = invoice.getTotalAmount().subtract(invoice.getPaidAmount());
        if (debt.compareTo(BigDecimal.ZERO) <= 0) {
            invoice.setStatus(TuitionInvoiceStatus.PAID);
        } else if (invoice.getPaidAmount().compareTo(BigDecimal.ZERO) > 0) {
            invoice.setStatus(TuitionInvoiceStatus.PARTIAL);
        } else {
            invoice.setStatus(TuitionInvoiceStatus.UNPAID);
        }
        tuitionInvoiceRepository.save(invoice);
    }

    // ── LẤY LỚP ĐÃ ĐĂNG KÝ ─────────────────────────────────────────────────────
    public List<StudentCourseRegDto> getEnrolled(String studentCode, Integer semesterId) {
        int sid = (semesterId == null) ? 0 : semesterId;
        return studentRepository.getEnrolledClasses(studentCode, sid);
    }

    // ── HỦY ĐĂNG KÝ ────────────────────────────────────────────────────────────
    @Transactional
    public void cancelRegistration(String studentCode, Integer classId) {
        Student student = studentRepository.findByStudentCode(studentCode)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy sinh viên."));

        Enrollment enrollment = enrollmentRepository.findByStudentIdAndClassesIdAndStatusIn(
                student.getId(), classId, List.of(EnrollmentStatus.ENROLLED, EnrollmentStatus.PENDING))
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy lớp học phần đã đăng ký."));

        Classes cls = enrollment.getClasses();
        Semester semester = cls.getSemester();

        // 1. Kiểm tra hóa đơn
        TuitionInvoice invoice = tuitionInvoiceRepository
                .findByStudentIdAndSemesterId(student.getId(), semester.getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy thông tin công nợ."));

        BigDecimal fee = PRICE_PER_CREDIT.multiply(
                BigDecimal.valueOf(cls.getCourse().getCredits() == null ? 0 : cls.getCourse().getCredits()));

        BigDecimal newTotalAmount = invoice.getTotalAmount().subtract(fee);
        if (newTotalAmount.compareTo(BigDecimal.ZERO) < 0) {
            newTotalAmount = BigDecimal.ZERO;
        }

        if (invoice.getPaidAmount().compareTo(newTotalAmount) > 0) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, 
                "Hủy học phần này sẽ gây dư nợ học phí do bạn đã đóng tiền trước đó. Vui lòng liên hệ phòng đào tạo để được hỗ trợ hủy và hoàn tiền.");
        }

        // 2. Xóa enrollment (hoặc đổi trạng thái thành DROPPED/CANCELLED)
        // Vì project có thể không có CANCELLED trong EnrollmentStatus, ta có thể đổi thành FAILED hoặc xóa luôn
        enrollmentRepository.delete(enrollment);

        // 3. Trừ tiền hóa đơn
        invoice.setTotalAmount(newTotalAmount);
        
        if (invoice.getTotalAmount().compareTo(BigDecimal.ZERO) == 0 && invoice.getPaidAmount().compareTo(BigDecimal.ZERO) == 0) {
            invoice.setStatus(TuitionInvoiceStatus.UNPAID); // hoặc PAID tùy logic, nhưng 0đ thì không sao
        }
        tuitionInvoiceRepository.save(invoice);
    }
}
