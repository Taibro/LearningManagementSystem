package org.learn.learningmanagementbackend.controller.LecturerController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.EvaluationDashboardResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.EvaluationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/lecturer/evaluations")
@RequiredArgsConstructor
public class EvaluationController {

    private final EvaluationService evaluationService;

    @GetMapping("/dashboard")
    public ResponseEntity<EvaluationDashboardResponse> getDashboard(
            @AuthenticationPrincipal CustomUserDetails userDetails) {

        String teacherCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(evaluationService.getDashboardData(teacherCode));
    }
}