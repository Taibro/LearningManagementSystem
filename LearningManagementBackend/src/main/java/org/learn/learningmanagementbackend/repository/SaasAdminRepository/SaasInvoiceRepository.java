package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.SaasInvoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface SaasInvoiceRepository extends JpaRepository<SaasInvoice, Integer> {

    List<SaasInvoice> findByPaymentStatus(String paymentStatus);

    List<SaasInvoice> findAllByOrderByCreatedAtDesc();

    long countByPaymentStatus(String paymentStatus);

    @Query("SELECT COALESCE(SUM(i.amount), 0) FROM SaasInvoice i WHERE i.paymentStatus = 'PAID'")
    BigDecimal sumPaidAmount();

    @Query("SELECT COALESCE(SUM(i.amount), 0) FROM SaasInvoice i WHERE i.paymentStatus = 'PENDING'")
    BigDecimal sumPendingAmount();
}
