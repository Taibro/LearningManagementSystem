package org.learn.learningmanagementbackend.controller;

import lombok.Data;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.LecturerRepository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RestController
@RequestMapping("/api/fcm")
public class FcmController {

    private final UserRepository userRepository;

    public FcmController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @PutMapping("/token")
    public ResponseEntity<?> updateFcmToken(@RequestBody FcmTokenRequest request, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }

        String email = principal.getName();
        Users user = userRepository.findByEmail(email).orElse(null);
        
        if (user == null) {
            return ResponseEntity.status(404).body("User not found");
        }

        user.setFcmToken(request.getToken());
        userRepository.save(user);

        return ResponseEntity.ok("FCM Token updated successfully");
    }

    @Data
    public static class FcmTokenRequest {
        private String token;
    }
}
