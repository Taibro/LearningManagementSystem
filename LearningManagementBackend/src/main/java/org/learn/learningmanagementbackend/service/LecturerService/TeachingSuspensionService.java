package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SuspensionSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.SuspensionHistoryResponse;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleExceptionRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TeachingSuspensionService {

    private final ScheduleExceptionRepository exceptionRepository;
    private final ScheduleRepository scheduleRepository;
    private final FileStorageService fileStorageService;

    @Transactional(rollbackFor = Exception.class)
    public void submitSuspensionRequest(SuspensionSubmitRequest request) {

        String fileUrl = null;

        if (request.getProofFile() != null && !request.getProofFile().isEmpty()) {
            fileUrl = fileStorageService.uploadFileToCloud(request.getProofFile(), "eduspace_materials/suspension_proofs");
        }
        ScheduleException exception = new ScheduleException();
        exception.setSchedule(scheduleRepository.getReferenceById(request.getScheduleId()));
        exception.setExceptionDate(request.getExceptionDate());
        exception.setReason(request.getReason());
        exception.setExceptionType(ExceptionType.CANCELLED);
        exception.setApprovalStatus(ApprovalStatus.PENDING);
        exception.setProofFileUrl(fileUrl);

        exceptionRepository.save(exception);
    }

    public List<SuspensionHistoryResponse> getTeacherSuspensionHistory(String teacherCode) {
        List<ScheduleException> history = exceptionRepository.findExceptionHistoryByTeacherCode(teacherCode);

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