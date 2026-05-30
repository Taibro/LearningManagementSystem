package org.learn.learningmanagementbackend.service.StudentService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.*;
import org.learn.learningmanagementbackend.dto.request.SurveySubmitRequest;
import org.learn.learningmanagementbackend.model.*;
import org.learn.learningmanagementbackend.repository.LecturerRepository.*;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Service
public class StudentService {

    private final org.learn.learningmanagementbackend.repository.LecturerRepository.StudentRepository studentRepository;
    private final TeacherEvaluationRepository evaluationRepository;
    private final ClassRepository classRepository;
    private final org.learn.learningmanagementbackend.repository.LecturerRepository.TuitionInvoiceRepository tuitionInvoiceRepository;
    private final org.learn.learningmanagementbackend.repository.LecturerRepository.TuitionPaymentRepository tuitionPaymentRepository;
    private final org.learn.learningmanagementbackend.repository.LecturerRepository.EnrollmentRepository enrollmentRepository;
    private final org.learn.learningmanagementbackend.repository.LecturerRepository.StudentSemesterSummaryRepository studentSemesterSummaryRepository;
    private final org.learn.learningmanagementbackend.repository.LecturerRepository.SemesterRepository semesterRepository;

    public StudentService(
            org.learn.learningmanagementbackend.repository.LecturerRepository.StudentRepository studentRepository,
            TeacherEvaluationRepository evaluationRepository,
            ClassRepository classRepository,
            org.learn.learningmanagementbackend.repository.LecturerRepository.TuitionInvoiceRepository tuitionInvoiceRepository,
            org.learn.learningmanagementbackend.repository.LecturerRepository.TuitionPaymentRepository tuitionPaymentRepository,
            org.learn.learningmanagementbackend.repository.LecturerRepository.EnrollmentRepository enrollmentRepository,
            org.learn.learningmanagementbackend.repository.LecturerRepository.StudentSemesterSummaryRepository studentSemesterSummaryRepository,
            org.learn.learningmanagementbackend.repository.LecturerRepository.SemesterRepository semesterRepository) {
        this.studentRepository = studentRepository;
        this.evaluationRepository = evaluationRepository;
        this.classRepository = classRepository;
        this.tuitionInvoiceRepository = tuitionInvoiceRepository;
        this.tuitionPaymentRepository = tuitionPaymentRepository;
        this.enrollmentRepository = enrollmentRepository;
        this.studentSemesterSummaryRepository = studentSemesterSummaryRepository;
        this.semesterRepository = semesterRepository;
    }

    // ── PROFILE ──────────────────────────────────────────────────────────────
    public StudentProfileDto getStudentProfile(String studentCode) {
        return studentRepository.getStudentProfileByCode(studentCode);
    }

    // ── WEEKLY SCHEDULE ───────────────────────────────────────────────────────
    public List<StudentScheduleDto> getWeeklySchedule(String studentCode, LocalDate targetDate) {
        if (targetDate == null) {
            targetDate = LocalDate.now();
        }
        LocalDate startOfWeek = targetDate.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek   = targetDate.with(DayOfWeek.SUNDAY);
        return studentRepository.getWeeklyScheduleForStudent(studentCode, startOfWeek, endOfWeek);
    }

    // ── PROGRESS SCHEDULE ─────────────────────────────────────────────────────
    public List<StudentScheduleDto> getProgressSchedule(String studentCode, Integer semesterId) {
        if (semesterId == null) {
            semesterId = 0;
        }
        return studentRepository.getProgressScheduleForStudent(studentCode, semesterId);
    }

    // ── GRADES ────────────────────────────────────────────────────────────────
    public List<StudentGradeDto> getGrades(String studentCode) {
        return studentRepository.getGradesForStudent(studentCode);
    }

    // ── ATTENDANCE ────────────────────────────────────────────────────────────
    public List<StudentAttendanceDto> getAttendance(String studentCode) {
        return studentRepository.getAttendanceForStudent(studentCode);
    }

    // ── CONDUCT ───────────────────────────────────────────────────────────────
    public List<StudentConductDto> getConduct(String studentCode) {
        return studentRepository.getConductForStudent(studentCode);
    }

