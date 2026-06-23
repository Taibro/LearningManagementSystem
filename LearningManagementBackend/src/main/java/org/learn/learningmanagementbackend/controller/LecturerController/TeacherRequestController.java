package org.learn.learningmanagementbackend.controller.LecturerController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleExceptionRepository;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/lecturer/requests")
@RequiredArgsConstructor
public class TeacherRequestController {

    private final ScheduleExceptionRepository exceptionRepository;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getTeachingRequests(@AuthenticationPrincipal CustomUserDetails userDetails) {
        String teacherCode = userDetails.getSpecificCode();
        List<ScheduleException> history = exceptionRepository.findHistoryByTeacherCode(teacherCode);

        List<Map<String, Object>> requests = new ArrayList<>();
        
        for (ScheduleException ex : history) {
            Map<String, Object> req = new HashMap<>();
            req.put("id", ex.getId());
            req.put("classInfo", ex.getSchedule().getClasses().getCode());
            req.put("reason", ex.getReason());
            
            String status = ex.getApprovalStatus() != null ? ex.getApprovalStatus().name().toLowerCase() : "pending";
            req.put("status", status);
            
            // Map the type to Flutter expectations
            if (ex.getExceptionType().name().equals("CANCELLED")) {
                req.put("type", "tamNgung");
                req.put("date", ex.getExceptionDate().toString());
            } else if (ex.getExceptionType().name().equals("SUBSTITUTED")) {
                req.put("type", "dayThay");
                req.put("date", ex.getExceptionDate().toString());
                req.put("status", ex.getSubstituteStatus() != null ? ex.getSubstituteStatus().name().toLowerCase() : "pending");
            } else if (ex.getMakeupStatus() != null) {
                req.put("type", "dayBu");
                req.put("date", ex.getReplacementDate() != null ? ex.getReplacementDate().toString() : "");
            } else {
                req.put("type", "tamNgung");
                req.put("date", ex.getExceptionDate() != null ? ex.getExceptionDate().toString() : "");
            }
            
            requests.add(req);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("data", requests);

        return ResponseEntity.ok(response);
    }
}
