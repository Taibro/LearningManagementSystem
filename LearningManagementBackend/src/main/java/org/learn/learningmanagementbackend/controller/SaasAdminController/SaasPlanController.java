package org.learn.learningmanagementbackend.controller.SaasAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SaasPlanRequest;
import org.learn.learningmanagementbackend.dto.response.SaasPlanResponse;
import org.learn.learningmanagementbackend.service.SaasAdminService.SaasPlanService;
import org.learn.learningmanagementbackend.security.AuditAction;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/saas-admin/plans")
@RequiredArgsConstructor
public class SaasPlanController {

    private final SaasPlanService planService;

    @GetMapping
    public ResponseEntity<List<SaasPlanResponse>> getAllPlans() {
        return ResponseEntity.ok(planService.getAllPlans());
    }

    @PostMapping
    @AuditAction(action = "CREATE", tableName = "saas_plans")
    public ResponseEntity<SaasPlanResponse> createPlan(@RequestBody SaasPlanRequest request) {
        return ResponseEntity.ok(planService.createPlan(request));
    }

    @PutMapping("/{id}")
    @AuditAction(action = "UPDATE", tableName = "saas_plans")
    public ResponseEntity<SaasPlanResponse> updatePlan(@PathVariable Integer id, @RequestBody SaasPlanRequest request) {
        return ResponseEntity.ok(planService.updatePlan(id, request));
    }
}