    // ── TUITION ───────────────────────────────────────────────────────────────
    public List<StudentTuitionDto> getTuition(String studentCode) {
        return studentRepository.getTuitionForStudent(studentCode);
    }

    // ── NOTIFICATIONS ─────────────────────────────────────────────────────────
    public List<StudentNotificationDto> getNotifications(Integer userId) {
        return studentRepository.getNotificationsForUser(userId);
    }

    // ── SURVEYS ───────────────────────────────────────────────────────────────
    public List<StudentSurveyListDto> getSurveyList(String studentCode) {
        return studentRepository.getSurveyListForStudent(studentCode);
    }

    public void submitSurvey(String studentCode, SurveySubmitRequest req) {
        // Kiểm tra đã khảo sát lớp này chưa
        evaluationRepository.findByClassId(req.getClassId()).ifPresent(e -> {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Bạn đã khảo sát lớp học phần này rồi.");
        });

        // Lấy thông tin lớp
        Classes cls = classRepository.findById(req.getClassId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy lớp học phần."));

        // Lấy giảng viên chính của lớp
        Teacher mainTeacher = cls.getTeacherLecturings().stream()
                .filter(ct -> "main".equals(ct.getRole()))
                .map(ClassTeacher::getTeacher)
                .findFirst()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy giảng viên của lớp."));

        // Tạo đánh giá mới
        TeacherEvaluation ev = new TeacherEvaluation();
        ev.setTeacher(mainTeacher);
        ev.setSemester(cls.getSemester());
        ev.setClasses(cls);
        ev.setScoreKnowledge(req.getScoreKnowledge());
        ev.setScoreMethod(req.getScoreMethod());
        ev.setScoreInteraction(req.getScoreInteraction());
        ev.setScoreMaterials(req.getScoreMaterials());
        ev.setScorePunctuality(req.getScorePunctuality());
        ev.setComment(req.getComment());
        evaluationRepository.save(ev);
    }

    // ── PAYMENTS ─────────────────────────────────────────────────────────────
    public org.learn.learningmanagementbackend.dto.response.TuitionPaymentDto createPayment(String studentCode, org.learn.learningmanagementbackend.dto.request.PaymentCreateRequest req) {
        org.learn.learningmanagementbackend.model.Student st = studentRepository.findByStudentCode(studentCode)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy sinh viên"));
        org.learn.learningmanagementbackend.model.TuitionInvoice invoice = tuitionInvoiceRepository.findByStudentIdAndSemesterId(st.getId(), req.getSemesterId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy hóa đơn học phí cho học kỳ này"));
        
        org.learn.learningmanagementbackend.model.TuitionPayment payment = new org.learn.learningmanagementbackend.model.TuitionPayment();
        payment.setTuitionInvoice(invoice);
        payment.setAmount(req.getTotalAmount());
        payment.setPaymentMethod(req.getPaymentMethod());
        payment.setPaymentDate(java.time.LocalDateTime.now());
        payment.setStatus(org.learn.learningmanagementbackend.enums.TuitionPaymentStatus.PENDING);
        payment.setTransactionCode("HUIT" + java.util.UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 16));
        
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            if (req.getCourses() != null) {
                for (int i = 0; i < req.getCourses().size(); i++) {
                    var c = req.getCourses().get(i);
                    sb.append("{");
                    sb.append("\"classCode\":\"").append(c.getClassCode()).append("\",");
                    sb.append("\"courseCode\":\"").append(c.getCourseCode()).append("\",");
                    sb.append("\"courseName\":\"").append(c.getCourseName()).append("\",");
                    sb.append("\"credits\":").append(c.getCredits()).append(",");
                    sb.append("\"amount\":").append(c.getAmount());
                    sb.append("}");
                    if (i < req.getCourses().size() - 1) sb.append(",");
                }
            }
            sb.append("]");
            payment.setCourseData(sb.toString());
        } catch (Exception e) {
            payment.setCourseData("[]");
        }
        
        tuitionPaymentRepository.save(payment);
        return mapToPaymentDto(payment);
    }

    public List<org.learn.learningmanagementbackend.dto.response.TuitionPaymentDto> getPayments(String studentCode) {
        org.learn.learningmanagementbackend.model.Student st = studentRepository.findByStudentCode(studentCode)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy sinh viên"));
        return tuitionPaymentRepository.findByStudentId(st.getId()).stream()
                .map(this::mapToPaymentDto).toList();
    }

