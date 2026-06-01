package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.GradeSaveRequest;
import org.learn.learningmanagementbackend.dto.response.GradeManagementResponse;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;
import org.learn.learningmanagementbackend.enums.ClassStatus;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;
import org.learn.learningmanagementbackend.model.Classes;
import org.learn.learningmanagementbackend.model.Enrollment;
import org.learn.learningmanagementbackend.repository.LecturerRepository.AttendanceRecordRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ClassRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.EnrollmentRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.enums.NotificationType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GradeService {

    private final EnrollmentRepository enrollmentRepository;
    private final ClassRepository classRepository;
    private final ScheduleRepository scheduleRepository;
    private final AttendanceRecordRepository attendanceRepository;
    private final NotificationRepository notificationRepository;


    public GradeManagementResponse getClassGrades(Integer classId) {
        Classes classObj = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy lớp học phần"));

        List<Enrollment> enrollments = enrollmentRepository.getEnrolledStudentsByClassId(classId);

        // Chuẩn bị dữ liệu tính chuyên cần
        long totalSessions = scheduleRepository.countTotalSessionsByClassId(classId);
        Map<Integer, Long> presentCounts = getPresentCountMap(classId);

        List<GradeManagementResponse.StudentGradeDto> studentDtos = enrollments.stream().map(e -> {
            Integer studentId = e.getStudent().getId();

            // Tính điểm CC
            double cc = calculateCC(studentId, presentCounts, totalSessions);

            // Tạm tính điểm tổng kết
            Double total = e.getGradeTotal();
            if (e.getGradeMidterm() != null && e.getGradeFinal() != null) {
                total = round((cc * 0.1) + (e.getGradeMidterm() * 0.3) + (e.getGradeFinal() * 0.6), 1);
            }

            return GradeManagementResponse.StudentGradeDto.builder()
                    .enrollmentId(e.getId())
                    .fullName(e.getStudent().getUser().getFullName())
                    .studentCode(e.getStudent().getStudentCode())
                    .cc(cc)
                    .gk(e.getGradeMidterm())
                    .ck(e.getGradeFinal())
                    .total(total)
                    .classification(getGradeClassification(total))
                    .build();
        }).collect(Collectors.toList());

        int passCount = 0, failCount = 0, excellentCount = 0, gradedCount = 0;
        double sumTotal = 0;

        for (GradeManagementResponse.StudentGradeDto dto : studentDtos) {
            if (dto.getTotal() != null) {
                if (dto.getTotal() >= 5.0) passCount++;
                else failCount++;

                if (dto.getTotal() >= 9.0) excellentCount++;

                sumTotal += dto.getTotal();
                gradedCount++;
            }
        }

        // Tính điểm trung bình của lớp
        double classAvg = (gradedCount > 0) ? round(sumTotal / gradedCount, 1) : 0.0;

        return GradeManagementResponse.builder()
                .classAverage(classAvg)
                .passedCount(passCount)
                .failedCount(failCount)
                .excellentCount(excellentCount)
                .isLocked(classObj.getStatus().equals(ClassStatus.COMPLETED))
                .students(studentDtos)
                .build();
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveGrades(GradeSaveRequest request) {
        Classes classObj = classRepository.findById(request.getClassId())
                .orElseThrow(() -> new RuntimeException("Lớp học không tồn tại"));

        if (classObj.getStatus().equals(ClassStatus.COMPLETED)) {
            throw new RuntimeException("Bảng điểm này đã bị khóa, không thể chỉnh sửa!");
        }

        long totalSessions = scheduleRepository.countTotalSessionsByClassId(request.getClassId());
        Map<Integer, Long> presentCounts = getPresentCountMap(request.getClassId());

        for (GradeSaveRequest.GradeInput input : request.getGrades()) {
            Enrollment enrollment = enrollmentRepository.findById(input.getEnrollmentId()).orElse(null);

            if (enrollment != null) {
                Integer studentId = enrollment.getStudent().getId();
                double cc = calculateCC(studentId, presentCounts, totalSessions);

                enrollment.setGradeAttendance(cc);       // Tự động gán CC
                enrollment.setGradeMidterm(input.getGk());
                enrollment.setGradeFinal(input.getCk());

                if (input.getGk() != null && input.getCk() != null) {
                    double calculatedTotal = (cc * 0.1) + (input.getGk() * 0.3) + (input.getCk() * 0.6);
                    enrollment.setGradeTotal(round(calculatedTotal, 1));
                }

                enrollmentRepository.save(enrollment);
            }
        }
    }


    @Transactional
    public void lockGrades(Integer classId) {
        Classes classObj = classRepository.findById(classId).orElseThrow();
        classObj.setStatus(ClassStatus.COMPLETED);
        classRepository.save(classObj);

        List<Enrollment> enrollments = enrollmentRepository.getEnrolledStudentsByClassId(classId);
        for (Enrollment e : enrollments) {
            if (e.getGradeTotal() != null) {
                e.setStatus(e.getGradeTotal() >= 5.0 ? EnrollmentStatus.COMPLETED : EnrollmentStatus.FAILED);
            }
            
            Notification notif = new Notification();
            notif.setUser(e.getStudent().getUser());
            notif.setType(NotificationType.GRADE);
            notif.setTitle("Điểm thi đã được công bố");
            notif.setBody("Giảng viên đã khóa bảng điểm lớp " + classObj.getCode() + ". Bạn có thể xem điểm tổng kết của mình ngay bây giờ.");
            notificationRepository.save(notif);
        }
        enrollmentRepository.saveAll(enrollments);
    }

    // --- HELPER METHODS ---

    private Map<Integer, Long> getPresentCountMap(Integer classId) {
        List<Object[]> rawCounts = attendanceRepository.countSessionsByClassIdAndStatus(classId, AttendanceStatus.PRESENT);
        return rawCounts.stream()
                .collect(Collectors.toMap(
                        row -> (Integer) row[0], // student_id
                        row -> (Long) row[1]     // count
                ));
    }

    private double calculateCC(Integer studentId, Map<Integer, Long> presentCounts, long totalSessions) {
        if (totalSessions == 0) return 0.0;
        long attended = presentCounts.getOrDefault(studentId, 0L);
        return round(((double) attended / totalSessions) * 10.0, 1);
    }

    private String getGradeClassification(Double total) {
        if (total == null) return "";
        if (total >= 9.0) return "Xuất sắc";
        if (total >= 8.0) return "Giỏi";
        if (total >= 7.0) return "Khá";
        if (total >= 5.0) return "Trung bình";
        return "Không đạt";
    }

    private double round(double value, int places) {
        BigDecimal bd = BigDecimal.valueOf(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }
}