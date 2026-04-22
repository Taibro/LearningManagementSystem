package org.learn.learningmanagementbackend.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @GetMapping("/me")
    public ResponseEntity<String> getMyInfo(Principal principal){
        String currentUsername = principal.getName();
        return ResponseEntity.ok("Xin chao tai khoan : " + currentUsername);
    }

}
