package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ScheduleRequest;
import org.learn.learningmanagementbackend.dto.response.ScheduleResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.ScheduleService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminScheduleController")
@RequestMapping("/api/auth/school-admin/schedules")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ScheduleController {

    private final ScheduleService scheduleService;

    @GetMapping
    public ResponseEntity<List<ScheduleResponse>> getAllSchedulesBySchool() {
        return ResponseEntity.ok(scheduleService.getAllSchedulesBySchool());
    }

    @GetMapping("/class/{classId}")
    public ResponseEntity<List<ScheduleResponse>> getAllSchedulesByClass(@PathVariable Integer classId) {
        return ResponseEntity.ok(scheduleService.getAllSchedulesByClass(classId));
    }

    @GetMapping("/room/{roomId}")
    public ResponseEntity<List<ScheduleResponse>> getAllSchedulesByRoom(@PathVariable Integer roomId) {
        return ResponseEntity.ok(scheduleService.getAllSchedulesByRoom(roomId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ScheduleResponse> getScheduleById(@PathVariable Integer id) {
        return ResponseEntity.ok(scheduleService.getScheduleById(id));
    }

    @PostMapping
    public ResponseEntity<ScheduleResponse> createSchedule(@RequestBody ScheduleRequest request) {
        return ResponseEntity.ok(scheduleService.createSchedule(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ScheduleResponse> updateSchedule(@PathVariable Integer id, @RequestBody ScheduleRequest request) {
        return ResponseEntity.ok(scheduleService.updateSchedule(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSchedule(@PathVariable Integer id) {
        scheduleService.deleteSchedule(id);
        return ResponseEntity.noContent().build();
    }
}
