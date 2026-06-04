package org.learn.learningmanagementbackend.service.LecturerService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.learn.learningmanagementbackend.dto.projection.TaughtSessionDto;
import org.learn.learningmanagementbackend.enums.TeacherRole;
import org.learn.learningmanagementbackend.enums.TeacherSalaryStatus;
import org.learn.learningmanagementbackend.model.*;
import org.learn.learningmanagementbackend.repository.LecturerRepository.*;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Year;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PayrollProcessor {

    private final TeacherSalarySheetRepository teacherSalarySheetRepository;

    private final TeacherRepository teacherRepository;
    private final AttendanceRecordRepository attendanceRecordRepository;
    private final SalaryConfigRepository salaryConfigRepository;
    private final TeacherSalaryDetailRepository salaryDetailRepository;
    private final ScheduleExceptionRepository scheduleExceptionRepository;

    private final ClassRepository classRepository;
    private final ScheduleRepository scheduleRepository;

    @Transactional(rollbackOn = Exception.class)
    public void generatePayrollForTeacher(Teacher teacher, int month, int year) {
        boolean isAlreadyGenerated = teacherSalarySheetRepository.existsByTeacherIdAndPeriodMonthAndPeriodYear(
                teacher.getId(), (byte) month, Year.of(year)
        );

        if (isAlreadyGenerated) {
            log.warn("PHIEU LUONG CUA GIAO VIEN {} THANG {}/{} DA TON TAI. BO QUA", teacher.getTeacherCode(), month, year);
            return;
        }

        SalaryConfig config = salaryConfigRepository.findActiveConfigByDegree(teacher.getDegree())
                .orElseThrow(() -> new RuntimeException("Khong tim thay cau hinh bang luong cho bang " + teacher.getDegree()));
        SalaryGrade grade = config.getSalaryGrade();

        List<TaughtSessionDto> taughtSessions = attendanceRecordRepository.getTaughtSessionsInMonth(
                teacher.getUser().getId(), month, year
        );

        List<ScheduleException> substituteSessions = scheduleExceptionRepository.findApprovedSubstitutionsInMonth(
                teacher.getId(), month, year
        );

        int totalActualSessions = taughtSessions.stream().mapToInt(TaughtSessionDto::getSessionCount).sum();
        int totalSubstituteSessions = substituteSessions.stream().mapToInt(se -> se.getSchedule().getEndPeriod() - se.getSchedule().getStartPeriod() + 1).sum();
        totalActualSessions += totalSubstituteSessions;

        TeacherSalarySheet sheet = new TeacherSalarySheet();
        sheet.setTeacher(teacher);
        sheet.setSalaryConfig(config);
        sheet.setSalaryGrade(grade);
        sheet.setSemester(null);
        sheet.setPeriodMonth(month);
        sheet.setPeriodYear(year);

        sheet.setDegreeSnapshot(teacher.getDegree());
        sheet.setCoefficientSnapshot(grade.getCoefficient());
        sheet.setBaseSalarySnapshot(config.getBaseSalary());
        sheet.setRateSnapshot(grade.getRatePerSession());

        // Tinh tien
        BigDecimal baseAmount = config.getBaseSalary().multiply(grade.getCoefficient());
        BigDecimal sessionAmount = grade.getRatePerSession().multiply(BigDecimal.valueOf(totalActualSessions));

        sheet.setPlannedSessions(0);
        sheet.setActualSessions(totalActualSessions);
        sheet.setBaseAmount(baseAmount);
        sheet.setSessionAmount(sessionAmount);
        sheet.setNetAmount(baseAmount.add(sessionAmount));
        sheet.setStatus(TeacherSalaryStatus.DRAFT);

        TeacherSalarySheet savedSheet = teacherSalarySheetRepository.save(sheet);

        for (TaughtSessionDto session : taughtSessions) {
            TeacherSalaryDetail detail = new TeacherSalaryDetail();
            detail.setTeacherSalarySheet(savedSheet);
            detail.setTeacher(teacher);

            Classes classes = classRepository.getReferenceById(session.getClassId());
            Schedule schedule = scheduleRepository.getReferenceById(session.getScheduleId());
            detail.setClasses(classes);
            detail.setSchedule(schedule);

            detail.setSessionDate(session.getSessionDate());
            detail.setSessionCount(session.getSessionCount());
            detail.setTeacherRole(TeacherRole.MAIN);
            detail.setRateSnapshot(grade.getRatePerSession());
            detail.setAmount(grade.getRatePerSession().multiply(BigDecimal.valueOf(session.getSessionCount())));

            salaryDetailRepository.save(detail);

        }

        for (ScheduleException se : substituteSessions) {
            TeacherSalaryDetail detail = new TeacherSalaryDetail();
            detail.setTeacherSalarySheet(savedSheet);
            detail.setTeacher(teacher);

            detail.setClasses(se.getSchedule().getClasses());
            detail.setSchedule(se.getSchedule());

            detail.setSessionDate(se.getExceptionDate());
            int sessionCount = se.getSchedule().getEndPeriod() - se.getSchedule().getStartPeriod() + 1;
            detail.setSessionCount(sessionCount);
            detail.setTeacherRole(TeacherRole.SUBSTITUTE);
            detail.setRateSnapshot(grade.getRatePerSession());
            detail.setAmount(grade.getRatePerSession().multiply(BigDecimal.valueOf(sessionCount)));

            salaryDetailRepository.save(detail);
        }

        log.info("Da tao xong phieu luong DRAT cho GV: {}", teacher.getTeacherCode());
    }
}
