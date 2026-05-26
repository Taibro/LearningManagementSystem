package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.dto.projection.TaughtSessionDto;
import org.learn.learningmanagementbackend.model.AttendanceRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AttendanceRecordRepository extends JpaRepository<AttendanceRecord, Integer> {

    @Query(value = """
        SELECT 
            s.id AS scheduleId,
            c.id AS classId,
            ar.attendance_date AS sessionDate,
            (s.end_period - s.start_period + 1) AS sessionCount
        FROM Attendance_record ar
        JOIN Schedule s ON ar.schedule_id = s.id
        JOIN Class c ON s.class_id = c.id
        WHERE ar.checked_by = :userId
            AND MONTH(ar.attendance_date) = :month
            AND YEAR(ar.attendance_date) = :year
        GROUP BY s.id, c.id, ar.attendance_date, sessionCount
""", nativeQuery = true)
    List<TaughtSessionDto> getTaughtSessionsInMonth(
            @Param("userId") Integer userId,
            @Param("month") int month,
            @Param("year") int year
    );

}
