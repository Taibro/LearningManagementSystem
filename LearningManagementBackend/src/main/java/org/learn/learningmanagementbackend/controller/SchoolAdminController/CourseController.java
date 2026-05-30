package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.CourseRequest;
import org.learn.learningmanagementbackend.dto.response.CourseResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.CourseService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/school-admin/courses") // Tạm mượn /api/auth để test
@RequiredArgsConstructor
public class CourseController {

    private final CourseService courseService;

    @GetMapping("/get-by-department")
    public ResponseEntity<List<CourseResponse>> getCoursesByDepartment(@RequestParam Integer departmentId) {
        return ResponseEntity.ok(courseService.getAllCoursesByDepartment(departmentId));
    }

    @GetMapping("/get-all")
    public ResponseEntity<List<CourseResponse>> getAllCourses() {
        return ResponseEntity.ok(courseService.getAllCourses());
    }

    @PostMapping("/create-course")
    public ResponseEntity<CourseResponse> createCourse(@Valid @RequestBody CourseRequest request) {
        return ResponseEntity.ok(courseService.createCourse(request));
    }

    @PutMapping("/update-course/{id}")
    public ResponseEntity<CourseResponse> updateCourse(@PathVariable Integer id, @Valid @RequestBody CourseRequest request) {
        return ResponseEntity.ok(courseService.updateCourse(id, request));
    }

    @DeleteMapping("/delete-course/{id}")
    public ResponseEntity<String> deleteCourse(@PathVariable Integer id) {
        courseService.deleteCourse(id);
        return ResponseEntity.ok("Xóa môn học thành công!");
    }
}
