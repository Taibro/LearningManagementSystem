package org.learn.learningmanagementbackend.controller.SaasAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SystemErrorLogResponse;
import org.learn.learningmanagementbackend.service.SaasAdminService.SystemErrorLogService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/saas-admin/logs")
@RequiredArgsConstructor
public class SystemErrorLogController {

    private final SystemErrorLogService errorLogService;

    @GetMapping
    public ResponseEntity<List<SystemErrorLogResponse>> getAllLogs(
            @RequestParam(required = false) Boolean resolved) {
        if (resolved != null) {
            return ResponseEntity.ok(errorLogService.getLogsByStatus(resolved));
        }
        return ResponseEntity.ok(errorLogService.getAllLogs());
    }

    @PatchMapping("/{id}/resolve")
    public ResponseEntity<Map<String, String>> markResolved(@PathVariable Long id) {
        errorLogService.markResolved(id);
        return ResponseEntity.ok(Map.of("message", "Đã đánh dấu lỗi là Resolved"));
    }
}
