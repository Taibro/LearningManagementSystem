package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.TuitionInvoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TuitionInvoiceRepository extends JpaRepository<TuitionInvoice, Integer> {

    Optional<TuitionInvoice> findByStudentIdAndSemesterId(Integer studentId, Integer semesterId);
}
