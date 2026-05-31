package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AuthRequest;
import org.learn.learningmanagementbackend.dto.response.UserProfileResponse;
import org.learn.learningmanagementbackend.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<UserProfileResponse> login(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/2fa/setup")
    public ResponseEntity<org.learn.learningmanagementbackend.dto.response.Setup2faResponse> setup2fa(@RequestBody java.util.Map<String, String> body) {
        return ResponseEntity.ok(authService.setup2fa(body.get("email")));
    }

    @PostMapping("/2fa/verify-setup")
    public ResponseEntity<Boolean> verifySetup(@RequestBody org.learn.learningmanagementbackend.dto.request.Verify2faRequest request) {
        return ResponseEntity.ok(authService.verifySetup(request));
    }

    @PostMapping("/login/verify-2fa")
    public ResponseEntity<UserProfileResponse> verify2faLogin(
            @RequestBody org.learn.learningmanagementbackend.dto.request.Verify2faRequest request,
            @org.springframework.web.bind.annotation.RequestHeader("Authorization") String authHeader) {
        
        String tempToken = authHeader.replace("Bearer ", "");
        return ResponseEntity.ok(authService.verify2faLogin(request, tempToken));
    }
}
