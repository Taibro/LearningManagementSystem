package org.learn.learningmanagementbackend.controller.LecturerController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.TeacherProfileDto;
import org.learn.learningmanagementbackend.dto.request.TeacherProfileUpdateDto;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.LecturerService.TeacherService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/lecturer")
@RequiredArgsConstructor
public class TeacherController {

    private final TeacherService teacherService;

    @GetMapping("/profile")
    public ResponseEntity<TeacherProfileDto> getMyInfo(@AuthenticationPrincipal CustomUserDetails userDetails) {
        String teacherCode = userDetails.getSpecificCode();

        TeacherProfileDto teacher = teacherService.getTeacherProfileByCode(teacherCode);
        return ResponseEntity.ok(teacher);
    }

    @PutMapping("/profile")
    public ResponseEntity<String> updateProfile(
            @AuthenticationPrincipal CustomUserDetails currentUser,
            @RequestBody TeacherProfileUpdateDto updateDto
    ) {
        String teacherCode = currentUser.getSpecificCode();

        teacherService.updateTeacherProfile(teacherCode, updateDto);

        return ResponseEntity.ok("Update successfully");
    }
}
