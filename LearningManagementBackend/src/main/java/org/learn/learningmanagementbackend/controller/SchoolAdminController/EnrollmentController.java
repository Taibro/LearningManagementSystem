package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.EnrollmentRequest;
import org.learn.learningmanagementbackend.dto.response.EnrollmentResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.EnrollmentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminEnrollmentController")
@RequestMapping("/api/auth/school-admin/enrollments")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class EnrollmentController {

    private final EnrollmentService enrollmentService;

    @GetMapping
    public ResponseEntity<List<EnrollmentResponse>> getAllEnrollments() {
        return ResponseEntity.ok(enrollmentService.getAllEnrollments());
    }

    @GetMapping("/class/{classId}")
    public ResponseEntity<List<EnrollmentResponse>> getEnrollmentsByClass(@PathVariable Integer classId) {
        return ResponseEntity.ok(enrollmentService.getEnrollmentsByClass(classId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<EnrollmentResponse> getEnrollmentById(@PathVariable Integer id) {
        return ResponseEntity.ok(enrollmentService.getEnrollmentById(id));
    }

    @PostMapping
    public ResponseEntity<EnrollmentResponse> createEnrollment(@RequestBody EnrollmentRequest request) {
        return ResponseEntity.ok(enrollmentService.createEnrollment(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<EnrollmentResponse> updateEnrollment(@PathVariable Integer id, @RequestBody EnrollmentRequest request) {
        return ResponseEntity.ok(enrollmentService.updateEnrollment(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEnrollment(@PathVariable Integer id) {
        enrollmentService.deleteEnrollment(id);
        return ResponseEntity.noContent().build();
    }
}
