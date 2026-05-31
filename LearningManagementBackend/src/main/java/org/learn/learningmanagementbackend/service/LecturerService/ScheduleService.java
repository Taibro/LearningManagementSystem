package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.ClassProgressDto;
import org.learn.learningmanagementbackend.dto.projection.WeeklyScheduleDto;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ClassRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ScheduleRepository;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;

    private final ClassRepository classRepository;

    private final org.learn.learningmanagementbackend.repository.LecturerRepository.SemesterRepository semesterRepository;

    public List<WeeklyScheduleDto> getTeacherWeeklySchedule(String teacherCode, LocalDate targetDate) {
        if (targetDate == null) {
            targetDate = LocalDate.now();
        }

        LocalDate startOfWeek = targetDate.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = targetDate.with(DayOfWeek.SUNDAY);

        return scheduleRepository.getWeeklyScheduleForTeacher(teacherCode, startOfWeek, endOfWeek);
    }

    public List<ClassProgressDto> getTeacherProgressSchedule(String teacherCode, Integer semesterId, Integer courseId, Integer academicYearId) {
        if (semesterId == null) {
            semesterId = 0;
        }

        if (courseId == null) {
            courseId = 0;
        }

        if (academicYearId == null) {
            academicYearId = 0;
        }
        return classRepository.getTeacherClassProgress(teacherCode, semesterId, courseId, academicYearId);
    }

    public List<org.learn.learningmanagementbackend.dto.response.ActiveClassScheduleDto> getActiveClassesWithSchedules(String teacherCode) {
        List<org.learn.learningmanagementbackend.model.Classes> classes = classRepository.findActiveClassesWithSchedulesByTeacher(teacherCode);
        
        return classes.stream().map(cls -> {
            List<org.learn.learningmanagementbackend.dto.response.ActiveClassScheduleDto.ScheduleDetail> scheduleDetails = cls.getSchedules().stream()
                .map(s -> org.learn.learningmanagementbackend.dto.response.ActiveClassScheduleDto.ScheduleDetail.builder()
                    .scheduleId(s.getId())
                    .dayOfWeek(s.getDayOfWeek())
                    .startPeriod(s.getStartPeriod())
                    .endPeriod(s.getEndPeriod())
                    .roomName(s.getRoom().getBuilding() + "-" + s.getRoom().getRoomNumber())
                    .build())
                .toList();

            return org.learn.learningmanagementbackend.dto.response.ActiveClassScheduleDto.builder()
                .classId(cls.getId())
                .classCode(cls.getCode())
                .courseName(cls.getCourse().getName())
                .schedules(scheduleDetails)
                .build();
        }).toList();
    }
}
