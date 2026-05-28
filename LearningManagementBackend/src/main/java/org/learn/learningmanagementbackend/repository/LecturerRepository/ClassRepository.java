package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.dto.projection.ClassProgressDto;
import org.learn.learningmanagementbackend.model.Classes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClassRepository extends JpaRepository<Classes, Integer> {

    @Query(value = """
            SELECT
                            c.id AS classId,
                            co.name AS courseName,
                            co.code AS courseCode,
                            c.code AS classCode,
                            c.status AS classStatus,
                            co.total_sessions AS totalPeriods,
                            COALESCE(taught.taughtPeriods, 0) AS taughtPeriods
            FROM Class c
            JOIN Course co ON c.course_id = co.id
            JOIN Class_Teacher ct ON c.id = ct.class_id
            JOIN Teacher t ON ct.teacher_id = t.id
            JOIN Semester sem ON sem.id = c.semester_id
            JOIN Academic_year acad ON acad.id = sem.academic_year_id
            LEFT JOIN (
                            SELECT 
                                            s.class_id,
                                            SUM((s.end_period - s.start_period + 1) * att.session_count) AS taughtPeriods
                            FROM Schedule s
                            JOIN (
                                            SELECT schedule_id, COUNT(DISTINCT attendance_date) AS session_count
                                            FROM Attendance_record
                                            GROUP BY schedule_id
                                        ) att ON s.id = att.schedule_id
                                        GROUP BY s.class_id
                        ) taught ON taught.class_id = c.id
                        WHERE t.teacher_code = :teacherCode
                        AND (:semesterId = 0 OR c.semester_id = :semesterId)
                        AND (:courseId = 0 OR c.course_id = :courseId)
                        AND (:academicYearId = 0 OR acad.id = :academicYearId)
                        ORDER BY c.created_at DESC
            """, nativeQuery = true)
    List<ClassProgressDto> getTeacherClassProgress(
            @Param("teacherCode") String teacherCode,
            @Param("semesterId") Integer semesterId,
            @Param("courseId") Integer courseId,
            @Param("academicYearId") Integer academicYearId
    );

}
