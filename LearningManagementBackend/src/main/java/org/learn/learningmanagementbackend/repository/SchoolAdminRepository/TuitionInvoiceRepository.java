package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.TuitionInvoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminTuitionInvoiceRepository")
public interface TuitionInvoiceRepository extends JpaRepository<TuitionInvoice, Integer> {
    List<TuitionInvoice> findByStudentId(Integer studentId);
    List<TuitionInvoice> findBySemesterId(Integer semesterId);
}
