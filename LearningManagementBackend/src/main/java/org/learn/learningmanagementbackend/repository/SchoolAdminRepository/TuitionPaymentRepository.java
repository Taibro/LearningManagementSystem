package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.TuitionPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminTuitionPaymentRepository")
public interface TuitionPaymentRepository extends JpaRepository<TuitionPayment, Integer> {
    List<TuitionPayment> findByTuitionInvoiceId(Integer invoiceId);
}
