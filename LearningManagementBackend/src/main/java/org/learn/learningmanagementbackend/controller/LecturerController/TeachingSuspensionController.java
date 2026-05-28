package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SuspensionSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.SuspensionHistoryResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.TeachingSuspensionService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/teaching-suspensions")
@RequiredArgsConstructor
public class TeachingSuspensionController {

    private final TeachingSuspensionService suspensionService;

    @GetMapping("/history")
    public ResponseEntity<List<SuspensionHistoryResponse>> getHistory(
            @AuthenticationPrincipal CustomUserDetails userDetails) {

        String teacherCode = userDetails.getSpecificCode();

        return ResponseEntity.ok(suspensionService.getTeacherSuspensionHistory(teacherCode));
    }

    @PostMapping(value = "/submit", consumes = "multipart/form-data")
    public ResponseEntity<String> submitRequest(@Valid @ModelAttribute SuspensionSubmitRequest request) {
        suspensionService.submitSuspensionRequest(request);
        return ResponseEntity.ok("Đề xuất tạm ngừng lịch dạy đã được gửi thành công và đang chờ xét duyệt!");
    }
}