package org.learn.learningmanagementbackend.controller.SaasAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.AuditLogResponse;
import org.learn.learningmanagementbackend.service.SaasAdminService.AuditLogService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/saas-admin/audit")
@RequiredArgsConstructor
public class AuditLogController {

    private final AuditLogService auditLogService;

    @GetMapping
    public ResponseEntity<List<AuditLogResponse>> getAllAuditLogs(
            @RequestParam(required = false) String action) {
        if (action != null && !action.isEmpty()) {
            return ResponseEntity.ok(auditLogService.getAuditLogsByAction(action));
        }
        return ResponseEntity.ok(auditLogService.getAllAuditLogs());
    }
}
