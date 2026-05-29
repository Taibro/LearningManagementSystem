package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SubstituteSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.SubstituteHistoryResponse;
import org.learn.learningmanagementbackend.dto.response.TeacherDropdownResponse;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleExceptionRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SubstituteTeachingService {

    private final ScheduleExceptionRepository exceptionRepository;
    private final TeacherRepository teacherRepository;
    private final ScheduleRepository scheduleRepository;

    // Đổ danh sách GV dạy thay phải cùng bộ môn
    public List<TeacherDropdownResponse> getEligibleSubstituteTeachers(String currentTeacherCode) {
        Teacher currentTeacher = teacherRepository.findByTeacherCode(currentTeacherCode)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin giảng viên!"));

        List<Teacher> colleagues = teacherRepository.findColleaguesInSameDepartment(
                currentTeacher.getDepartment().getId(), currentTeacherCode);

        return colleagues.stream().map(t -> TeacherDropdownResponse.builder()
                .teacherId(t.getId())
                .displayLabel(t.getUser().getFullName() + " - " + t.getDepartment().getName())
                .build()
        ).collect(Collectors.toList());
    }

    // Submit form Đề xuất
    @Transactional(rollbackFor = Exception.class)
    public void submitSubstituteRequest(String teacherCode, SubstituteSubmitRequest request) {

        // Kiểm tra trước 24 giờ
        long daysUntilClass = ChronoUnit.DAYS.between(LocalDate.now(), request.getExceptionDate());
        if (daysUntilClass < 1) {
            throw new RuntimeException("Lỗi: Đề xuất cần gửi trước buổi dạy ít nhất 24 giờ theo quy chế!");
        }

        // Kiểm tra chính chủ ca học
        boolean isOwner = exceptionRepository.isScheduleOwnedByTeacher(request.getScheduleId(), teacherCode);
        if (!isOwner) throw new RuntimeException("Bạn không có quyền thao tác trên buổi học này!");

        // Kiểm tra GV dạy thay có tồn tại không
        Teacher substituteTeacher = teacherRepository.findById(request.getSubstituteTeacherId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin giảng viên dạy thay!"));

        // Tạo Exception MỚI
        ScheduleException exception = new ScheduleException();
        exception.setSchedule(scheduleRepository.getReferenceById(request.getScheduleId()));
        exception.setExceptionDate(request.getExceptionDate());
        exception.setReason(request.getReason());

        exception.setExceptionType(ExceptionType.SUBSTITUTED);
        exception.setSubstituteTeacher(substituteTeacher);
        exception.setSubstituteContent(request.getSubstituteContent());
        exception.setSubstituteStatus(ApprovalStatus.PENDING); // Chờ duyệt

        exceptionRepository.save(exception);
    }

    // Lấy lịch sử
    public List<SubstituteHistoryResponse> getHistory(String teacherCode) {
        List<ScheduleException> history = exceptionRepository.findSubstituteHistoryByTeacherCode(teacherCode);

        return history.stream().map(ex -> {
            String title = ex.getSchedule().getClasses().getCode() +
                    " - Tiết " + ex.getSchedule().getStartPeriod() + "-" + ex.getSchedule().getEndPeriod();

            return SubstituteHistoryResponse.builder()
                    .exceptionId(ex.getId())
                    .title(title)
                    .status(ex.getSubstituteStatus().name())
                    .build();
        }).collect(Collectors.toList());
    }
}