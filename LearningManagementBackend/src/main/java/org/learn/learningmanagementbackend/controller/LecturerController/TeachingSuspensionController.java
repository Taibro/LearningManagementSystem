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
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/lecturer/teaching-suspensions")
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
    public ResponseEntity<String> submitRequest(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestPart("data") SuspensionSubmitRequest request,
            @RequestPart(value = "proofFile", required = false) MultipartFile proofFile) {

        String teacherCode = userDetails.getSpecificCode();
        suspensionService.submitSuspensionRequest(teacherCode, request, proofFile);

        return ResponseEntity.ok("Đề xuất tạm ngừng lịch dạy đã được gửi và đang chờ Phòng Đào tạo xét duyệt!");
    }
}