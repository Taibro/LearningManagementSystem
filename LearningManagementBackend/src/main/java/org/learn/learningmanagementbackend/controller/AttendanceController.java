package org.learn.learningmanagementbackend.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AttendanceSaveRequest;
import org.learn.learningmanagementbackend.dto.response.AttendanceListResponse;
import org.learn.learningmanagementbackend.service.AttendanceService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/attendance")
@RequiredArgsConstructor
public class AttendanceController {

    private final AttendanceService attendanceService;

    @GetMapping
    public ResponseEntity<AttendanceListResponse> getAttendance(
            @RequestParam("classId") Integer classId,
            @RequestParam("scheduleId") Integer scheduleId,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        return ResponseEntity.ok(attendanceService.getAttendanceList(classId, scheduleId, date));
    }

    @PostMapping("/save")
    public ResponseEntity<String> saveAttendance(@Valid @RequestBody AttendanceSaveRequest request) {
        attendanceService.saveAttendance(request);
        return ResponseEntity.ok("Đã lưu dữ liệu điểm danh thành công!");
    }
}