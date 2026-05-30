package org.learn.learningmanagementbackend.controller.SaasAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SaasDashboardStatsResponse;
import org.learn.learningmanagementbackend.service.SaasAdminService.SaasDashboardService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController("saasAdminDashboardController")
@RequestMapping("/api/saas-admin/dashboard")
@RequiredArgsConstructor
public class SaasDashboardController {

    private final SaasDashboardService dashboardService;

    @GetMapping("/stats")
    public ResponseEntity<SaasDashboardStatsResponse> getStats() {
        return ResponseEntity.ok(dashboardService.getDashboardStats());
    }
}
