package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.ScheduleException;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleExceptionRepository extends JpaRepository<ScheduleException, Integer> {

    @Query("SELECT DISTINCT se FROM ScheduleException se " +
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

    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "JOIN c.teacherLecturings ct " +
            "JOIN ct.teacher t " +
            "WHERE t.teacherCode = :teacherCode " +
            "AND se.makeupStatus IS NOT NULL " +
            "ORDER BY se.replacementDate DESC")
    List<ScheduleException> findMakeupHistoryByTeacherCode(@Param("teacherCode") String teacherCode);

    // Hàm lấy danh sách buổi nghỉ chưa xin bù
    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "JOIN c.teacherLecturings ct " +
            "JOIN ct.teacher t " +
            "WHERE t.teacherCode = :teacherCode " +
            "AND se.exceptionType = 'CANCELLED' " +
            "AND se.makeupStatus IS NULL " +
            "ORDER BY se.exceptionDate DESC")
    List<ScheduleException> findAvailableCancelledSessions(@Param("teacherCode") String teacherCode);

    // Lấy lịch sử dạy thay
    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "JOIN c.teacherLecturings ct " +
            "JOIN ct.teacher t " +
            "WHERE t.teacherCode = :teacherCode " +
            "AND se.exceptionType = 'SUBSTITUTED' " +
            "ORDER BY se.createdAt DESC")
    List<ScheduleException> findSubstituteHistoryByTeacherCode(@Param("teacherCode") String teacherCode);

    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "WHERE se.substituteTeacher.id = :teacherId " +
            "AND se.substituteStatus = 'APPROVED' " +
            "AND MONTH(se.exceptionDate) = :month " +
            "AND YEAR(se.exceptionDate) = :year")
    List<ScheduleException> findApprovedSubstitutionsInMonth(
            @Param("teacherId") Integer teacherId,
            @Param("month") int month,
            @Param("year") int year);
}