package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.MakeupSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.CancelledSessionResponse;
import org.learn.learningmanagementbackend.dto.response.MakeupHistoryResponse;
import org.learn.learningmanagementbackend.enums.MakeupStatus;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleExceptionRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.enums.NotificationType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.EntityManager;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MakeupClassService {

    private final ScheduleExceptionRepository exceptionRepository;
    private final NotificationRepository notificationRepository;
    private final EntityManager entityManager;

    // 1. Lấy dữ liệu Dropdown Buổi nghỉ gốc
    public List<CancelledSessionResponse> getAvailableCancelledSessions(String teacherCode) {
        List<ScheduleException> sessions = exceptionRepository.findAvailableCancelledSessions(teacherCode);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        return sessions.stream().map(se -> CancelledSessionResponse.builder()
                .exceptionId(se.getId())
                .displayLabel(se.getExceptionDate().format(formatter) + " - " + se.getSchedule().getClasses().getCode())
                .build()
        ).collect(Collectors.toList());
    }

    @Transactional(rollbackFor = Exception.class)
    public void submitMakeupRequest(String teacherCode, MakeupSubmitRequest request) {

        // Tiết bắt đầu không được lớn hơn tiết kết thúc
        if (request.getReplacementStartPeriod() > request.getReplacementEndPeriod()) {
            throw new RuntimeException("Tiết bắt đầu không được lớn hơn tiết kết thúc!");
        }

        ScheduleException exception = exceptionRepository.findById(request.getExceptionId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi nghỉ gốc!"));

        boolean isOwner = exceptionRepository.isScheduleOwnedByTeacher(exception.getSchedule().getId(), teacherCode);
        if (!isOwner) throw new RuntimeException("Bạn không có quyền thao tác trên buổi học này!");

        exception.setReplacementDate(request.getMakeupDate());
        exception.setReplacementStartPeriod(request.getReplacementStartPeriod());
        exception.setReplacementEndPeriod(request.getReplacementEndPeriod());
        exception.setSuggestedRoom(request.getSuggestedRoom());
        exception.setMakeupNotes(request.getMakeupNotes());

        exception.setMakeupStatus(MakeupStatus.PENDING);

        ScheduleException savedException = exceptionRepository.save(exception);

        // Notify School Admins
        try {
            Integer schoolId = savedException.getSchedule().getClasses().getCourse().getDepartment().getSchool().getId();
            List<Users> admins = entityManager.createQuery(
                "SELECT us.user FROM UserSchool us JOIN us.user.roles r WHERE us.school.id = :schoolId AND r.name = 'ROLE_SCHOOL_ADMIN'", Users.class)
                .setParameter("schoolId", schoolId)
                .getResultList();

            for (Users admin : admins) {
                Notification notif = new Notification();
                notif.setUser(admin);
                notif.setType(NotificationType.SYSTEM);
                notif.setTitle("Yêu cầu dạy bù mới");
                notif.setBody("Giảng viên có mã " + teacherCode + " vừa gửi một yêu cầu dạy bù cho lớp " + 
                              savedException.getSchedule().getClasses().getCode() + " vào ngày " + 
                              (request.getMakeupDate() != null ? request.getMakeupDate().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "") + 
                              ". Vui lòng kiểm tra và phê duyệt.");
                notificationRepository.save(notif);
            }
        } catch (Exception e) {
            // Ignore if fails to notify admins
        }
    }

    public List<MakeupHistoryResponse> getMakeupHistory(String teacherCode) {
        List<ScheduleException> history = exceptionRepository.findMakeupHistoryByTeacherCode(teacherCode);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        return history.stream().map(ex -> {
            String origDateStr = ex.getExceptionDate().format(formatter);
            String repDateStr = ex.getReplacementDate().format(formatter);

            String title = ex.getSchedule().getClasses().getCode() + " - Bù " + origDateStr;

            // Format hiển thị thành: "Tiết 1-3, Phòng A401, 15/03/2026"
            String details = "Tiết " + ex.getReplacementStartPeriod() + "-" + ex.getReplacementEndPeriod()
                    + ", Phòng " + (ex.getSuggestedRoom() != null ? ex.getSuggestedRoom() : "Chờ xếp")
                    + ", " + repDateStr;

            return MakeupHistoryResponse.builder()
                    .exceptionId(ex.getId())
                    .title(title)
                    .makeupDetails(details)
                    .status(ex.getMakeupStatus().name())
                    .build();
        }).collect(Collectors.toList());
    }
}