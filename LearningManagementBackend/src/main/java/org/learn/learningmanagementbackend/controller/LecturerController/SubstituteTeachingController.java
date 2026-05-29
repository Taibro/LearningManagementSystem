package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SubstituteSubmitRequest;
import org.learn.learningmanagementbackend.dto.response.SubstituteHistoryResponse;
import org.learn.learningmanagementbackend.dto.response.TeacherDropdownResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.SubstituteTeachingService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/lecturer/substitute-teaching")
@RequiredArgsConstructor
public class SubstituteTeachingController {

    private final SubstituteTeachingService substituteService;

    // Load danh sách Giảng viên cùng bộ môn vào Dropdown
    @GetMapping("/eligible-teachers")
    public ResponseEntity<List<TeacherDropdownResponse>> getEligibleTeachers(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(substituteService.getEligibleSubstituteTeachers(userDetails.getSpecificCode()));
    }

    // Load trạng thái gần đây
    @GetMapping("/history")
    public ResponseEntity<List<SubstituteHistoryResponse>> getHistory(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(substituteService.getHistory(userDetails.getSpecificCode()));
    }

    // Gửi đơn đề xuất
    @PostMapping("/submit")
    public ResponseEntity<String> submitRequest(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody SubstituteSubmitRequest request) {

        substituteService.submitSubstituteRequest(userDetails.getSpecificCode(), request);
        return ResponseEntity.ok("Đề xuất dạy thay đã được gửi thành công và đang chờ Trưởng bộ môn phê duyệt!");
    }
}