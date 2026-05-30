package org.learn.learningmanagementbackend.service.SaasAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SaasInvoiceResponse;
import org.learn.learningmanagementbackend.dto.response.SaasSubscriptionStatsResponse;
import org.learn.learningmanagementbackend.model.SaasInvoice;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SaasInvoiceRepository;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SaasSubscriptionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SaasSubscriptionService {

    private final SaasInvoiceRepository invoiceRepository;
    private final SaasSubscriptionRepository subscriptionRepository;

    public List<SaasInvoiceResponse> getAllInvoices() {
        List<SaasInvoice> invoices = invoiceRepository.findAllByOrderByCreatedAtDesc();
        List<SaasInvoiceResponse> responses = new ArrayList<>();

        for (SaasInvoice inv : invoices) {
            responses.add(mapToResponse(inv));
        }
        return responses;
    }

    public List<SaasInvoiceResponse> getInvoicesByStatus(String status) {
        List<SaasInvoice> invoices = invoiceRepository.findByPaymentStatus(status.toUpperCase());
        List<SaasInvoiceResponse> responses = new ArrayList<>();

        for (SaasInvoice inv : invoices) {
            responses.add(mapToResponse(inv));
        }
        return responses;
    }

    public SaasSubscriptionStatsResponse getSubscriptionStats() {
        SaasSubscriptionStatsResponse stats = new SaasSubscriptionStatsResponse();

        stats.setTotalRevenueYTD(invoiceRepository.sumPaidAmount());
        stats.setPendingInvoiceCount(invoiceRepository.countByPaymentStatus("PENDING"));
        stats.setPendingAmount(invoiceRepository.sumPendingAmount());

        // Churn rate calculation (simplified)
        long totalSubs = subscriptionRepository.count();
        long cancelledSubs = subscriptionRepository.countByStatus("CANCELLED");
        if (totalSubs > 0) {
            double churn = (double) cancelledSubs / totalSubs * 100;
            stats.setChurnRate(String.format("%.1f%%", churn));
        } else {
            stats.setChurnRate("0%");
        }

        return stats;
    }

    private SaasInvoiceResponse mapToResponse(SaasInvoice inv) {
        SaasInvoiceResponse res = new SaasInvoiceResponse();
        res.setId(inv.getId());
        res.setInvoiceCode("INV-" + String.format("%04d", inv.getId()));
        res.setSchoolName(inv.getSchool() != null ? inv.getSchool().getName() : "N/A");
        res.setPlanName(inv.getSubscription() != null && inv.getSubscription().getPlan() != null
                ? inv.getSubscription().getPlan().getName() : "N/A");
        res.setBillingCycle(inv.getSubscription() != null ? inv.getSubscription().getBillingCycle() : "N/A");
        res.setAmount(inv.getAmount());
        res.setPaymentMethod(inv.getPaymentMethod());
        res.setPaymentStatus(inv.getPaymentStatus());
        res.setPaidAt(inv.getPaidAt());
        res.setCreatedAt(inv.getCreatedAt());
        return res;
    }
}
