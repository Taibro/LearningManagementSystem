package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminScheduleRepository")
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    List<Schedule> findByClassesId(Integer classId);
    List<Schedule> findByRoomId(Integer roomId);

    @org.springframework.data.jpa.repository.Query("SELECT s FROM Schedule s WHERE s.classes.course.department.school.id = :schoolId")
    List<Schedule> findBySchoolId(@org.springframework.data.repository.query.Param("schoolId") Integer schoolId);
}
