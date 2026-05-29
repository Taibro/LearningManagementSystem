package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ClassRequest;
import org.learn.learningmanagementbackend.dto.response.ClassResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.ClassesService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminClassesController")
@RequestMapping("/api/auth/school-admin/classes")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ClassesController {

    private final ClassesService classesService;

    @GetMapping
    public ResponseEntity<List<ClassResponse>> getAllClasses() {
        return ResponseEntity.ok(classesService.getAllClasses());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClassResponse> getClassById(@PathVariable Integer id) {
        return ResponseEntity.ok(classesService.getClassById(id));
    }

    @PostMapping
    public ResponseEntity<ClassResponse> createClass(@RequestBody ClassRequest request) {
        return ResponseEntity.ok(classesService.createClass(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClassResponse> updateClass(@PathVariable Integer id, @RequestBody ClassRequest request) {
        return ResponseEntity.ok(classesService.updateClass(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClass(@PathVariable Integer id) {
        classesService.deleteClass(id);
        return ResponseEntity.noContent().build();
    }
}
