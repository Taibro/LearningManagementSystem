package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AttendanceRecordRequest;
import org.learn.learningmanagementbackend.dto.response.AttendanceRecordResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.AttendanceRecordService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminAttendanceRecordController")
@RequestMapping("/api/auth/school-admin/attendance")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class AttendanceRecordController {

    private final AttendanceRecordService attendanceService;

    @GetMapping
    public ResponseEntity<List<AttendanceRecordResponse>> getAllRecords() {
        return ResponseEntity.ok(attendanceService.getAllRecords());
    }

    @GetMapping("/schedule/{scheduleId}")
    public ResponseEntity<List<AttendanceRecordResponse>> getRecordsBySchedule(@PathVariable Integer scheduleId) {
        return ResponseEntity.ok(attendanceService.getRecordsBySchedule(scheduleId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AttendanceRecordResponse> getRecordById(@PathVariable Integer id) {
        return ResponseEntity.ok(attendanceService.getRecordById(id));
    }

    @PostMapping
    public ResponseEntity<AttendanceRecordResponse> createRecord(@RequestBody AttendanceRecordRequest request) {
        return ResponseEntity.ok(attendanceService.createRecord(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AttendanceRecordResponse> updateRecord(@PathVariable Integer id, @RequestBody AttendanceRecordRequest request) {
        return ResponseEntity.ok(attendanceService.updateRecord(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRecord(@PathVariable Integer id) {
        attendanceService.deleteRecord(id);
        return ResponseEntity.noContent().build();
    }
}