    @Transactional
    public void cancelPayment(String studentCode, Integer paymentId) {
        org.learn.learningmanagementbackend.model.TuitionPayment payment = tuitionPaymentRepository.findById(paymentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy giao dịch"));
        if (!payment.getTuitionInvoice().getStudent().getStudentCode().equals(studentCode)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Không có quyền truy cập giao dịch này");
        }
        if (payment.getStatus() != org.learn.learningmanagementbackend.enums.TuitionPaymentStatus.PENDING) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Chỉ có thể hủy giao dịch đang xử lý");
        }
        payment.setStatus(org.learn.learningmanagementbackend.enums.TuitionPaymentStatus.FAILED);
        tuitionPaymentRepository.save(payment);
    }

    @Transactional
    public void mockPaymentSuccess(String studentCode, Integer paymentId) {
        org.learn.learningmanagementbackend.model.TuitionPayment payment = tuitionPaymentRepository.findById(paymentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy giao dịch"));
        if (!payment.getTuitionInvoice().getStudent().getStudentCode().equals(studentCode)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Không có quyền truy cập giao dịch này");
        }
        if (payment.getStatus() != org.learn.learningmanagementbackend.enums.TuitionPaymentStatus.PENDING) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Giao dịch không ở trạng thái chờ xử lý");
        }
        payment.setStatus(org.learn.learningmanagementbackend.enums.TuitionPaymentStatus.SUCCESS);
        payment.setPaymentDate(java.time.LocalDateTime.now());
        tuitionPaymentRepository.save(payment);

        // Update the invoice paid amount
        org.learn.learningmanagementbackend.model.TuitionInvoice invoice = payment.getTuitionInvoice();
        invoice.setPaidAmount(invoice.getPaidAmount().add(payment.getAmount()));
        if (invoice.getPaidAmount().compareTo(invoice.getTotalAmount()) >= 0) {
            invoice.setStatus(org.learn.learningmanagementbackend.enums.TuitionInvoiceStatus.PAID);
        } else if (invoice.getPaidAmount().compareTo(java.math.BigDecimal.ZERO) > 0) {
            invoice.setStatus(org.learn.learningmanagementbackend.enums.TuitionInvoiceStatus.PARTIAL);
        }
        tuitionInvoiceRepository.save(invoice);
    }

