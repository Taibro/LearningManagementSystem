package org.learn.learningmanagementbackend.controller.StudentController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.*;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.StudentService.StudentService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/student")
@RequiredArgsConstructor
public class StudentController {

    private final StudentService studentService;

    // GET /api/student/profile
    @GetMapping("/profile")
    public ResponseEntity<StudentProfileDto> getProfile(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getStudentProfile(studentCode));
    }

    // GET /api/student/weekly-schedule?date=2026-05-29
    @GetMapping("/weekly-schedule")
    public ResponseEntity<List<StudentScheduleDto>> getWeeklySchedule(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getWeeklySchedule(studentCode, date));
    }

    // GET /api/student/progress-schedule?semesterId=2
    @GetMapping("/progress-schedule")
    public ResponseEntity<List<StudentScheduleDto>> getProgressSchedule(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(required = false) Integer semesterId) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getProgressSchedule(studentCode, semesterId));
    }

    // GET /api/student/grades
    @GetMapping("/grades")
    public ResponseEntity<List<StudentGradeDto>> getGrades(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getGrades(studentCode));
    }

    // GET /api/student/attendance
    @GetMapping("/attendance")
    public ResponseEntity<List<StudentAttendanceDto>> getAttendance(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getAttendance(studentCode));
    }

    // GET /api/student/conduct
    @GetMapping("/conduct")
    public ResponseEntity<List<StudentConductDto>> getConduct(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getConduct(studentCode));
    }

    // GET /api/student/tuition
    @GetMapping("/tuition")
    public ResponseEntity<List<StudentTuitionDto>> getTuition(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        String studentCode = userDetails.getSpecificCode();
        return ResponseEntity.ok(studentService.getTuition(studentCode));
    }

    // GET /api/student/notifications
    @GetMapping("/notifications")
    public ResponseEntity<List<StudentNotificationDto>> getNotifications(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        Integer userId = userDetails.getUserId();
        return ResponseEntity.ok(studentService.getNotifications(userId));
    }
}
