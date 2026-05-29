package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AcademicYearRequest;
import org.learn.learningmanagementbackend.dto.response.AcademicYearResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.AcademicYearService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminAcademicYearController")
@RequestMapping("/api/auth/school-admin/academic-years")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class AcademicYearController {

    private final AcademicYearService academicYearService;

    @GetMapping("/school/{schoolId}")
    public ResponseEntity<List<AcademicYearResponse>> getAllAcademicYears(@PathVariable Integer schoolId) {
        return ResponseEntity.ok(academicYearService.getAllAcademicYearsBySchool(schoolId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AcademicYearResponse> getAcademicYearById(@PathVariable Integer id) {
        return ResponseEntity.ok(academicYearService.getAcademicYearById(id));
    }

    @PostMapping
    public ResponseEntity<AcademicYearResponse> createAcademicYear(@RequestBody AcademicYearRequest request) {
        return ResponseEntity.ok(academicYearService.createAcademicYear(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AcademicYearResponse> updateAcademicYear(@PathVariable Integer id, @RequestBody AcademicYearRequest request) {
        return ResponseEntity.ok(academicYearService.updateAcademicYear(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAcademicYear(@PathVariable Integer id) {
        academicYearService.deleteAcademicYear(id);
        return ResponseEntity.noContent().build();
    }
}
