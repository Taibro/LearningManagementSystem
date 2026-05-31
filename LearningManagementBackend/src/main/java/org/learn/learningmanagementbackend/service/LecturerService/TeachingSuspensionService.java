package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.constant.AppConstants;
import org.learn.learningmanagementbackend.dto.request.SuspensionSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.SuspensionHistoryResponse;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleExceptionRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.enums.NotificationType;
import org.learn.learningmanagementbackend.service.FileStorageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import jakarta.persistence.EntityManager;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TeachingSuspensionService {

    private final ScheduleExceptionRepository exceptionRepository;
    private final ScheduleRepository scheduleRepository;
    private final FileStorageService fileStorageService;
    private final NotificationRepository notificationRepository;
    private final EntityManager entityManager;

    @Transactional(rollbackFor = Exception.class)
    public void submitSuspensionRequest(String teacherCode, SuspensionSubmitRequest request, MultipartFile proofFile) {

        boolean isOwner = exceptionRepository.isScheduleOwnedByTeacher(request.getScheduleId(), teacherCode);
        if (!isOwner) {
            throw new RuntimeException("Bạn không có quyền thao tác trên ca học này!");
        }

        String fileUrl = null;

        // Xử lý upload file
        if (proofFile != null && !proofFile.isEmpty()) {
            fileStorageService.validateAcademicAndImageFiles(proofFile);
            fileUrl = fileStorageService.uploadFileToCloud(proofFile, AppConstants.FOLDER_SUSPENSION_PROOFS);
        }

        ScheduleException exception = new ScheduleException();
        exception.setSchedule(scheduleRepository.getReferenceById(request.getScheduleId()));
        exception.setExceptionDate(request.getExceptionDate());
        exception.setReason(request.getReason());
        exception.setExceptionType(ExceptionType.CANCELLED);
        exception.setApprovalStatus(ApprovalStatus.PENDING);
        exception.setProofFileUrl(fileUrl);

        ScheduleException savedException = exceptionRepository.save(exception);

        // Notify School Admins
        try {
            Integer schoolId = savedException.getSchedule().getClasses().getCourse().getDepartment().getSchool().getId();
            List<Users> admins = entityManager.createQuery(
                "SELECT u FROM Users u JOIN u.roles r WHERE u.school.id = :schoolId AND r.name = 'ROLE_SCHOOL_ADMIN'", Users.class)
                .setParameter("schoolId", schoolId)
                .getResultList();

            for (Users admin : admins) {
                Notification notif = new Notification();
                notif.setUser(admin);
                notif.setType(NotificationType.SYSTEM);
                notif.setTitle("Yêu cầu tạm ngừng giảng dạy mới");
                notif.setBody("Giảng viên có mã " + teacherCode + " vừa gửi một yêu cầu tạm ngừng giảng dạy cho lớp " + 
                              savedException.getSchedule().getClasses().getCode() + " vào ngày " + 
                              (request.getExceptionDate() != null ? request.getExceptionDate().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "") + 
                              ". Vui lòng kiểm tra và phê duyệt.");
                notificationRepository.save(notif);
            }
        } catch (Exception e) {
            // Ignore if fails to notify admins
        }
    }

    public List<SuspensionHistoryResponse> getTeacherSuspensionHistory(String teacherCode) {
        List<ScheduleException> history = exceptionRepository.findHistoryByTeacherCode(teacherCode);

        return history.stream().map(ex -> SuspensionHistoryResponse.builder()
                .exceptionId(ex.getId())
                .classCode(ex.getSchedule().getClasses().getCode())
                .exceptionDate(ex.getExceptionDate())
                .reason(ex.getReason())
                .status(ex.getApprovalStatus().toString())
                .createdAt(ex.getCreatedAt())
                .build()
        ).collect(Collectors.toList());
    }
}