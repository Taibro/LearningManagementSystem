package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.GradeSaveRequest;
import org.learn.learningmanagementbackend.dto.response.GradeManagementResponse;
import org.learn.learningmanagementbackend.service.LecturerService.GradeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/lecturer/grades")
@RequiredArgsConstructor
public class GradeController {

    private final GradeService gradeService;

    @GetMapping
    public ResponseEntity<GradeManagementResponse> getGrades(@RequestParam("classId") Integer classId) {
        return ResponseEntity.ok(gradeService.getClassGrades(classId));
    }

    @PostMapping("/save")
    public ResponseEntity<String> saveGrades(@Valid @RequestBody GradeSaveRequest request) {
        gradeService.saveGrades(request);
        return ResponseEntity.ok("Đã lưu bảng điểm thành công!");
    }

    @PostMapping("/lock/{classId}")
    public ResponseEntity<String> lockGrades(@PathVariable("classId") Integer classId) {
        gradeService.lockGrades(classId);
        return ResponseEntity.ok("Bảng điểm đã được khóa. Giảng viên không thể chỉnh sửa thêm.");
    }
}