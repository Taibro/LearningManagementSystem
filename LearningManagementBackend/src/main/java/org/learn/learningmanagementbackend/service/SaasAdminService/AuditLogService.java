package org.learn.learningmanagementbackend.service.SaasAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.AuditLogResponse;
import org.learn.learningmanagementbackend.model.AuditLog;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.AuditLogRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AuditLogService {

    private final AuditLogRepository auditLogRepository;

    public List<AuditLogResponse> getAllAuditLogs() {
        List<AuditLog> logs = auditLogRepository.findAllByOrderByCreatedAtDesc();
        List<AuditLogResponse> responses = new ArrayList<>();
        for (AuditLog log : logs) {
            responses.add(mapToResponse(log));
        }
        return responses;
    }

    public List<AuditLogResponse> getAuditLogsByAction(String action) {
        List<AuditLog> logs = auditLogRepository.findByAction(action.toUpperCase());
        List<AuditLogResponse> responses = new ArrayList<>();
        for (AuditLog log : logs) {
            responses.add(mapToResponse(log));
        }
        return responses;
    }

    private AuditLogResponse mapToResponse(AuditLog log) {
        AuditLogResponse res = new AuditLogResponse();
        res.setId(log.getId());
        res.setCreatedAt(log.getCreatedAt());
        res.setUserEmail(log.getUserEmail());
        res.setSchoolName(log.getSchool() != null ? log.getSchool().getName() : "System");
        res.setAction(log.getAction());
        res.setTableName(log.getTableName());
        res.setRecordId(log.getRecordId());
        res.setIpAddress(log.getIpAddress());
        return res;
    }
}
