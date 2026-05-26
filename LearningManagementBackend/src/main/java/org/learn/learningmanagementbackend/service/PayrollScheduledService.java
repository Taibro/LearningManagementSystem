package org.learn.learningmanagementbackend.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.learn.learningmanagementbackend.dto.projection.TaughtSessionDto;
import org.learn.learningmanagementbackend.enums.TeacherRole;
import org.learn.learningmanagementbackend.enums.TeacherSalaryStatus;
import org.learn.learningmanagementbackend.model.*;
import org.learn.learningmanagementbackend.repository.*;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Year;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PayrollScheduledService {
    private final TeacherSalarySheetRepository teacherSalarySheetRepository;

    private final TeacherRepository teacherRepository;
    private final AttendanceRecordRepository attendanceRecordRepository;
    private final SalaryConfigRepository salaryConfigRepository;
    private final TeacherSalaryDetailRepository salaryDetailRepository;

    private final ClassRepository classRepository;
    private final ScheduleRepository scheduleRepository;
    private final PayrollProcessor payrollProcessor;

    @Scheduled(cron = "0 59 23 L * ?")
    public void runMonthPayroll(){
        LocalDate today = LocalDate.now();
        int currentMonth = today.getMonthValue();
        int currentYear = today.getYear();

        log.info("BAT DAU TINN LUONG TU DONG CHO THANG {}/{}", currentMonth, currentYear);

        List<Teacher> allTeachers = teacherRepository.findAllTeachersWithUser();

        for (Teacher teacher : allTeachers){
            try{
                payrollProcessor.generatePayrollForTeacher(teacher, currentMonth, currentYear);
            }catch (Exception e){
                log.error("LOI KHI TINH LUONG CHO GIAO VIEN {} - {} : {}",
                        teacher.getTeacherCode(), teacher.getUser().getFullName(), e.getMessage());
            }
        }
        log.info("HOAN TAT TINH LUONG TU DONG THANG {}/{}", currentMonth, currentYear);
    }



}
