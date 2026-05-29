package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.DepartmentRequest;
import org.learn.learningmanagementbackend.dto.response.DepartmentResponse;
import org.learn.learningmanagementbackend.service.DepartmentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/schooladmin")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép frontend React/Vite gọi
public class DepartmentController {

    private final DepartmentService departmentService;

    @GetMapping("/get-all-departments")
    public ResponseEntity<List<DepartmentResponse>> getAllDepartments(@RequestParam Integer schoolId) {
        return ResponseEntity.ok(departmentService.getAllDepartmentsBySchool(schoolId));
    }

    @PostMapping("/create-department")
    public ResponseEntity<DepartmentResponse> createDepartment(@Valid @RequestBody DepartmentRequest request) {
        return ResponseEntity.ok(departmentService.createDepartment(request));
    }

    @PutMapping("/update-department/{id}")
    public ResponseEntity<DepartmentResponse> updateDepartment(@PathVariable Integer id, @Valid @RequestBody DepartmentRequest request) {
        return ResponseEntity.ok(departmentService.updateDepartment(id, request));
    }

    @DeleteMapping("/delete-department/{id}")
    public ResponseEntity<String> deleteDepartment(@PathVariable Integer id) {
        departmentService.deleteDepartment(id);
        return ResponseEntity.ok("Xóa khoa thành công!");
    }
}
