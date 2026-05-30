package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TuitionPaymentRequest;
import org.learn.learningmanagementbackend.dto.response.TuitionPaymentResponse;
import org.learn.learningmanagementbackend.model.TuitionInvoice;
import org.learn.learningmanagementbackend.model.TuitionPayment;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.TuitionInvoiceRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.TuitionPaymentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminTuitionPaymentService")
@RequiredArgsConstructor
public class TuitionPaymentService {

    private final TuitionPaymentRepository paymentRepository;
    private final TuitionInvoiceRepository invoiceRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<TuitionPaymentResponse> getAllPayments() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT us.school.id FROM UserSchool us WHERE us.user.id = :userId", Integer.class)
                    .setParameter("userId", userId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<TuitionPayment> payments = entityManager.createQuery("SELECT p FROM TuitionPayment p WHERE p.tuitionInvoice.student.department.school.id = :schoolId", TuitionPayment.class)
                .setParameter("schoolId", schoolId).getResultList();

        return payments.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<TuitionPaymentResponse> getPaymentsByInvoice(Integer invoiceId) {
        return paymentRepository.findByTuitionInvoiceId(invoiceId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public TuitionPaymentResponse getPaymentById(Integer id) {
        TuitionPayment payment = paymentRepository.findById(id).orElseThrow(() -> new RuntimeException("Payment not found"));
        return mapToResponse(payment);
    }

    public TuitionPaymentResponse createPayment(TuitionPaymentRequest request) {
        TuitionInvoice invoice = invoiceRepository.findById(request.getInvoiceId())
                .orElseThrow(() -> new RuntimeException("Invoice not found"));

        TuitionPayment payment = new TuitionPayment();
        payment.setTuitionInvoice(invoice);
        payment.setAmount(request.getAmount());
        payment.setPaymentMethod(request.getPaymentMethod());
        payment.setTransactionCode(request.getTransactionCode());
        payment.setPaymentDate(request.getPaymentDate());
        payment.setStatus(request.getStatus());
        payment.setNote(request.getNote());

        return mapToResponse(paymentRepository.save(payment));
    }

    public TuitionPaymentResponse updatePayment(Integer id, TuitionPaymentRequest request) {
        TuitionPayment payment = paymentRepository.findById(id).orElseThrow(() -> new RuntimeException("Payment not found"));

        if (!payment.getTuitionInvoice().getId().equals(request.getInvoiceId())) {
            TuitionInvoice invoice = invoiceRepository.findById(request.getInvoiceId())
                    .orElseThrow(() -> new RuntimeException("Invoice not found"));
            payment.setTuitionInvoice(invoice);
        }

        payment.setAmount(request.getAmount());
        payment.setPaymentMethod(request.getPaymentMethod());
        payment.setTransactionCode(request.getTransactionCode());
        payment.setPaymentDate(request.getPaymentDate());
        payment.setStatus(request.getStatus());
        payment.setNote(request.getNote());

        return mapToResponse(paymentRepository.save(payment));
    }

    public void deletePayment(Integer id) {
        paymentRepository.deleteById(id);
    }

    private TuitionPaymentResponse mapToResponse(TuitionPayment payment) {
        TuitionPaymentResponse response = new TuitionPaymentResponse();
        response.setId(payment.getId());
        
        if (payment.getTuitionInvoice() != null) {
            response.setInvoiceId(payment.getTuitionInvoice().getId());
            if (payment.getTuitionInvoice().getStudent() != null && payment.getTuitionInvoice().getStudent().getUser() != null) {
                response.setStudentName(payment.getTuitionInvoice().getStudent().getUser().getFullName());
            }
        }
        
        response.setAmount(payment.getAmount());
        response.setPaymentMethod(payment.getPaymentMethod());
        response.setTransactionCode(payment.getTransactionCode());
        response.setPaymentDate(payment.getPaymentDate());
        response.setStatus(payment.getStatus());
        response.setNote(payment.getNote());
        
        return response;
    }
}
