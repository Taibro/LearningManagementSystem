package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.StudentSemesterSummaryRequest;
import org.learn.learningmanagementbackend.dto.response.StudentSemesterSummaryResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.StudentSemesterSummaryService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminStudentSemesterSummaryController")
@RequestMapping("/api/school-admin/grades")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class StudentSemesterSummaryController {

    private final StudentSemesterSummaryService summaryService;

    @GetMapping
    public ResponseEntity<List<StudentSemesterSummaryResponse>> getAllSummaries() {
        return ResponseEntity.ok(summaryService.getAllSummaries());
    }

    @GetMapping("/semester/{semesterId}")
    public ResponseEntity<List<StudentSemesterSummaryResponse>> getSummariesBySemester(@PathVariable Integer semesterId) {
        return ResponseEntity.ok(summaryService.getSummariesBySemester(semesterId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<StudentSemesterSummaryResponse> getSummaryById(@PathVariable Integer id) {
        return ResponseEntity.ok(summaryService.getSummaryById(id));
    }

    @PostMapping
    public ResponseEntity<StudentSemesterSummaryResponse> createSummary(@RequestBody StudentSemesterSummaryRequest request) {
        return ResponseEntity.ok(summaryService.createSummary(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<StudentSemesterSummaryResponse> updateSummary(@PathVariable Integer id, @RequestBody StudentSemesterSummaryRequest request) {
        return ResponseEntity.ok(summaryService.updateSummary(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSummary(@PathVariable Integer id) {
        summaryService.deleteSummary(id);
        return ResponseEntity.noContent().build();
    }
}
