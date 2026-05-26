package org.learn.learningmanagementbackend.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TeacherDeclarationRequest;
import org.learn.learningmanagementbackend.service.TeacherDeclarationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/teacher-declarations")
@RequiredArgsConstructor
public class TeacherDeclarationController {

    private final TeacherDeclarationService declarationService;

    @PostMapping
    public ResponseEntity<String> submitDeclaration(@Valid @RequestBody TeacherDeclarationRequest request) {
        declarationService.saveDeclaration(request);
        return ResponseEntity.ok("Đã lưu khai báo giảng dạy thành công!");
    }
}