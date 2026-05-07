package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.ClassProgressDto;
import org.learn.learningmanagementbackend.dto.projection.WeeklyScheduleDto;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.ScheduleService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;


@RestController
@RequestMapping("/api/schedules")
@RequiredArgsConstructor
public class ScheduleController {

    private final ScheduleService scheduleService;

    @GetMapping("/weekly-schedule")
    public ResponseEntity<List<WeeklyScheduleDto>> getWeeklySchedule(
            @AuthenticationPrincipal CustomUserDetails currentUser,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date
            ){
        String teacherCode = currentUser.getSpecificCode();

        List<WeeklyScheduleDto> schedules = scheduleService.getTeacherWeeklySchedule(teacherCode, date);

        return ResponseEntity.ok(schedules);
    }

    @GetMapping("/progress-schedule")
    public ResponseEntity<List<ClassProgressDto>> getClassProgressSchedule(
        @AuthenticationPrincipal CustomUserDetails currentUser,
        @RequestParam(required = false) Integer semesterId,
        @RequestParam(required = false) Integer courseId,
        @RequestParam(required = false) Integer academicYearId
    ){
        String teacherCode = currentUser.getSpecificCode();

        List<ClassProgressDto> schedules = scheduleService.getTeacherProgressSchedule(teacherCode, semesterId, courseId, academicYearId);
        return ResponseEntity.ok(schedules);
    }
}
