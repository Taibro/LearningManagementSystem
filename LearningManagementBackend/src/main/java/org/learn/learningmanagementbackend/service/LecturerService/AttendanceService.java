package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AttendanceSaveRequest;
import org.learn.learningmanagementbackend.dto.response.AttendanceListResponse;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;
import org.learn.learningmanagementbackend.model.AttendanceRecord;
import org.learn.learningmanagementbackend.model.Enrollment;
import org.learn.learningmanagementbackend.repository.LecturerRepository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AttendanceService {

    private final EnrollmentRepository enrollmentRepository;
    private final AttendanceRecordRepository attendanceRepository;
    private final ScheduleRepository scheduleRepository;
    private final StudentRepository studentRepository;
    private final UserRepository userRepository;

    public AttendanceListResponse getAttendanceList(Integer classId, Integer scheduleId, LocalDate date) {

        List<Enrollment> enrollments = enrollmentRepository.getEnrolledStudentsByClassId(classId);

        List<AttendanceRecord> existingRecords = attendanceRepository.findByScheduleIdAndAttendanceDate(scheduleId, date);

        Map<Integer, AttendanceStatus> attendanceMap = existingRecords.stream()
                .collect(Collectors.toMap(
                        rec -> rec.getStudent().getId(),
                        AttendanceRecord::getStatus
                ));

        int countPresent = 0;
        int countAbsent = 0;

        List<AttendanceListResponse.StudentAttendanceDto> studentDtos = enrollments.stream().map(enrollment -> {
            Integer studentId = enrollment.getStudent().getId();
            String status = String.valueOf(attendanceMap.get(studentId));

            return AttendanceListResponse.StudentAttendanceDto.builder()
                    .studentId(studentId)
                    .studentCode(enrollment.getStudent().getStudentCode())
                    .fullName(enrollment.getStudent().getUser().getFullName())
                    .status(AttendanceStatus.valueOf(status))
                    .build();
        }).collect(Collectors.toList());

        for (AttendanceStatus status : attendanceMap.values()) {
            if (status == AttendanceStatus.PRESENT) {
                countPresent++;
            } else if (status == AttendanceStatus.ABSENT || status == AttendanceStatus.EXCUSED) {
                countAbsent++;
            }
        }

        int total = enrollments.size();
        int percent = (total == 0) ? 0 : (int) Math.round((double) countPresent / total * 100);

        return AttendanceListResponse.builder()
                .totalStudents(total)
                .totalPresent(countPresent)
                .totalAbsent(countAbsent)
                .presentPercentage(percent)
                .students(studentDtos)
                .build();
    }


    @Transactional(rollbackFor = Exception.class)
    public void saveAttendance(AttendanceSaveRequest request) {

        var scheduleRef = scheduleRepository.getReferenceById(request.getScheduleId());
        var teacherRef = userRepository.getReferenceById(request.getTeacherId());

        for (AttendanceSaveRequest.StudentStatus studentReq : request.getRecords()) {
            if (studentReq.getStatus() == null) continue;

            AttendanceRecord record = attendanceRepository
                    .findByScheduleIdAndStudentIdAndAttendanceDate(
                            request.getScheduleId(),
                            studentReq.getStudentId(),
                            request.getAttendanceDate()
                    )
                    .orElse(new AttendanceRecord());

            if (record.getId() == null) {
                record.setSchedule(scheduleRef);
                record.setStudent(studentRepository.getReferenceById(studentReq.getStudentId()));
                record.setAttendanceDate(request.getAttendanceDate());
            }

            record.setStatus(studentReq.getStatus());
            record.setCheckedBy(teacherRef);

            attendanceRepository.save(record);
        }
    }
}