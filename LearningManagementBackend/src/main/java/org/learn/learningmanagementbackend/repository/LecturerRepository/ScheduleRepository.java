package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.dto.projection.WeeklyScheduleDto;
import org.learn.learningmanagementbackend.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {

    @Query(
            value = """
                            SELECT 
                                co.name as courseName,
                                c.code as classCode,
                                CONCAT(r.building, '-', r.room_number) AS roomName,
                                s.day_of_week AS dayOfWeek,
                                s.start_time AS startTime,
                                s.end_time AS endTime,
                                s.type AS sessionType,
                                s.start_period AS startPeriod,
                                s.end_period AS endPeriod
                            FROM schedules s
                            JOIN classes c ON s.class_id = c.id
                            JOIN courses co ON c.course_id = co.id
                            JOIN class_teacher ct ON c.id = ct.class_id
                            JOIN rooms r ON s.room_id = r.id
                            JOIN school_branches sb on sb.id = r.branch_id
                            WHERE ct.teacher_id = (SELECT id FROM teachers WHERE teacher_code = :teacherCode)
                            AND s.start_date <= :endDate
                            AND s.end_date >= :startDate
                            AND c.status != 'CANCELLED'
                    """, nativeQuery = true
    )
    List<WeeklyScheduleDto> getWeeklyScheduleForTeacher(
            @Param("teacherCode") String teacherCode,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate
    );

    @Query("SELECT s FROM Schedule s WHERE s.classes.id = :classId " +
            "AND :today BETWEEN s.startDate AND s.endDate " +
            "AND s.dayOfWeek = :dayOfWeek")
    Optional<Schedule> findTodayScheduleForClass(
            @Param("classId") Integer classId,
            @Param("today") LocalDate today,
            @Param("dayOfWeek") Integer dayOfWeek);

    @Query("SELECT COUNT(s) FROM Schedule s WHERE s.classes.id = :classId")
    Long countTotalSessionsByClassId(@Param("classId") Integer classId);

    // Lấy tất cả lịch theo class_id (cho check trùng lịch khi đăng ký)
    List<Schedule> findByClasses_Id(Integer classId);

    // Lấy lịch học hiện tại của sinh viên (để check trùng lịch)
    @Query("""
            SELECT sch FROM Schedule sch
            JOIN sch.classes cls
            JOIN cls.enrollments enr
            WHERE enr.student.id = :studentId
              AND enr.status IN ('ENROLLED', 'PENDING')
            """)
    List<Schedule> findActiveSchedulesForStudent(@Param("studentId") Integer studentId);
}
