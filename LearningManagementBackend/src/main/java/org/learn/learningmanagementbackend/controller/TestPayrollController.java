package org.learn.learningmanagementbackend.controller;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.service.PayrollScheduledService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test-payroll")
@RequiredArgsConstructor
public class TestPayrollController {

    private final PayrollScheduledService payrollScheduledService;

    @PostMapping("/run-now")
    public ResponseEntity<String> forceRunPayroll(){
        payrollScheduledService.runMonthPayroll();
        return ResponseEntity.ok("Da kich hoat chay chot luong");
    }

}
