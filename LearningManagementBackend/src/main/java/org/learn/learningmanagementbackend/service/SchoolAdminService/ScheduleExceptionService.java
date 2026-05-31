package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ScheduleExceptionRequest;
import org.learn.learningmanagementbackend.dto.response.ScheduleExceptionResponse;
import org.learn.learningmanagementbackend.model.Room;
import org.learn.learningmanagementbackend.model.Schedule;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.RoomRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.ScheduleExceptionRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.ScheduleRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.TeacherRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.EnrollmentRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.NotificationRepository;
import org.learn.learningmanagementbackend.model.Notification;
import org.learn.learningmanagementbackend.model.Enrollment;
import org.learn.learningmanagementbackend.enums.NotificationType;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.MakeupStatus;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminScheduleExceptionService")
@RequiredArgsConstructor
public class ScheduleExceptionService {

    private final ScheduleExceptionRepository exceptionRepository;
    private final ScheduleRepository scheduleRepository;
    private final TeacherRepository teacherRepository;
    private final RoomRepository roomRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final NotificationRepository notificationRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<ScheduleExceptionResponse> getAllExceptions() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT u.school.id FROM Users u WHERE u.id = :userId", Integer.class)
                    .setParameter("userId", userId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<ScheduleException> exceptions = entityManager.createQuery("SELECT e FROM ScheduleException e WHERE e.schedule.classes.course.department.school.id = :schoolId", ScheduleException.class)
                .setParameter("schoolId", schoolId).getResultList();

        return exceptions.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<ScheduleExceptionResponse> getExceptionsBySchedule(Integer scheduleId) {
        return exceptionRepository.findByScheduleId(scheduleId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public ScheduleExceptionResponse getExceptionById(Integer id) {
        ScheduleException ex = exceptionRepository.findById(id).orElseThrow(() -> new RuntimeException("Exception not found"));
        return mapToResponse(ex);
    }

    public ScheduleExceptionResponse createException(ScheduleExceptionRequest request) {
        Schedule schedule = scheduleRepository.findById(request.getScheduleId())
                .orElseThrow(() -> new RuntimeException("Schedule not found"));

        ScheduleException ex = new ScheduleException();
        ex.setSchedule(schedule);
        ex.setExceptionDate(request.getExceptionDate());
        ex.setReason(request.getReason());
        ex.setExceptionType(request.getExceptionType());
        ex.setReplacementDate(request.getReplacementDate());
        ex.setApprovalStatus(request.getApprovalStatus());
        ex.setProofFileUrl(request.getProofFileUrl());
        ex.setReplacementStartPeriod(request.getReplacementStartPeriod());
        ex.setReplacementEndPeriod(request.getReplacementEndPeriod());
        ex.setSuggestedRoom(request.getSuggestedRoom());
        ex.setMakeupNotes(request.getMakeupNotes());
        ex.setMakeupStatus(request.getMakeupStatus());
        ex.setSubstituteContent(request.getSubstituteContent());
        ex.setSubstituteStatus(request.getSubstituteStatus());

        if (request.getSubstituteTeacherId() != null) {
            Teacher teacher = teacherRepository.findById(request.getSubstituteTeacherId())
                    .orElseThrow(() -> new RuntimeException("Teacher not found"));
            ex.setSubstituteTeacher(teacher);
        }

        if (request.getReplacementRoomId() != null) {
            Room room = roomRepository.findById(request.getReplacementRoomId())
                    .orElseThrow(() -> new RuntimeException("Room not found"));
            ex.setReplacementRoom(room);
        }

        return mapToResponse(exceptionRepository.save(ex));
    }

    public ScheduleExceptionResponse updateException(Integer id, ScheduleExceptionRequest request) {
        ScheduleException ex = exceptionRepository.findById(id).orElseThrow(() -> new RuntimeException("Exception not found"));

        ApprovalStatus oldApproval = ex.getApprovalStatus();
        MakeupStatus oldMakeup = ex.getMakeupStatus();

        if (!ex.getSchedule().getId().equals(request.getScheduleId())) {
            Schedule schedule = scheduleRepository.findById(request.getScheduleId())
                    .orElseThrow(() -> new RuntimeException("Schedule not found"));
            ex.setSchedule(schedule);
        }

        ex.setExceptionDate(request.getExceptionDate());
        ex.setReason(request.getReason());
        ex.setExceptionType(request.getExceptionType());
        ex.setReplacementDate(request.getReplacementDate());
        ex.setApprovalStatus(request.getApprovalStatus());
        ex.setProofFileUrl(request.getProofFileUrl());
        ex.setReplacementStartPeriod(request.getReplacementStartPeriod());
        ex.setReplacementEndPeriod(request.getReplacementEndPeriod());
        ex.setSuggestedRoom(request.getSuggestedRoom());
        ex.setMakeupNotes(request.getMakeupNotes());
        ex.setMakeupStatus(request.getMakeupStatus());
        ex.setSubstituteContent(request.getSubstituteContent());
        ex.setSubstituteStatus(request.getSubstituteStatus());

        if (request.getSubstituteTeacherId() != null) {
            Teacher teacher = teacherRepository.findById(request.getSubstituteTeacherId())
                    .orElseThrow(() -> new RuntimeException("Teacher not found"));
            ex.setSubstituteTeacher(teacher);
        } else {
            ex.setSubstituteTeacher(null);
        }

        if (request.getReplacementRoomId() != null) {
            Room room = roomRepository.findById(request.getReplacementRoomId())
                    .orElseThrow(() -> new RuntimeException("Room not found"));
            ex.setReplacementRoom(room);
        } else {
            ex.setReplacementRoom(null);
        }

        ScheduleException savedEx = exceptionRepository.save(ex);

        // Notify students upon Approval of Suspension
        if (oldApproval != ApprovalStatus.APPROVED && request.getApprovalStatus() == ApprovalStatus.APPROVED) {
            List<Enrollment> enrollments = enrollmentRepository.getEnrolledStudentsByClassId(savedEx.getSchedule().getClasses().getId());
            for (Enrollment e : enrollments) {
                Notification notif = new Notification();
                notif.setUser(e.getStudent().getUser());
                notif.setType(NotificationType.SCHEDULE_CHANGE);
                notif.setTitle("Thông báo nghỉ học");
                notif.setBody("Lớp học phần " + savedEx.getSchedule().getClasses().getCode() + " vào ngày " + 
                              (savedEx.getExceptionDate() != null ? savedEx.getExceptionDate().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "") + 
                              " đã được thông báo nghỉ.");
                notificationRepository.save(notif);
            }
        }

        // Notify students upon Approval of Makeup Class
        if (oldMakeup != MakeupStatus.APPROVED && request.getMakeupStatus() == MakeupStatus.APPROVED) {
            List<Enrollment> enrollments = enrollmentRepository.getEnrolledStudentsByClassId(savedEx.getSchedule().getClasses().getId());
            for (Enrollment e : enrollments) {
                Notification notif = new Notification();
                notif.setUser(e.getStudent().getUser());
                notif.setType(NotificationType.SCHEDULE_CHANGE);
                notif.setTitle("Thông báo học bù");
                notif.setBody("Lớp học phần " + savedEx.getSchedule().getClasses().getCode() + " có lịch học bù vào ngày " + 
                              (savedEx.getReplacementDate() != null ? savedEx.getReplacementDate().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "") + 
                              ", tiết " + savedEx.getReplacementStartPeriod() + "-" + savedEx.getReplacementEndPeriod() +
                              (savedEx.getReplacementRoom() != null ? ", phòng " + savedEx.getReplacementRoom().getRoomNumber() : "") + ".");
                notificationRepository.save(notif);
            }
        }

        return mapToResponse(savedEx);
    }

    public void deleteException(Integer id) {
        exceptionRepository.deleteById(id);
    }

    private ScheduleExceptionResponse mapToResponse(ScheduleException ex) {
        ScheduleExceptionResponse response = new ScheduleExceptionResponse();
        response.setId(ex.getId());
        response.setScheduleId(ex.getSchedule() != null ? ex.getSchedule().getId() : null);
        if (ex.getSchedule() != null && ex.getSchedule().getClasses() != null) {
            response.setScheduleDetails(ex.getSchedule().getClasses().getCode() + " - Thứ " + ex.getSchedule().getDayOfWeek());
        }
        response.setExceptionDate(ex.getExceptionDate());
        response.setReason(ex.getReason());
        response.setExceptionType(ex.getExceptionType());
        response.setReplacementDate(ex.getReplacementDate());
        response.setApprovalStatus(ex.getApprovalStatus());
        response.setProofFileUrl(ex.getProofFileUrl());
        response.setReplacementStartPeriod(ex.getReplacementStartPeriod());
        response.setReplacementEndPeriod(ex.getReplacementEndPeriod());
        response.setSuggestedRoom(ex.getSuggestedRoom());
        response.setMakeupNotes(ex.getMakeupNotes());
        response.setMakeupStatus(ex.getMakeupStatus());
        response.setSubstituteTeacherId(ex.getSubstituteTeacher() != null ? ex.getSubstituteTeacher().getId() : null);
        response.setSubstituteTeacherName(ex.getSubstituteTeacher() != null && ex.getSubstituteTeacher().getUser() != null ? ex.getSubstituteTeacher().getUser().getFullName() : null);
        response.setSubstituteContent(ex.getSubstituteContent());
        response.setSubstituteStatus(ex.getSubstituteStatus());
        response.setReplacementRoomId(ex.getReplacementRoom() != null ? ex.getReplacementRoom().getId() : null);
        response.setReplacementRoomNumber(ex.getReplacementRoom() != null ? ex.getReplacementRoom().getRoomNumber() : null);
        return response;
    }
}
