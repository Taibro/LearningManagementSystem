package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.MakeupSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.CancelledSessionResponse;
import org.learn.learningmanagementbackend.dto.response.MakeupHistoryResponse;
import org.learn.learningmanagementbackend.enums.MakeupStatus;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleExceptionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MakeupClassService {

    private final ScheduleExceptionRepository exceptionRepository;

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

        exceptionRepository.save(exception);
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