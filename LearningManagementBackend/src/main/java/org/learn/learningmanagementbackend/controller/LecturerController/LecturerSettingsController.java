package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ChangePasswordRequest;
import org.learn.learningmanagementbackend.dto.request.UpdateProfileRequest;
import org.learn.learningmanagementbackend.dto.response.LecturerProfileResponse;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.LecturerSettingsService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/lecturer/settings")
@RequiredArgsConstructor
public class LecturerSettingsController {

    private final LecturerSettingsService settingsService;

    // Load dữ liệu lên UI
    @GetMapping("/profile")
    public ResponseEntity<LecturerProfileResponse> getProfile(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(settingsService.getProfile(userDetails.getSpecificCode()));
    }

    // Lưu Form Cập nhật hồ sơ
    @PutMapping("/profile")
    public ResponseEntity<String> updateProfile(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody UpdateProfileRequest request) {

        settingsService.updateProfile(userDetails.getSpecificCode(), request);
        return ResponseEntity.ok("Cập nhật hồ sơ thành công!");
    }

    // Lưu Form Đổi mật khẩu
    @PutMapping("/password")
    public ResponseEntity<String> changePassword(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody ChangePasswordRequest request) {

        settingsService.changePassword(userDetails.getSpecificCode(), request);
        return ResponseEntity.ok("Đổi mật khẩu thành công! Hãy sử dụng mật khẩu mới cho lần đăng nhập sau.");
    }

    // Upload Avatar
    @PostMapping(value = "/avatar", consumes = "multipart/form-data")
    public ResponseEntity<String> updateAvatar(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestPart("file") MultipartFile file) {

        String newAvatarUrl = settingsService.updateAvatar(userDetails.getSpecificCode(), file);
        return ResponseEntity.ok(newAvatarUrl);
    }
}