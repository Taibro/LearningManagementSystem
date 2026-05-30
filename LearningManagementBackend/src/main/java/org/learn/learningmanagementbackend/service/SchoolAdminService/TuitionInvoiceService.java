package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TuitionInvoiceRequest;
import org.learn.learningmanagementbackend.dto.response.TuitionInvoiceResponse;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.TuitionInvoice;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.SemesterRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.StudentRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.TuitionInvoiceRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminTuitionInvoiceService")
@RequiredArgsConstructor
public class TuitionInvoiceService {

    private final TuitionInvoiceRepository invoiceRepository;
    private final StudentRepository studentRepository;
    private final SemesterRepository semesterRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<TuitionInvoiceResponse> getAllInvoices() {
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

        List<TuitionInvoice> invoices = entityManager.createQuery("SELECT i FROM TuitionInvoice i WHERE i.student.department.school.id = :schoolId", TuitionInvoice.class)
                .setParameter("schoolId", schoolId).getResultList();

        return invoices.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<TuitionInvoiceResponse> getInvoicesBySemester(Integer semesterId) {
        return invoiceRepository.findBySemesterId(semesterId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public TuitionInvoiceResponse getInvoiceById(Integer id) {
        TuitionInvoice invoice = invoiceRepository.findById(id).orElseThrow(() -> new RuntimeException("Invoice not found"));
        return mapToResponse(invoice);
    }

    public TuitionInvoiceResponse createInvoice(TuitionInvoiceRequest request) {
        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Student not found"));
        Semester semester = semesterRepository.findById(request.getSemesterId())
                .orElseThrow(() -> new RuntimeException("Semester not found"));

        TuitionInvoice invoice = new TuitionInvoice();
        invoice.setStudent(student);
        invoice.setSemester(semester);
        invoice.setTotalAmount(request.getTotalAmount());
        invoice.setPaidAmount(request.getPaidAmount() != null ? request.getPaidAmount() : BigDecimal.ZERO);
        invoice.setDueDate(request.getDueDate());
        invoice.setStatus(request.getStatus());

        return mapToResponse(invoiceRepository.save(invoice));
    }

    public TuitionInvoiceResponse updateInvoice(Integer id, TuitionInvoiceRequest request) {
        TuitionInvoice invoice = invoiceRepository.findById(id).orElseThrow(() -> new RuntimeException("Invoice not found"));

        if (!invoice.getStudent().getId().equals(request.getStudentId())) {
            Student student = studentRepository.findById(request.getStudentId())
                    .orElseThrow(() -> new RuntimeException("Student not found"));
            invoice.setStudent(student);
        }

        if (!invoice.getSemester().getId().equals(request.getSemesterId())) {
            Semester semester = semesterRepository.findById(request.getSemesterId())
                    .orElseThrow(() -> new RuntimeException("Semester not found"));
            invoice.setSemester(semester);
        }

        invoice.setTotalAmount(request.getTotalAmount());
        if (request.getPaidAmount() != null) {
            invoice.setPaidAmount(request.getPaidAmount());
        }
        invoice.setDueDate(request.getDueDate());
        invoice.setStatus(request.getStatus());

        return mapToResponse(invoiceRepository.save(invoice));
    }

    public void deleteInvoice(Integer id) {
        invoiceRepository.deleteById(id);
    }

    private TuitionInvoiceResponse mapToResponse(TuitionInvoice invoice) {
        TuitionInvoiceResponse response = new TuitionInvoiceResponse();
        response.setId(invoice.getId());
        
        if (invoice.getStudent() != null) {
            response.setStudentId(invoice.getStudent().getId());
            response.setStudentCode(invoice.getStudent().getStudentCode());
            if (invoice.getStudent().getUser() != null) {
                response.setStudentName(invoice.getStudent().getUser().getFullName());
            }
        }
        
        if (invoice.getSemester() != null) {
            response.setSemesterId(invoice.getSemester().getId());
            response.setSemesterName(invoice.getSemester().getName());
        }
        
        response.setTotalAmount(invoice.getTotalAmount());
        response.setPaidAmount(invoice.getPaidAmount());
        response.setDueDate(invoice.getDueDate());
        response.setStatus(invoice.getStatus());
        response.setCreatedAt(invoice.getCreatedAt());
        
        return response;
    }
}
