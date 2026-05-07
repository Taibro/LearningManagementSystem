package org.learn.learningmanagementbackend.service;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.ClassProgressDto;
import org.learn.learningmanagementbackend.dto.projection.WeeklyScheduleDto;
import org.learn.learningmanagementbackend.repository.ClassRepository;
import org.learn.learningmanagementbackend.repository.ScheduleRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;

    private final ClassRepository classRepository;

    public List<WeeklyScheduleDto> getTeacherWeeklySchedule(String teacherCode, LocalDate targetDate){
        if (targetDate == null){
            targetDate = LocalDate.now();
        }

        LocalDate startOfWeek = targetDate.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = targetDate.with(DayOfWeek.SUNDAY);

        return scheduleRepository.getWeeklyScheduleForTeacher(teacherCode, startOfWeek, endOfWeek);
    }

    public List<ClassProgressDto> getTeacherProgressSchedule(String teacherCode, Integer semesterId, Integer courseId, Integer academicYearId){
        if (semesterId == null){
            semesterId = 0;
        }

        if (courseId == null){
            courseId = 0;
        }

        if (academicYearId == null){
            academicYearId = 0;
        }
        return classRepository.getTeacherClassProgress(teacherCode, semesterId, courseId, academicYearId);
    }
}
