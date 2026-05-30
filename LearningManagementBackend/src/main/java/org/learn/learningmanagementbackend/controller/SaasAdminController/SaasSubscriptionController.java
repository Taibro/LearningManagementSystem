package org.learn.learningmanagementbackend.controller.SaasAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SaasInvoiceResponse;
import org.learn.learningmanagementbackend.dto.response.SaasSubscriptionStatsResponse;
import org.learn.learningmanagementbackend.service.SaasAdminService.SaasSubscriptionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/saas-admin/subscriptions")
@RequiredArgsConstructor
public class SaasSubscriptionController {

    private final SaasSubscriptionService subscriptionService;

    @GetMapping("/invoices")
    public ResponseEntity<List<SaasInvoiceResponse>> getAllInvoices(
            @RequestParam(required = false) String status) {
        if (status != null && !status.isEmpty()) {
            return ResponseEntity.ok(subscriptionService.getInvoicesByStatus(status));
        }
        return ResponseEntity.ok(subscriptionService.getAllInvoices());
    }

    @GetMapping("/stats")
    public ResponseEntity<SaasSubscriptionStatsResponse> getStats() {
        return ResponseEntity.ok(subscriptionService.getSubscriptionStats());
    }
}
