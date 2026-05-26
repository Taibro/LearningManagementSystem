package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.service.TeacherSalarySheetService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/salaries")
@RequiredArgsConstructor
public class SalaryController {

    private final TeacherSalarySheetService teacherSalarySheetService;

    @GetMapping("/monthly")
    public ResponseEntity<?> getMonthlySalary(
            @AuthenticationPrincipal CustomUserDetails currentUser,
            @RequestParam("year") Integer year,
            @RequestParam("month") Integer month
            ){
        String teacherCode = currentUser.getSpecificCode();

        return teacherSalarySheetService.getSalaryByMonthAndYear(teacherCode, year, month)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

}
