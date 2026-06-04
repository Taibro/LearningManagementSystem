package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AttendanceRecordRequest;
import org.learn.learningmanagementbackend.dto.response.AttendanceRecordResponse;
import org.learn.learningmanagementbackend.model.AttendanceRecord;
import org.learn.learningmanagementbackend.model.Schedule;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.AttendanceRecordRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.ScheduleRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.StudentRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminAttendanceRecordService")
@RequiredArgsConstructor
public class AttendanceRecordService {

    private final AttendanceRecordRepository attendanceRepository;
    private final ScheduleRepository scheduleRepository;
    private final StudentRepository studentRepository;
    private final UserRepository userRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<AttendanceRecordResponse> getAllRecords() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT u.school.id FROM Users u WHERE u.id = :userId", Integer.class)
                    .setParameter("userId", userId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<AttendanceRecord> records = entityManager.createQuery("SELECT a FROM AttendanceRecord a WHERE a.student.department.school.id = :schoolId", AttendanceRecord.class)
                .setParameter("schoolId", schoolId).getResultList();

        return records.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<AttendanceRecordResponse> getRecordsBySchedule(Integer scheduleId) {
        return attendanceRepository.findByScheduleId(scheduleId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public AttendanceRecordResponse getRecordById(Integer id) {
        AttendanceRecord record = attendanceRepository.findById(id).orElseThrow(() -> new RuntimeException("Record not found"));
        return mapToResponse(record);
    }

    public AttendanceRecordResponse createRecord(AttendanceRecordRequest request) {
        Schedule schedule = scheduleRepository.findById(request.getScheduleId())
                .orElseThrow(() -> new RuntimeException("Schedule not found"));
                
        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Student not found"));

        AttendanceRecord record = new AttendanceRecord();
        record.setSchedule(schedule);
        record.setStudent(student);
        record.setAttendanceDate(request.getAttendanceDate());
        record.setStatus(request.getStatus());
        record.setNote(request.getNote());

        if (request.getCheckedById() != null) {
            Users user = userRepository.findById(request.getCheckedById()).orElse(null);
            record.setCheckedBy(user);
        }

        return mapToResponse(attendanceRepository.save(record));
    }

    public AttendanceRecordResponse updateRecord(Integer id, AttendanceRecordRequest request) {
        AttendanceRecord record = attendanceRepository.findById(id).orElseThrow(() -> new RuntimeException("Record not found"));

        if (!record.getSchedule().getId().equals(request.getScheduleId())) {
            Schedule schedule = scheduleRepository.findById(request.getScheduleId())
                    .orElseThrow(() -> new RuntimeException("Schedule not found"));
            record.setSchedule(schedule);
        }

        if (!record.getStudent().getId().equals(request.getStudentId())) {
            Student student = studentRepository.findById(request.getStudentId())
                    .orElseThrow(() -> new RuntimeException("Student not found"));
            record.setStudent(student);
        }

        record.setAttendanceDate(request.getAttendanceDate());
        record.setStatus(request.getStatus());
        record.setNote(request.getNote());

        if (request.getCheckedById() != null) {
            Users user = userRepository.findById(request.getCheckedById()).orElse(null);
            record.setCheckedBy(user);
        }

        return mapToResponse(attendanceRepository.save(record));
    }

    public void deleteRecord(Integer id) {
        attendanceRepository.deleteById(id);
    }

    private AttendanceRecordResponse mapToResponse(AttendanceRecord record) {
        AttendanceRecordResponse response = new AttendanceRecordResponse();
        response.setId(record.getId());
        
        if (record.getSchedule() != null) {
            response.setScheduleId(record.getSchedule().getId());
            if (record.getSchedule().getClasses() != null) {
                response.setScheduleDetails(record.getSchedule().getClasses().getCode() + " - Thứ " + record.getSchedule().getDayOfWeek());
            }
        }
        
        if (record.getStudent() != null) {
            response.setStudentId(record.getStudent().getId());
            response.setStudentCode(record.getStudent().getStudentCode());
            if (record.getStudent().getUser() != null) {
                response.setStudentName(record.getStudent().getUser().getFullName());
            }
        }
        
        response.setAttendanceDate(record.getAttendanceDate());
        response.setStatus(record.getStatus());
        response.setNote(record.getNote());
        
        if (record.getCheckedBy() != null) {
            response.setCheckedById(record.getCheckedBy().getId());
            response.setCheckedByName(record.getCheckedBy().getFullName());
        }
        response.setCheckedAt(record.getCheckedAt());
        
        return response;
    }
}
