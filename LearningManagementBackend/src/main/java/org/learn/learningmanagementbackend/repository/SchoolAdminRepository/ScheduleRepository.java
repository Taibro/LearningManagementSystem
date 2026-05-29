package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminScheduleRepository")
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    List<Schedule> findByClassesId(Integer classId);
    List<Schedule> findByRoomId(Integer roomId);
}
