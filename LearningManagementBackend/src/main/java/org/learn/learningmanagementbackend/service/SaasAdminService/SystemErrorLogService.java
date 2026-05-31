package org.learn.learningmanagementbackend.service.SaasAdminService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SystemErrorLogResponse;
import org.learn.learningmanagementbackend.model.SystemErrorLog;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SystemErrorLogRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SystemErrorLogService {

    private final SystemErrorLogRepository errorLogRepository;

    public List<SystemErrorLogResponse> getAllLogs() {
        List<SystemErrorLog> logs = errorLogRepository.findAllByOrderByCreatedAtDesc();
        List<SystemErrorLogResponse> responses = new ArrayList<>();
        for (SystemErrorLog log : logs) {
            responses.add(mapToResponse(log));
        }
        return responses;
    }

    public List<SystemErrorLogResponse> getLogsByStatus(Boolean resolved) {
        List<SystemErrorLog> logs = errorLogRepository.findByIsResolved(resolved);
        List<SystemErrorLogResponse> responses = new ArrayList<>();
        for (SystemErrorLog log : logs) {
            responses.add(mapToResponse(log));
        }
        return responses;
    }

    @Transactional
    public void markResolved(Long logId) {
        SystemErrorLog log = errorLogRepository.findById(logId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy log với ID: " + logId));
        log.setIsResolved(true);
        errorLogRepository.save(log);
    }

    /**
     * Ghi lỗi thủ công từ bất kỳ service nào trong hệ thống.
     * Sử dụng khi muốn log lỗi nhưng không throw exception.
     */
    public void logError(String endpoint, String errorMessage, String stackTrace) {
        try {
            SystemErrorLog log = new SystemErrorLog();
            log.setEndpoint(endpoint);
            log.setErrorMessage(errorMessage);
            log.setStackTrace(stackTrace);
            log.setIsResolved(false);
            errorLogRepository.save(log);
        } catch (Exception ignored) {
            System.err.println("[MANUAL ERROR LOG FAILED] " + ignored.getMessage());
        }
    }

    private SystemErrorLogResponse mapToResponse(SystemErrorLog log) {
        SystemErrorLogResponse res = new SystemErrorLogResponse();
        res.setId(log.getId());
        res.setEndpoint(log.getEndpoint());
        res.setErrorMessage(log.getErrorMessage());
        res.setStackTrace(log.getStackTrace());
        res.setUserAgent(log.getUserAgent());
        res.setSchoolName(log.getSchool() != null ? log.getSchool().getName() : "System");
        res.setIsResolved(log.getIsResolved());
        res.setCreatedAt(log.getCreatedAt());
        return res;
    }
}
