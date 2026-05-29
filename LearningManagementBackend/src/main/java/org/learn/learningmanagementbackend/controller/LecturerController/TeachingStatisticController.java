package org.learn.learningmanagementbackend.controller.LecturerController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.TeachingStatisticResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.TeachingStatisticService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/lecturer/statistics")
@RequiredArgsConstructor
public class TeachingStatisticController {

    private final TeachingStatisticService statisticService;
    
    @GetMapping("/dashboard")
    public ResponseEntity<TeachingStatisticResponse> getDashboard(
            @AuthenticationPrincipal CustomUserDetails userDetails) {

        String teacherCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(statisticService.getDashboardStatistics(teacherCode));
    }
}