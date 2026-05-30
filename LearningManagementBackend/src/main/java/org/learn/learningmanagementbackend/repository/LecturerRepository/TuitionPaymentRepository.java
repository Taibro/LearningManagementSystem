package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.TuitionPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TuitionPaymentRepository extends JpaRepository<TuitionPayment, Integer> {
    
    @Query("SELECT p FROM TuitionPayment p WHERE p.tuitionInvoice.student.id = :studentId ORDER BY p.paymentDate DESC")
    List<TuitionPayment> findByStudentId(Integer studentId);

    Optional<TuitionPayment> findByTransactionCode(String transactionCode);
}
