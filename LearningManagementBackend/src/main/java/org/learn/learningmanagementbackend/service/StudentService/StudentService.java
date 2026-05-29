package org.learn.learningmanagementbackend.service.StudentService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.*;
import org.learn.learningmanagementbackend.dto.request.SurveySubmitRequest;
import org.learn.learningmanagementbackend.model.*;
import org.learn.learningmanagementbackend.repository.LecturerRepository.*;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StudentService {

    private final StudentRepository studentRepository;
    private final TeacherEvaluationRepository evaluationRepository;
    private final ClassRepository classRepository;

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

    // ── SURVEYS ───────────────────────────────────────────────────────────────
    public List<StudentSurveyListDto> getSurveyList(String studentCode) {
        return studentRepository.getSurveyListForStudent(studentCode);
    }

    public void submitSurvey(String studentCode, SurveySubmitRequest req) {
        // Kiểm tra đã khảo sát lớp này chưa
        evaluationRepository.findByClassId(req.getClassId()).ifPresent(e -> {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Bạn đã khảo sát lớp học phần này rồi.");
        });

        // Lấy thông tin lớp
        Classes cls = classRepository.findById(req.getClassId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy lớp học phần."));

        // Lấy giảng viên chính của lớp
        Teacher mainTeacher = cls.getTeacherLecturings().stream()
                .filter(ct -> "main".equals(ct.getRole()))
                .map(ClassTeacher::getTeacher)
                .findFirst()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy giảng viên của lớp."));

        // Tạo đánh giá mới
        TeacherEvaluation ev = new TeacherEvaluation();
        ev.setTeacher(mainTeacher);
        ev.setSemester(cls.getSemester());
        ev.setClasses(cls);
        ev.setScoreKnowledge(req.getScoreKnowledge());
        ev.setScoreMethod(req.getScoreMethod());
        ev.setScoreInteraction(req.getScoreInteraction());
        ev.setScoreMaterials(req.getScoreMaterials());
        ev.setScorePunctuality(req.getScorePunctuality());
        ev.setComment(req.getComment());

        evaluationRepository.save(ev);
    }
}

