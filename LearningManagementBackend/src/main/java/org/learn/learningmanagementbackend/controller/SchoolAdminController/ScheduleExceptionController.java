package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ScheduleExceptionRequest;
import org.learn.learningmanagementbackend.dto.response.ScheduleExceptionResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.ScheduleExceptionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminScheduleExceptionController")
@RequestMapping("/api/auth/school-admin/schedule-exceptions")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ScheduleExceptionController {

    private final ScheduleExceptionService exceptionService;

    @GetMapping
    public ResponseEntity<List<ScheduleExceptionResponse>> getAllExceptions() {
        return ResponseEntity.ok(exceptionService.getAllExceptions());
    }

    @GetMapping("/schedule/{scheduleId}")
    public ResponseEntity<List<ScheduleExceptionResponse>> getExceptionsBySchedule(@PathVariable Integer scheduleId) {
        return ResponseEntity.ok(exceptionService.getExceptionsBySchedule(scheduleId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ScheduleExceptionResponse> getExceptionById(@PathVariable Integer id) {
        return ResponseEntity.ok(exceptionService.getExceptionById(id));
    }

    @PostMapping
    public ResponseEntity<ScheduleExceptionResponse> createException(@RequestBody ScheduleExceptionRequest request) {
        return ResponseEntity.ok(exceptionService.createException(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ScheduleExceptionResponse> updateException(@PathVariable Integer id, @RequestBody ScheduleExceptionRequest request) {
        return ResponseEntity.ok(exceptionService.updateException(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteException(@PathVariable Integer id) {
        exceptionService.deleteException(id);
        return ResponseEntity.noContent().build();
    }
}
