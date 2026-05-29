package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.ScheduleException;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminScheduleExceptionRepository")
public interface ScheduleExceptionRepository extends JpaRepository<ScheduleException, Integer> {
    List<ScheduleException> findByScheduleId(Integer scheduleId);
}
