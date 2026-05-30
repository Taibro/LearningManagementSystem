package org.learn.learningmanagementbackend.controller.SaasAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.CreateTenantRequest;
import org.learn.learningmanagementbackend.dto.request.UpdateTenantStatusRequest;
import org.learn.learningmanagementbackend.dto.response.TenantResponse;
import org.learn.learningmanagementbackend.service.SaasAdminService.TenantService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/saas-admin/tenants")
@RequiredArgsConstructor
public class TenantController {

    private final TenantService tenantService;

    @GetMapping
    public ResponseEntity<List<TenantResponse>> getAllTenants() {
        return ResponseEntity.ok(tenantService.getAllTenants());
    }

    @GetMapping("/{id}")
    public ResponseEntity<TenantResponse> getTenantDetail(@PathVariable Integer id) {
        return ResponseEntity.ok(tenantService.getTenantDetail(id));
    }

    @PostMapping
    public ResponseEntity<TenantResponse> createTenant(@RequestBody CreateTenantRequest request) {
        return ResponseEntity.ok(tenantService.createTenant(request));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<Map<String, String>> toggleTenantStatus(
            @PathVariable Integer id,
            @RequestBody UpdateTenantStatusRequest request) {
        tenantService.toggleTenantStatus(id, request.getIsActive());
        String message = request.getIsActive() ? "Đã mở khoá tenant" : "Đã khoá tenant";
        return ResponseEntity.ok(Map.of("message", message));
    }
}
