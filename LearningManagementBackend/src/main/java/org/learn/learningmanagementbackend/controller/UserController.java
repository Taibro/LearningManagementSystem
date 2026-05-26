package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.TeacherProfileDto;
import org.learn.learningmanagementbackend.repository.TeacherRepository;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.TeacherService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.Optional;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    

}
