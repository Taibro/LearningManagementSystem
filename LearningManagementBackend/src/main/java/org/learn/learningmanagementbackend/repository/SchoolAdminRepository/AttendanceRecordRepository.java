package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.AttendanceRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository("schoolAdminAttendanceRecordRepository")
public interface AttendanceRecordRepository extends JpaRepository<AttendanceRecord, Integer> {
    List<AttendanceRecord> findByScheduleId(Integer scheduleId);
    List<AttendanceRecord> findByStudentId(Integer studentId);
    List<AttendanceRecord> findByAttendanceDate(LocalDate attendanceDate);
}