    public List<org.learn.learningmanagementbackend.dto.response.ScholarshipDto> getScholarships(String studentCode) {
        org.learn.learningmanagementbackend.model.Student st = studentRepository.findByStudentCode(studentCode)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy sinh viên"));

        List<org.learn.learningmanagementbackend.dto.response.ScholarshipDto> results = new java.util.ArrayList<>();
        List<org.learn.learningmanagementbackend.model.Semester> semesters = semesterRepository.findAll();

        for (org.learn.learningmanagementbackend.model.Semester sem : semesters) {
            List<org.learn.learningmanagementbackend.model.Enrollment> enrollments = enrollmentRepository.findByStudentIdAndSemesterIdAndStatus(
                    st.getId(), sem.getId(), org.learn.learningmanagementbackend.enums.EnrollmentStatus.ENROLLED);
            
            if (enrollments.isEmpty()) continue;
            
            int totalCredits = 0;
            java.math.BigDecimal totalPoints = java.math.BigDecimal.ZERO;
            boolean hasScoreUnder5 = false;
            
            for (org.learn.learningmanagementbackend.model.Enrollment e : enrollments) {
                int credits = e.getClasses().getCourse().getCredits() != null ? e.getClasses().getCourse().getCredits() : 0;
                totalCredits += credits;
                
                java.math.BigDecimal grade = e.getGradeTotal() != null ? new java.math.BigDecimal(e.getGradeTotal().toString()) : null;
                if (grade == null) {
                    hasScoreUnder5 = true;
                } else {
                    if (grade.compareTo(new java.math.BigDecimal("5.0")) < 0) {
                        hasScoreUnder5 = true;
                    }
                    totalPoints = totalPoints.add(grade.multiply(new java.math.BigDecimal(credits)));
                }
            }
            
            java.math.BigDecimal gpa = java.math.BigDecimal.ZERO;
            String academicRank = "Không xét";
            if (totalCredits > 0) {
                gpa = totalPoints.divide(new java.math.BigDecimal(totalCredits), 2, java.math.RoundingMode.HALF_UP);
            }
            
            if (totalCredits >= 15 && !hasScoreUnder5) {
                if (gpa.compareTo(new java.math.BigDecimal("9.0")) >= 0) academicRank = "Xuất sắc";
                else if (gpa.compareTo(new java.math.BigDecimal("8.0")) >= 0) academicRank = "Giỏi";
                else if (gpa.compareTo(new java.math.BigDecimal("7.0")) >= 0) academicRank = "Khá";
            }
            
            String conductRank = "Không xét";
            int conductScore = 0;
            java.util.Optional<org.learn.learningmanagementbackend.model.StudentSemesterSummary> summaryOpt = 
                    studentSemesterSummaryRepository.findByStudentIdAndSemesterId(st.getId(), sem.getId());
            if (summaryOpt.isPresent() && summaryOpt.get().getConductScore() != null) {
                conductScore = summaryOpt.get().getConductScore();
                if (conductScore >= 90) conductRank = "Xuất sắc";
                else if (conductScore >= 80) conductRank = "Tốt";
                else if (conductScore >= 70) conductRank = "Khá";
            }
            
            String scholarshipType = "Không có";
            java.math.BigDecimal scholarshipAmount = java.math.BigDecimal.ZERO;
            java.math.BigDecimal tuitionFee = java.math.BigDecimal.ZERO;
            
            java.util.Optional<org.learn.learningmanagementbackend.model.TuitionInvoice> invoiceOpt = 
                    tuitionInvoiceRepository.findByStudentIdAndSemesterId(st.getId(), sem.getId());
            if (invoiceOpt.isPresent()) {
                tuitionFee = invoiceOpt.get().getTotalAmount() != null ? invoiceOpt.get().getTotalAmount() : java.math.BigDecimal.ZERO;
            }
            
            if (academicRank.equals("Xuất sắc") && conductRank.equals("Xuất sắc")) {
                scholarshipType = "Xuất sắc";
                scholarshipAmount = tuitionFee;
            } else if ((academicRank.equals("Giỏi") && conductRank.equals("Xuất sắc")) ||
                       (academicRank.equals("Xuất sắc") && conductRank.equals("Tốt")) ||
                       (academicRank.equals("Giỏi") && conductRank.equals("Tốt"))) {
                scholarshipType = "Giỏi";
                scholarshipAmount = tuitionFee.multiply(new java.math.BigDecimal("0.60"));
            } else if ((academicRank.equals("Khá") && (conductRank.equals("Xuất sắc") || conductRank.equals("Tốt") || conductRank.equals("Khá"))) ||
                       (academicRank.equals("Giỏi") && conductRank.equals("Khá")) ||
                       (academicRank.equals("Xuất sắc") && conductRank.equals("Khá"))) {
                scholarshipType = "Khá";
                scholarshipAmount = tuitionFee.multiply(new java.math.BigDecimal("0.40"));
            }
            
            results.add(org.learn.learningmanagementbackend.dto.response.ScholarshipDto.builder()
                    .id(sem.getId())
                    .semesterName(sem.getName())
                    .gpa(gpa)
                    .totalCredits(totalCredits)
                    .academicRank(academicRank)
                    .conductRank(conductRank)
                    .scholarshipType(scholarshipType)
                    .scholarshipAmount(scholarshipAmount)
                    .build());
        }
        
        return results;
    }

    private org.learn.learningmanagementbackend.dto.response.TuitionPaymentDto mapToPaymentDto(org.learn.learningmanagementbackend.model.TuitionPayment p) {
        return org.learn.learningmanagementbackend.dto.response.TuitionPaymentDto.builder()
                .id(p.getId())
                .transactionCode(p.getTransactionCode())
                .amount(p.getAmount())
                .paymentMethod(p.getPaymentMethod())
                .paymentDate(p.getPaymentDate())
                .status(p.getStatus())
                .note(p.getNote())
                .courseData(p.getCourseData())
                .build();
    }
}

