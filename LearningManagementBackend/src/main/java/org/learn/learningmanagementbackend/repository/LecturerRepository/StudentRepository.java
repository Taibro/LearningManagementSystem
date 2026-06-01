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
            FROM enrollments e
            JOIN classes c        ON e.class_id = c.id
            JOIN courses co      ON c.course_id = co.id
            JOIN schedules sch   ON sch.class_id = c.id
            JOIN rooms r         ON sch.room_id = r.id
            LEFT JOIN Class_Teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t ON t.id = ct.teacher_id
            LEFT JOIN users u   ON u.id = t.user_id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
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
            FROM enrollments e
            JOIN classes c        ON e.class_id = c.id
            JOIN courses co      ON c.course_id = co.id
            JOIN schedules sch   ON sch.class_id = c.id
            JOIN rooms r         ON sch.room_id = r.id
            LEFT JOIN Class_Teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t ON t.id = ct.teacher_id
            LEFT JOIN users u   ON u.id = t.user_id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
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
            FROM enrollments e
            JOIN classes c        ON e.class_id = c.id
            JOIN courses co      ON c.course_id = co.id
            JOIN semesters sem   ON c.semester_id = sem.id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
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
            FROM enrollments e
            JOIN classes c        ON e.class_id = c.id
            JOIN courses co      ON c.course_id = co.id
            JOIN semesters sem   ON c.semester_id = sem.id
            LEFT JOIN schedules sch ON sch.class_id = c.id
            LEFT JOIN attendance_records ar
                ON ar.schedule_id = sch.id
                AND ar.student_id = e.student_id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
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
                sem.id           AS semesterId,
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

    // ── DEBT DETAIL: chi tiết công nợ từng môn học ─────────────────────────────
    @Query(value = """
            SELECT
                sem.id                                   AS semesterId,
                sem.name                                 AS semesterName,
                DATE_FORMAT(sem.start_date, '%Y-%m-%d')  AS semesterStartDate,
                c.code                                   AS classCode,
                co.code                                  AS courseCode,
                co.name                                  AS courseName,
                co.credits                               AS credits,
                (co.credits * 1135000)                   AS mucNop,
                -- Phân bổ tiền đã nộp tỉ lệ theo môn (= mucNop nếu đã đủ, 0 nếu chưa)
                CASE
                    WHEN ti.status = 'PAID'    THEN (co.credits * 1135000)
                    WHEN ti.status = 'PARTIAL' THEN
                        LEAST((co.credits * 1135000),
                              GREATEST(0, ti.paid_amount - (
                                  SELECT COALESCE(SUM(co2.credits * 1135000), 0)
                                  FROM enrollments e2
                                  JOIN classes c2 ON c2.id = e2.class_id
                                  JOIN courses co2 ON co2.id = c2.course_id
                                  WHERE e2.student_id = e.student_id
                                    AND c2.semester_id = sem.id
                                    AND e2.id < e.id
                                    AND e2.status IN ('ENROLLED','COMPLETED','FAILED')
                              )))
                    ELSE 0
                END                                      AS soTienNop,
                CASE WHEN ti.status = 'PAID' THEN 1
                     WHEN ti.status = 'PARTIAL' AND
                          (co.credits * 1135000) <= (ti.paid_amount - (
                              SELECT COALESCE(SUM(co2.credits * 1135000), 0)
                              FROM enrollments e2
                              JOIN classes c2 ON c2.id = e2.class_id
                              JOIN courses co2 ON co2.id = c2.course_id
                              WHERE e2.student_id = e.student_id
                                AND c2.semester_id = sem.id
                                AND e2.id < e.id
                                AND e2.status IN ('ENROLLED','COMPLETED','FAILED')
                          )) THEN 1
                     ELSE 0
                END                                      AS isPaid,
                CASE WHEN ti.status = 'PAID'
                     THEN DATE_FORMAT(ti.updated_at, '%d/%m/%Y')
                     ELSE NULL
                END                                      AS paidDate,
                COALESCE(ti.paid_amount, 0)              AS invoicePaid,
                COALESCE(ti.total_amount, co.credits * 1135000) AS invoiceTotal
            FROM enrollments e
            JOIN classes c ON c.id = e.class_id
            JOIN courses co ON co.id = c.course_id
            JOIN semesters sem ON sem.id = c.semester_id
            LEFT JOIN tuition_invoices ti ON ti.student_id = e.student_id AND ti.semester_id = sem.id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
              AND e.status IN ('ENROLLED', 'COMPLETED', 'FAILED')
              AND (:semesterId = 0 OR sem.id = :semesterId)
            ORDER BY sem.start_date DESC, e.id ASC
            """, nativeQuery = true)
    List<StudentDebtDetailDto> getDebtDetail(
            @Param("studentCode") String studentCode,
            @Param("semesterId")  Integer semesterId);

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
            FROM enrollments e
            JOIN classes c        ON e.class_id = c.id
            JOIN courses co      ON c.course_id = co.id
            JOIN semesters sem   ON c.semester_id = sem.id
            LEFT JOIN Class_Teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t   ON t.id = ct.teacher_id
            LEFT JOIN users u     ON u.id = t.user_id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
              AND e.status = 'ENROLLED'
            ORDER BY sem.start_date DESC, co.name
            """, nativeQuery = true)
    List<StudentSurveyListDto> getSurveyListForStudent(@Param("studentCode") String studentCode);

    // ── ĐĂNG KÝ THƯỜNG: lớp OPEN trong HK, SV chưa có môn này (ENROLLED/COMPLETED) ──
    @Query(value = """
            SELECT
                c.id                AS classId,
                c.code              AS classCode,
                co.id               AS courseId,
                co.code             AS courseCode,
                co.name             AS courseName,
                co.credits          AS credits,
                sem.id              AS semesterId,
                sem.name            AS semesterName,
                u.full_name         AS teacherName,
                (SELECT COUNT(*) FROM enrollments en
                    WHERE en.class_id = c.id AND en.status IN ('ENROLLED','PENDING')) AS enrolledCount,
                c.max_students      AS maxStudents,
                sch.day_of_week     AS dayOfWeek,
                TIME_FORMAT(sch.start_time,'%H:%i') AS startTime,
                TIME_FORMAT(sch.end_time,'%H:%i')   AS endTime,
                sch.start_period    AS startPeriod,
                sch.end_period      AS endPeriod,
                r.room_number       AS roomNumber,
                r.building          AS building,
                CASE WHEN EXISTS (
                    SELECT 1 FROM enrollments ex
                    WHERE ex.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
                      AND ex.class_id = c.id AND ex.status IN ('ENROLLED','PENDING')
                ) THEN 1 ELSE 0 END AS alreadyEnrolled
            FROM classes c
            JOIN courses co ON co.id = c.course_id
            JOIN semesters sem ON sem.id = c.semester_id
            LEFT JOIN class_teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t ON t.id = ct.teacher_id
            LEFT JOIN users u ON u.id = t.user_id
            LEFT JOIN schedules sch ON sch.class_id = c.id
            LEFT JOIN rooms r ON r.id = sch.room_id
            WHERE c.status = 'OPEN'
              AND (:semesterId = 0 OR sem.id = :semesterId)
              AND co.id NOT IN (
                  SELECT c2.course_id FROM enrollments e2
                  JOIN classes c2 ON c2.id = e2.class_id
                  WHERE e2.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
                    AND e2.status IN ('ENROLLED','PENDING','COMPLETED')
              )
            ORDER BY co.name, c.code
            """, nativeQuery = true)
    List<StudentCourseRegDto> getAvailableClasses(
            @Param("studentCode") String studentCode,
            @Param("semesterId")  Integer semesterId);

    // ── HỌC LẠI: lớp OPEN của môn sinh viên đã FAILED ───────────────────────────
    @Query(value = """
            SELECT
                c.id                AS classId,
                c.code              AS classCode,
                co.id               AS courseId,
                co.code             AS courseCode,
                co.name             AS courseName,
                co.credits          AS credits,
                sem.id              AS semesterId,
                sem.name            AS semesterName,
                u.full_name         AS teacherName,
                (SELECT COUNT(*) FROM enrollments en
                    WHERE en.class_id = c.id AND en.status IN ('ENROLLED','PENDING')) AS enrolledCount,
                c.max_students      AS maxStudents,
                sch.day_of_week     AS dayOfWeek,
                TIME_FORMAT(sch.start_time,'%H:%i') AS startTime,
                TIME_FORMAT(sch.end_time,'%H:%i')   AS endTime,
                sch.start_period    AS startPeriod,
                sch.end_period      AS endPeriod,
                r.room_number       AS roomNumber,
                r.building          AS building,
                CASE WHEN EXISTS (
                    SELECT 1 FROM enrollments ex
                    WHERE ex.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
                      AND ex.class_id = c.id AND ex.status IN ('ENROLLED','PENDING')
                ) THEN 1 ELSE 0 END AS alreadyEnrolled
            FROM classes c
            JOIN courses co ON co.id = c.course_id
            JOIN semesters sem ON sem.id = c.semester_id
            LEFT JOIN class_teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t ON t.id = ct.teacher_id
            LEFT JOIN users u ON u.id = t.user_id
            LEFT JOIN schedules sch ON sch.class_id = c.id
            LEFT JOIN rooms r ON r.id = sch.room_id
            WHERE c.status = 'OPEN'
              AND (:semesterId = 0 OR sem.id = :semesterId)
              AND co.id IN (
                  SELECT c2.course_id FROM enrollments e2
                  JOIN classes c2 ON c2.id = e2.class_id
                  WHERE e2.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
                    AND e2.status = 'FAILED'
              )
            ORDER BY co.name, c.code
            """, nativeQuery = true)
    List<StudentCourseRegDto> getRetakeClasses(
            @Param("studentCode") String studentCode,
            @Param("semesterId")  Integer semesterId);

    // ── HỌC CẢI THIỆN: lớp OPEN của môn sinh viên đã COMPLETED ─────────────────
    @Query(value = """
            SELECT
                c.id                AS classId,
                c.code              AS classCode,
                co.id               AS courseId,
                co.code             AS courseCode,
                co.name             AS courseName,
                co.credits          AS credits,
                sem.id              AS semesterId,
                sem.name            AS semesterName,
                u.full_name         AS teacherName,
                (SELECT COUNT(*) FROM enrollments en
                    WHERE en.class_id = c.id AND en.status IN ('ENROLLED','PENDING')) AS enrolledCount,
                c.max_students      AS maxStudents,
                sch.day_of_week     AS dayOfWeek,
                TIME_FORMAT(sch.start_time,'%H:%i') AS startTime,
                TIME_FORMAT(sch.end_time,'%H:%i')   AS endTime,
                sch.start_period    AS startPeriod,
                sch.end_period      AS endPeriod,
                r.room_number       AS roomNumber,
                r.building          AS building,
                CASE WHEN EXISTS (
                    SELECT 1 FROM enrollments ex
                    WHERE ex.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
                      AND ex.class_id = c.id AND ex.status IN ('ENROLLED','PENDING')
                ) THEN 1 ELSE 0 END AS alreadyEnrolled
            FROM classes c
            JOIN courses co ON co.id = c.course_id
            JOIN semesters sem ON sem.id = c.semester_id
            LEFT JOIN class_teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t ON t.id = ct.teacher_id
            LEFT JOIN users u ON u.id = t.user_id
            LEFT JOIN schedules sch ON sch.class_id = c.id
            LEFT JOIN rooms r ON r.id = sch.room_id
            WHERE c.status = 'OPEN'
              AND (:semesterId = 0 OR sem.id = :semesterId)
              AND co.id IN (
                  SELECT c2.course_id FROM enrollments e2
                  JOIN classes c2 ON c2.id = e2.class_id
                  WHERE e2.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
                    AND e2.status = 'COMPLETED'
              )
            ORDER BY co.name, c.code
            """, nativeQuery = true)
    List<StudentCourseRegDto> getImproveClasses(
            @Param("studentCode") String studentCode,
            @Param("semesterId")  Integer semesterId);

    // ── LẤY DANH SÁCH ĐÃ ĐĂNG KÝ TRONG HỌC KỲ ──────────────────────────────────
    @Query(value = """
            SELECT
                c.id                AS classId,
                c.code              AS classCode,
                co.id               AS courseId,
                co.code             AS courseCode,
                co.name             AS courseName,
                co.credits          AS credits,
                sem.id              AS semesterId,
                sem.name            AS semesterName,
                u.full_name         AS teacherName,
                (SELECT COUNT(*) FROM enrollments en
                    WHERE en.class_id = c.id AND en.status IN ('ENROLLED','PENDING')) AS enrolledCount,
                c.max_students      AS maxStudents,
                sch.day_of_week     AS dayOfWeek,
                TIME_FORMAT(sch.start_time,'%H:%i') AS startTime,
                TIME_FORMAT(sch.end_time,'%H:%i')   AS endTime,
                sch.start_period    AS startPeriod,
                sch.end_period      AS endPeriod,
                r.room_number       AS roomNumber,
                r.building          AS building,
                1                   AS alreadyEnrolled
            FROM enrollments e
            JOIN classes c ON c.id = e.class_id
            JOIN courses co ON co.id = c.course_id
            JOIN semesters sem ON sem.id = c.semester_id
            LEFT JOIN class_teacher ct ON ct.class_id = c.id AND ct.role = 'main'
            LEFT JOIN teachers t ON t.id = ct.teacher_id
            LEFT JOIN users u ON u.id = t.user_id
            LEFT JOIN schedules sch ON sch.class_id = c.id
            LEFT JOIN rooms r ON r.id = sch.room_id
            WHERE e.student_id = (SELECT id FROM students WHERE student_code = :studentCode)
              AND e.status IN ('ENROLLED', 'PENDING')
              AND (:semesterId = 0 OR sem.id = :semesterId)
            ORDER BY co.name, c.code
            """, nativeQuery = true)
    List<StudentCourseRegDto> getEnrolledClasses(
            @Param("studentCode") String studentCode,
            @Param("semesterId")  Integer semesterId);
}
