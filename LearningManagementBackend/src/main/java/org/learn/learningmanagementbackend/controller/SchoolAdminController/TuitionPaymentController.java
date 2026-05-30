package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TuitionPaymentRequest;
import org.learn.learningmanagementbackend.dto.response.TuitionPaymentResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.TuitionPaymentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminTuitionPaymentController")
@RequestMapping("/api/auth/school-admin/payments")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class TuitionPaymentController {

    private final TuitionPaymentService paymentService;

    @GetMapping
    public ResponseEntity<List<TuitionPaymentResponse>> getAllPayments() {
        return ResponseEntity.ok(paymentService.getAllPayments());
    }

    @GetMapping("/invoice/{invoiceId}")
    public ResponseEntity<List<TuitionPaymentResponse>> getPaymentsByInvoice(@PathVariable Integer invoiceId) {
        return ResponseEntity.ok(paymentService.getPaymentsByInvoice(invoiceId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<TuitionPaymentResponse> getPaymentById(@PathVariable Integer id) {
        return ResponseEntity.ok(paymentService.getPaymentById(id));
    }

    @PostMapping
    public ResponseEntity<TuitionPaymentResponse> createPayment(@RequestBody TuitionPaymentRequest request) {
        return ResponseEntity.ok(paymentService.createPayment(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<TuitionPaymentResponse> updatePayment(@PathVariable Integer id, @RequestBody TuitionPaymentRequest request) {
        return ResponseEntity.ok(paymentService.updatePayment(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePayment(@PathVariable Integer id) {
        paymentService.deletePayment(id);
        return ResponseEntity.noContent().build();
    }
}
