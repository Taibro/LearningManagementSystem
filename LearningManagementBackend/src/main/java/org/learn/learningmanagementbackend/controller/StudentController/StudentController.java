package org.learn.learningmanagementbackend.controller.StudentController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.*;
import org.learn.learningmanagementbackend.dto.request.CourseRegistrationRequest;
import org.learn.learningmanagementbackend.dto.request.SurveySubmitRequest;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.StudentService.CourseRegistrationService;
import org.learn.learningmanagementbackend.service.StudentService.StudentService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/student")
@RequiredArgsConstructor
public class StudentController {

    private final StudentService studentService;
    private final CourseRegistrationService courseRegistrationService;

    // GET /api/student/profile
    @GetMapping("/profile")
    public ResponseEntity<StudentProfileDto> getProfile(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getStudentProfile(userDetails.getSpecificCode()));
    }

    // GET /api/student/weekly-schedule?date=YYYY-MM-DD
    @GetMapping("/weekly-schedule")
    public ResponseEntity<List<StudentScheduleDto>> getWeeklySchedule(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return ResponseEntity.ok(studentService.getWeeklySchedule(userDetails.getSpecificCode(), date));
    }

    // GET /api/student/progress-schedule?semesterId=2
    @GetMapping("/progress-schedule")
    public ResponseEntity<List<StudentScheduleDto>> getProgressSchedule(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(required = false) Integer semesterId) {
        return ResponseEntity.ok(studentService.getProgressSchedule(userDetails.getSpecificCode(), semesterId));
    }

    // GET /api/student/grades
    @GetMapping("/grades")
    public ResponseEntity<List<StudentGradeDto>> getGrades(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getGrades(userDetails.getSpecificCode()));
    }

    // GET /api/student/attendance
    @GetMapping("/attendance")
    public ResponseEntity<List<StudentAttendanceDto>> getAttendance(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getAttendance(userDetails.getSpecificCode()));
    }

    // GET /api/student/conduct
    @GetMapping("/conduct")
    public ResponseEntity<List<StudentConductDto>> getConduct(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getConduct(userDetails.getSpecificCode()));
    }

    // GET /api/student/tuition
    @GetMapping("/tuition")
    public ResponseEntity<List<StudentTuitionDto>> getTuition(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getTuition(userDetails.getSpecificCode()));
    }

    // GET /api/student/debt-detail?semesterId=0
    @GetMapping("/debt-detail")
    public ResponseEntity<List<StudentDebtDetailDto>> getDebtDetail(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(defaultValue = "0") Integer semesterId) {
        String code = userDetails.getSpecificCode();
        List<StudentDebtDetailDto> result = studentService.getDebtDetail(code, semesterId);
        return ResponseEntity.ok(result);
    }

    // GET /api/student/semesters
    @GetMapping("/semesters")
    public ResponseEntity<List<Map<String, Object>>> getSemesters() {
        List<Map<String, Object>> result = studentService.getSemesters();
        return ResponseEntity.ok(result);
    }

    // GET /api/student/notifications
    @GetMapping("/notifications")
    public ResponseEntity<List<StudentNotificationDto>> getNotifications(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getNotifications(userDetails.getUserId()));
    }

    // GET /api/student/surveys
    @GetMapping("/surveys")
    public ResponseEntity<List<StudentSurveyListDto>> getSurveys(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getSurveyList(userDetails.getSpecificCode()));
    }

    // POST /api/student/surveys
    @PostMapping("/surveys")
    public ResponseEntity<Void> submitSurvey(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestBody SurveySubmitRequest req) {
        studentService.submitSurvey(userDetails.getSpecificCode(), req);
        return ResponseEntity.ok().build();
    }

    // GET /api/student/course-reg?semesterId=2&type=NORMAL|RETAKE|IMPROVE
    @GetMapping("/course-reg")
    public ResponseEntity<List<StudentCourseRegDto>> getCourseRegList(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(required = false) Integer semesterId,
            @RequestParam(defaultValue = "NORMAL") String type) {
        return ResponseEntity.ok(
                courseRegistrationService.getCourseList(userDetails.getSpecificCode(), semesterId, type));
    }

    // POST /api/student/course-reg
    @PostMapping("/course-reg")
    public ResponseEntity<Map<String, String>> registerCourse(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestBody CourseRegistrationRequest req) {
        courseRegistrationService.register(userDetails.getSpecificCode(), req);
        return ResponseEntity.ok(Map.of("message", "Đăng ký môn học thành công!"));
    }

    // GET /api/student/course-reg/enrolled
    @GetMapping("/course-reg/enrolled")
    public ResponseEntity<List<StudentCourseRegDto>> getEnrolledClasses(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(required = false) Integer semesterId) {
        return ResponseEntity.ok(
                courseRegistrationService.getEnrolled(userDetails.getSpecificCode(), semesterId));
    }

    // DELETE /api/student/course-reg/cancel?classId=1
    @DeleteMapping("/course-reg/cancel")
    public ResponseEntity<Map<String, String>> cancelRegistration(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam Integer classId) {
        courseRegistrationService.cancelRegistration(userDetails.getSpecificCode(), classId);
        return ResponseEntity.ok(Map.of("message", "Hủy lớp học phần thành công!"));
    }

    // ── SCHOLARSHIPS ─────────────────────────────────────────────────────────
    @GetMapping("/scholarships")
    public ResponseEntity<List<org.learn.learningmanagementbackend.dto.response.ScholarshipDto>> getScholarships(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getScholarships(userDetails.getSpecificCode()));
    }

    // ── PAYMENTS ─────────────────────────────────────────────────────────────
    @PostMapping("/payment")
    public ResponseEntity<org.learn.learningmanagementbackend.dto.response.TuitionPaymentDto> createPayment(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestBody org.learn.learningmanagementbackend.dto.request.PaymentCreateRequest req) {
        return ResponseEntity.ok(studentService.createPayment(userDetails.getSpecificCode(), req));
    }

    @GetMapping("/payments")
    public ResponseEntity<List<org.learn.learningmanagementbackend.dto.response.TuitionPaymentDto>> getPayments(
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(studentService.getPayments(userDetails.getSpecificCode()));
    }

    @PostMapping("/payment/{id}/cancel")
    public ResponseEntity<Void> cancelPayment(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @PathVariable Integer id) {
        studentService.cancelPayment(userDetails.getSpecificCode(), id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/payment/{id}/mock-success")
    public ResponseEntity<Void> mockPaymentSuccess(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @PathVariable Integer id) {
        studentService.mockPaymentSuccess(userDetails.getSpecificCode(), id);
        return ResponseEntity.ok().build();
    }

    // ── TEACHER CHAT LIST ────────────────────────────────────────────────────
    @GetMapping("/teachers")
    public ResponseEntity<List<org.learn.learningmanagementbackend.dto.response.TeacherChatResponse>> getTeachers(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @RequestParam(defaultValue = "0") Integer semesterId) {
        return ResponseEntity.ok(studentService.getTeachersForChat(userDetails.getSpecificCode(), semesterId));
    }
}
