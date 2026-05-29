package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.MakeupSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.CancelledSessionResponse;
import org.learn.learningmanagementbackend.dto.response.MakeupHistoryResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.MakeupClassService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/lecturer/makeup-classes")
@RequiredArgsConstructor
public class MakeupClassController {

    private final MakeupClassService makeupClassService;

    @GetMapping("/cancelled-sessions")
    public ResponseEntity<List<CancelledSessionResponse>> getCancelledSessions(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(makeupClassService.getAvailableCancelledSessions(userDetails.getSpecificCode()));
    }

    @GetMapping("/history")
    public ResponseEntity<List<MakeupHistoryResponse>> getHistory(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(makeupClassService.getMakeupHistory(userDetails.getSpecificCode()));
    }

    @PostMapping("/submit")
    public ResponseEntity<String> submitMakeupRequest(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody MakeupSubmitRequest request) {

        makeupClassService.submitMakeupRequest(userDetails.getSpecificCode(), request);
        return ResponseEntity.ok("Đề xuất lịch dạy bù đã được gửi thành công và đang chờ xét duyệt!");
    }
}