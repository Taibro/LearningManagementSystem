package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SemesterRequest;
import org.learn.learningmanagementbackend.dto.response.SemesterResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.SemesterService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminSemesterController")
@RequestMapping("/api/school-admin/semesters")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class SemesterController {

    private final SemesterService semesterService;

    @GetMapping("/academic-year/{academicYearId}")
    public ResponseEntity<List<SemesterResponse>> getAllSemestersByAcademicYear(@PathVariable Integer academicYearId) {
        return ResponseEntity.ok(semesterService.getAllSemestersByAcademicYear(academicYearId));
    }

    @GetMapping("/get-all")
    public ResponseEntity<List<SemesterResponse>> getAllSemesters() {
        return ResponseEntity.ok(semesterService.getAllSemesters());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SemesterResponse> getSemesterById(@PathVariable Integer id) {
        return ResponseEntity.ok(semesterService.getSemesterById(id));
    }

    @PostMapping
    public ResponseEntity<SemesterResponse> createSemester(@RequestBody SemesterRequest request) {
        return ResponseEntity.ok(semesterService.createSemester(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<SemesterResponse> updateSemester(@PathVariable Integer id, @RequestBody SemesterRequest request) {
        return ResponseEntity.ok(semesterService.updateSemester(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSemester(@PathVariable Integer id) {
        semesterService.deleteSemester(id);
        return ResponseEntity.noContent().build();
    }
}
