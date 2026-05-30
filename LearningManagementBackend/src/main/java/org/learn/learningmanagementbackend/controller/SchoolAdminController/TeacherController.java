package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TeacherRequest;
import org.learn.learningmanagementbackend.dto.response.TeacherResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.TeacherService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminTeacherController")
@RequestMapping("/api/auth/school-admin/teachers") // Dùng tạm /auth để test mượt mà
@RequiredArgsConstructor
public class TeacherController {

    private final TeacherService teacherService;

    @GetMapping("/get-all")
    public ResponseEntity<List<TeacherResponse>> getAllTeachers() {
        return ResponseEntity.ok(teacherService.getAllTeachers());
    }

    @PostMapping("/create-teacher")
    public ResponseEntity<TeacherResponse> createTeacher(@Valid @RequestBody TeacherRequest request) {
        return ResponseEntity.ok(teacherService.createTeacher(request));
    }

    @PutMapping("/update-teacher/{id}")
    public ResponseEntity<TeacherResponse> updateTeacher(@PathVariable Integer id, @Valid @RequestBody TeacherRequest request) {
        return ResponseEntity.ok(teacherService.updateTeacher(id, request));
    }

    @DeleteMapping("/delete-teacher/{id}")
    public ResponseEntity<String> deleteTeacher(@PathVariable Integer id) {
        teacherService.deleteTeacher(id);
        return ResponseEntity.ok("Xóa giảng viên thành công!");
    }
}
