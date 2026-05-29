package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.dto.projection.*;
import org.learn.learningmanagementbackend.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {

    @Query("SELECT s FROM Student s JOIN FETCH s.user WHERE s.studentCode = :code")
    Optional<Student> findByStudentCode(@Param("code") String code);

    // ── PROFILE ──────────────────────────────────────────────
    @Query("""
            SELECT
                s.studentCode   AS studentCode,
                s.className     AS className,
                s.major         AS major,
                s.enrollmentYear AS enrollmentYear,
                d.name          AS departmentName,
                u.fullName      AS fullName,
                u.dateOfBirth   AS dateOfBirth,
                u.gender        AS gender,
                u.email         AS email,
                u.phone         AS phone,
                u.address       AS address,
                u.citizenIdNumber AS citizenIdNumber,
                u.avatarUrl     AS avatarUrl
            FROM Student s
            JOIN s.user u
            LEFT JOIN s.department d
            WHERE s.studentCode = :code
            """)
    StudentProfileDto getStudentProfileByCode(@Param("code") String code);

    // ── WEEKLY SCHEDULE ───────────────────────────────────────
    @Query(value = """
            SELECT
                co.name         AS courseName,
                co.code         AS courseCode,
                c.code          AS classCode,
                CONCAT(r.building, '-', r.room_number) AS roomName,
                sch.day_of_week AS dayOfWeek,
                sch.start_time  AS startTime,
                sch.end_time    AS endTime,
                sch.type        AS sessionType,
                sch.start_period AS startPeriod,
                sch.end_period  AS endPeriod,
                sch.start_date  AS startDate,
                sch.end_date    AS endDate,
                u.full_name     AS teacherName,
                co.credits      AS credits
            FROM Enrollment e
            JOIN Class c        ON e.class_id = c.id
            JOIN Course co      ON c.course_id = co.id
            JOIN Schedule sch   ON sch.class_id = c.id
            JOIN Room r         ON sch.room_id = r.id
            LEFT JOIN Class_Teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN Teacher t ON t.id = ct.teacher_id
            LEFT JOIN Users u   ON u.id = t.user_id
            WHERE e.student_id = (SELECT id FROM Student WHERE student_code = :studentCode)
              AND e.status = 'ENROLLED'
              AND sch.start_date <= :endDate
              AND sch.end_date   >= :startDate
              AND c.status != 'CANCELLED'
            """, nativeQuery = true)
    List<StudentScheduleDto> getWeeklyScheduleForStudent(
            @Param("studentCode") String studentCode,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate);

    // ── PROGRESS SCHEDULE ─────────────────────────────────────
    @Query(value = """
            SELECT
                co.name         AS courseName,
                co.code         AS courseCode,
                c.code          AS classCode,
                CONCAT(r.building, '-', r.room_number) AS roomName,
                sch.day_of_week AS dayOfWeek,
                sch.start_time  AS startTime,
                sch.end_time    AS endTime,
                sch.type        AS sessionType,
                sch.start_period AS startPeriod,
                sch.end_period  AS endPeriod,
                sch.start_date  AS startDate,
                sch.end_date    AS endDate,
                u.full_name     AS teacherName,
                co.credits      AS credits
            FROM Enrollment e
            JOIN Class c        ON e.class_id = c.id
            JOIN Course co      ON c.course_id = co.id
            JOIN Schedule sch   ON sch.class_id = c.id
            JOIN Room r         ON sch.room_id = r.id
            LEFT JOIN Class_Teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN Teacher t ON t.id = ct.teacher_id
            LEFT JOIN Users u   ON u.id = t.user_id
            WHERE e.student_id = (SELECT id FROM Student WHERE student_code = :studentCode)
              AND e.status = 'ENROLLED'
              AND (:semesterId = 0 OR c.semester_id = :semesterId)
              AND c.status != 'CANCELLED'
            ORDER BY sch.start_date, sch.day_of_week
            """, nativeQuery = true)
    List<StudentScheduleDto> getProgressScheduleForStudent(
            @Param("studentCode") String studentCode,
            @Param("semesterId") Integer semesterId);

    // ── GRADES ────────────────────────────────────────────────
    @Query(value = """
            SELECT
                sem.name        AS semesterName,
                co.code         AS courseCode,
                co.name         AS courseName,
                c.code          AS classCode,
                co.credits      AS credits,
                e.grade_attendance AS gradeAttendance,
                e.grade_midterm AS gradeMidterm,
                e.grade_final   AS gradeFinal,
                e.grade_total   AS gradeTotal,
                e.grade_letter  AS gradeLetter,
                e.status        AS enrollmentStatus
            FROM Enrollment e
            JOIN Class c        ON e.class_id = c.id
            JOIN Course co      ON c.course_id = co.id
            JOIN Semester sem   ON c.semester_id = sem.id
            WHERE e.student_id = (SELECT id FROM Student WHERE student_code = :studentCode)
            ORDER BY sem.start_date DESC, co.name
            """, nativeQuery = true)
    List<StudentGradeDto> getGradesForStudent(@Param("studentCode") String studentCode);

    // ── ATTENDANCE ────────────────────────────────────────────
    @Query(value = """
            SELECT
                sem.name  AS semesterName,
                c.code    AS classCode,
                co.name   AS courseName,
                co.credits AS credits,
                SUM(CASE WHEN ar.status = 'EXCUSED' THEN 1 ELSE 0 END) AS absentWithPermission,
                SUM(CASE WHEN ar.status = 'ABSENT'  THEN 1 ELSE 0 END) AS absentWithoutPermission,
                SUM(CASE WHEN ar.status = 'LATE'    THEN 1 ELSE 0 END) AS late
            FROM Enrollment e
            JOIN Class c        ON e.class_id = c.id
            JOIN Course co      ON c.course_id = co.id
            JOIN Semester sem   ON c.semester_id = sem.id
            LEFT JOIN Schedule sch ON sch.class_id = c.id
            LEFT JOIN Attendance_record ar
                ON ar.schedule_id = sch.id
                AND ar.student_id = e.student_id
            WHERE e.student_id = (SELECT id FROM Student WHERE student_code = :studentCode)
            GROUP BY sem.name, c.code, co.name, co.credits, sem.start_date
            ORDER BY sem.start_date DESC, co.name
            """, nativeQuery = true)
    List<StudentAttendanceDto> getAttendanceForStudent(@Param("studentCode") String studentCode);

    // ── CONDUCT / SCHOLARSHIP ─────────────────────────────────
    @Query("""
            SELECT
                sem.name          AS semesterName,
                sss.gpa           AS gpa,
                sss.creditsEarned AS creditsEarned,
                sss.conductScore  AS conductScore,
                sss.conductGrade  AS conductGrade,
                sss.scholarshipName   AS scholarshipName,
                sss.scholarshipAmount AS scholarshipAmount,
                sss.notes         AS notes
            FROM StudentSemesterSummary sss
            JOIN sss.semester sem
            WHERE sss.student.studentCode = :studentCode
            ORDER BY sem.startDate DESC
            """)
    List<StudentConductDto> getConductForStudent(@Param("studentCode") String studentCode);

    // ── TUITION ───────────────────────────────────────────────
    @Query("""
            SELECT
                ti.id            AS invoiceId,
                sem.name         AS semesterName,
                ti.totalAmount   AS totalAmount,
                ti.paidAmount    AS paidAmount,
                ti.dueDate       AS dueDate,
                ti.status        AS status
            FROM TuitionInvoice ti
            JOIN ti.semester sem
            WHERE ti.student.studentCode = :studentCode
            ORDER BY sem.startDate DESC
            """)
    List<StudentTuitionDto> getTuitionForStudent(@Param("studentCode") String studentCode);

    // ── NOTIFICATIONS ─────────────────────────────────────────
    @Query("""
            SELECT
                n.id        AS id,
                n.title     AS title,
                n.body      AS body,
                n.type      AS type,
                n.isRead    AS isRead,
                n.createdAt AS createdAt
            FROM Notification n
            WHERE n.user.id = :userId
            ORDER BY n.createdAt DESC
            """)
    List<StudentNotificationDto> getNotificationsForUser(@Param("userId") Integer userId);

    // ── SURVEYS: danh sách lớp học phần mà sinh viên đã đăng ký ─────────────
    @Query(value = """
            SELECT
                c.id                          AS classId,
                c.code                        AS classCode,
                co.name                       AS courseName,
                co.code                       AS courseCode,
                sem.name                      AS semesterName,
                u.full_name                   AS teacherName,
                CASE WHEN EXISTS (
                    SELECT 1 FROM teacher_evaluations te
                    WHERE te.class_id = c.id
                ) THEN 1 ELSE 0 END           AS isCompleted
            FROM Enrollment e
            JOIN Class c        ON e.class_id = c.id
            JOIN Course co      ON c.course_id = co.id
            JOIN Semester sem   ON c.semester_id = sem.id
            LEFT JOIN Class_Teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN Teacher t   ON t.id = ct.teacher_id
            LEFT JOIN Users u     ON u.id = t.user_id
            WHERE e.student_id = (SELECT id FROM Student WHERE student_code = :studentCode)
              AND e.status = 'ENROLLED'
            ORDER BY sem.start_date DESC, co.name
            """, nativeQuery = true)
    List<StudentSurveyListDto> getSurveyListForStudent(@Param("studentCode") String studentCode);
}



