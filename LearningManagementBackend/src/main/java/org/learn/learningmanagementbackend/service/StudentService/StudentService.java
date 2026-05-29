package org.learn.learningmanagementbackend.service.StudentService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.*;
import org.learn.learningmanagementbackend.repository.LecturerRepository.StudentRepository;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StudentService {

    private final StudentRepository studentRepository;

    // ── PROFILE ──────────────────────────────────────────────────────────────
    public StudentProfileDto getStudentProfile(String studentCode) {
        return studentRepository.getStudentProfileByCode(studentCode);
    }

    // ── WEEKLY SCHEDULE ───────────────────────────────────────────────────────
    public List<StudentScheduleDto> getWeeklySchedule(String studentCode, LocalDate targetDate) {
        if (targetDate == null) {
            targetDate = LocalDate.now();
        }
        LocalDate startOfWeek = targetDate.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek   = targetDate.with(DayOfWeek.SUNDAY);
        return studentRepository.getWeeklyScheduleForStudent(studentCode, startOfWeek, endOfWeek);
    }

    // ── PROGRESS SCHEDULE ─────────────────────────────────────────────────────
    public List<StudentScheduleDto> getProgressSchedule(String studentCode, Integer semesterId) {
        if (semesterId == null) {
            semesterId = 0;
        }
        return studentRepository.getProgressScheduleForStudent(studentCode, semesterId);
    }

    // ── GRADES ────────────────────────────────────────────────────────────────
    public List<StudentGradeDto> getGrades(String studentCode) {
        return studentRepository.getGradesForStudent(studentCode);
    }

    // ── ATTENDANCE ────────────────────────────────────────────────────────────
    public List<StudentAttendanceDto> getAttendance(String studentCode) {
        return studentRepository.getAttendanceForStudent(studentCode);
    }

    // ── CONDUCT ───────────────────────────────────────────────────────────────
    public List<StudentConductDto> getConduct(String studentCode) {
        return studentRepository.getConductForStudent(studentCode);
    }

    // ── TUITION ───────────────────────────────────────────────────────────────
    public List<StudentTuitionDto> getTuition(String studentCode) {
        return studentRepository.getTuitionForStudent(studentCode);
    }

    // ── NOTIFICATIONS ─────────────────────────────────────────────────────────
    public List<StudentNotificationDto> getNotifications(Integer userId) {
        return studentRepository.getNotificationsForUser(userId);
    }
}
