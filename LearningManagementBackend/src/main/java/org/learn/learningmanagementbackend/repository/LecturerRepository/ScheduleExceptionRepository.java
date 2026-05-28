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
            "WHERE c.teacher.teacherCode = :teacherCode " +
            "ORDER BY se.createdAt DESC")
    List<ScheduleException> findExceptionHistoryByTeacherCode(@Param("teacherCode") String teacherCode);
}