package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AttendanceSaveRequest;
import org.learn.learningmanagementbackend.dto.request.QrGenerateRequest;
import org.learn.learningmanagementbackend.dto.request.QrScanRequest;
import org.learn.learningmanagementbackend.dto.response.AttendanceListResponse;
import org.learn.learningmanagementbackend.dto.response.QrGenerateResponse;
import org.learn.learningmanagementbackend.service.LecturerService.AttendanceService;
import org.learn.learningmanagementbackend.service.LecturerService.QrAttendanceService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/lecturer/attendance")
@RequiredArgsConstructor
public class AttendanceController {

    private final AttendanceService attendanceService;
    private final QrAttendanceService qrService;

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

    @PostMapping("/qr/generate")
    public ResponseEntity<QrGenerateResponse> generateQr(@Valid @RequestBody QrGenerateRequest request) {
        QrGenerateResponse response = qrService.generateQrToken(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/qr/scan")
    public ResponseEntity<String> scanQr(@Valid @RequestBody QrScanRequest request) {
        qrService.scanAndAttend(request);
        return ResponseEntity.ok("Điểm danh thành công! Chúc bạn học tốt.");
    }
}