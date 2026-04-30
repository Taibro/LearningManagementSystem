package org.learn.learningmanagementbackend.controller;

import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @GetMapping("/me")
    public ResponseEntity<String> getMyInfo(@AuthenticationPrincipal CustomUserDetails userDetails){
        Integer currentUserId = userDetails.getUserId();
        String currentName = userDetails.getFullName();
        String currentCode = userDetails.getSpecificCode();
        String currentRole = userDetails.getAuthorities().toString();
        String message = String.format(
                "Xin chào %s! ID của bạn là %d, mã số %s, quyền: %s",
                currentName, currentUserId, currentCode, currentRole
        );

        return ResponseEntity.ok(message);
    }

}
