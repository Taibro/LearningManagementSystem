package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AuthRequest;
import org.learn.learningmanagementbackend.dto.response.UserProfileResponse;
import org.learn.learningmanagementbackend.service.AuthService;
import org.learn.learningmanagementbackend.repository.LecturerRepository.UserRepository;
import org.learn.learningmanagementbackend.model.Users;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<UserProfileResponse> login(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    // DEV ONLY: Hack để Reset mật khẩu của tất cả Giảng viên về 123456 để test hệ thống
    @GetMapping("/reset-dev")
    public ResponseEntity<String> resetDevPasswords() {
        List<Users> users = userRepository.findAll();
        int count = 0;
        for (Users u : users) {
            // Kiểm tra xem User này có phải là Giảng viên không
            if (u.getTeacher() != null) {
                u.setPasswordHash(passwordEncoder.encode("123456"));
                userRepository.save(u);
                count++;
            }
        }
        return ResponseEntity.ok("Đã reset thành công mật khẩu về 123456 cho " + count + " tài khoản Giảng viên!");
    }
}
