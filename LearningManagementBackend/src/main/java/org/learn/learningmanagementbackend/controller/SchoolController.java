package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SchoolOptionResponse;
import org.learn.learningmanagementbackend.service.PublicSchoolService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/schools")
@RequiredArgsConstructor
public class SchoolController {

    private final PublicSchoolService schoolService;

    @GetMapping("/active")
    public ResponseEntity<List<SchoolOptionResponse>> getActiveSchools() {
        return ResponseEntity.ok(schoolService.getActiveSchools());
    }
}
