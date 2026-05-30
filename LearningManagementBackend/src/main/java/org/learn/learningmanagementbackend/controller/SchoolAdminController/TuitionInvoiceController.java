package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TuitionInvoiceRequest;
import org.learn.learningmanagementbackend.dto.response.TuitionInvoiceResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.TuitionInvoiceService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminTuitionInvoiceController")
@RequestMapping("/api/school-admin/tuition-invoices")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class TuitionInvoiceController {

    private final TuitionInvoiceService invoiceService;

    @GetMapping
    public ResponseEntity<List<TuitionInvoiceResponse>> getAllInvoices() {
        return ResponseEntity.ok(invoiceService.getAllInvoices());
    }

    @GetMapping("/semester/{semesterId}")
    public ResponseEntity<List<TuitionInvoiceResponse>> getInvoicesBySemester(@PathVariable Integer semesterId) {
        return ResponseEntity.ok(invoiceService.getInvoicesBySemester(semesterId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<TuitionInvoiceResponse> getInvoiceById(@PathVariable Integer id) {
        return ResponseEntity.ok(invoiceService.getInvoiceById(id));
    }

    @PostMapping
    public ResponseEntity<TuitionInvoiceResponse> createInvoice(@RequestBody TuitionInvoiceRequest request) {
        return ResponseEntity.ok(invoiceService.createInvoice(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<TuitionInvoiceResponse> updateInvoice(@PathVariable Integer id, @RequestBody TuitionInvoiceRequest request) {
        return ResponseEntity.ok(invoiceService.updateInvoice(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteInvoice(@PathVariable Integer id) {
        invoiceService.deleteInvoice(id);
        return ResponseEntity.noContent().build();
    }
}
