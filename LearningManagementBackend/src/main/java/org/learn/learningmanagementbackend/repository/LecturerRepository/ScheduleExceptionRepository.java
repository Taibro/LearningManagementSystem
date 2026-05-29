package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.ScheduleException;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ScheduleExceptionRepository extends JpaRepository<ScheduleException, Integer> {

    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "JOIN c.teacherLecturings ct " +
            "JOIN ct.teacher t " +
            "WHERE t.teacherCode = :teacherCode " +
            "ORDER BY se.createdAt DESC")
    List<ScheduleException> findHistoryByTeacherCode(@Param("teacherCode") String teacherCode);
    
    @Query("SELECT CASE WHEN COUNT(s) > 0 THEN true ELSE false END FROM Schedule s " +
            "JOIN s.classes c " +
            "JOIN c.teacherLecturings ct " +
            "JOIN ct.teacher t " +
            "WHERE s.id = :scheduleId AND t.teacherCode = :teacherCode")
    boolean isScheduleOwnedByTeacher(@Param("scheduleId") Integer scheduleId, @Param("teacherCode") String teacherCode);
}