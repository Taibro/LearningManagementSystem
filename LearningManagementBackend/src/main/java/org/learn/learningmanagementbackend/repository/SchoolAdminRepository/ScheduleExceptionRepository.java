package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminScheduleExceptionRepository")
public interface ScheduleExceptionRepository extends JpaRepository<ScheduleException, Integer> {
    List<ScheduleException> findByScheduleId(Integer scheduleId);

    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "JOIN FETCH c.course co " +
            "JOIN FETCH co.department d " +
            "WHERE d.school.id = :schoolId " +
            "AND se.approvalStatus = :status " +
            "ORDER BY se.createdAt DESC")
    List<ScheduleException> findBySchoolIdAndApprovalStatus(@Param("schoolId") Integer schoolId,
                                                             @Param("status") ApprovalStatus status);
}
