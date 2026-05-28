package org.learn.learningmanagementbackend.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.QrGenerateRequest;
import org.learn.learningmanagementbackend.dto.request.QrScanRequest;
import org.learn.learningmanagementbackend.dto.response.QrGenerateResponse;
import org.learn.learningmanagementbackend.enums.AttendanceStatus;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;
import org.learn.learningmanagementbackend.model.AttendanceRecord;
import org.learn.learningmanagementbackend.model.Schedule;
import org.learn.learningmanagementbackend.repository.AttendanceRecordRepository;
import org.learn.learningmanagementbackend.repository.EnrollmentRepository;
import org.learn.learningmanagementbackend.repository.ScheduleRepository;
import org.learn.learningmanagementbackend.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.SecretKey;
import java.security.Key;
import java.time.LocalDate;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class QrAttendanceService {

    private final AttendanceRecordRepository attendanceRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final ScheduleRepository scheduleRepository;
    private final StudentRepository studentRepository;

    @Value("${qr.secret.key}")
    private String qrSecretKey;

    private Key getSigningKey() {
        return Keys.hmacShaKeyFor(qrSecretKey.getBytes());
    }

    public QrGenerateResponse generateQrToken(QrGenerateRequest request) {
        LocalDate today = LocalDate.now();

        int currentDayOfWeek = today.getDayOfWeek().getValue();

        Schedule todaySchedule = scheduleRepository.findTodayScheduleForClass(
                request.getClassId(), today, currentDayOfWeek
        ).orElseThrow(() -> new RuntimeException("Lớp học phần này không có lịch học vào ngày hôm nay!"));

        long nowMillis = System.currentTimeMillis();
        long expMillis = nowMillis + ((long) request.getValidDurationMinutes() * 60 * 1000);
        Date now = new Date(nowMillis);
        Date expiration = new Date(expMillis);

        String token = Jwts.builder()
                .subject("ATTENDANCE_QR")
                .claim("classId", request.getClassId())
                .claim("scheduleId", todaySchedule.getId()) // Backend tự điền, Frontend không cần biết
                .claim("date", today.toString())
                .issuedAt(now)
                .expiration(expiration)
                .signWith(getSigningKey())
                .compact();

        return QrGenerateResponse.builder()
                .qrToken(token)
                .expiresAtMillis(expMillis)
                .build();
    }

    @Transactional(rollbackFor = Exception.class)
    public void scanAndAttend(QrScanRequest request) {
        try {
            // Bước 1 Giải mã Token.
            Claims claims = Jwts.parser()
                    .verifyWith((SecretKey) getSigningKey())
                    .build()
                    .parseSignedClaims(request.getQrToken())
                    .getPayload();

            Integer classId = claims.get("classId", Integer.class);
            Integer scheduleId = claims.get("scheduleId", Integer.class);

            // Bước 2 Kiểm tra xem Sinh viên
            boolean isEnrolled = enrollmentRepository.existsByStudentIdAndClassesIdAndStatus(
                    request.getStudentId(), classId, EnrollmentStatus.ENROLLED
            );
            if (!isEnrolled) {
                throw new RuntimeException("Bạn không có tên trong danh sách lớp học phần này!");
            }

            // Bước 3 Lưu hoặc Cập nhật trạng thái Điểm danh
            LocalDate today = LocalDate.now();
            AttendanceRecord record = attendanceRepository
                    .findByScheduleIdAndStudentIdAndAttendanceDate(scheduleId, request.getStudentId(), today)
                    .orElse(new AttendanceRecord());

            if (record.getId() == null) {
                record.setSchedule(scheduleRepository.getReferenceById(scheduleId));
                record.setStudent(studentRepository.getReferenceById(request.getStudentId()));
                record.setAttendanceDate(today);
            }

            // Ghi nhận có mặt
            record.setStatus(AttendanceStatus.PRESENT);
            record.setNote("Điểm danh qua mã QR");

            attendanceRepository.save(record);

        } catch (io.jsonwebtoken.ExpiredJwtException e) {
            throw new RuntimeException("Mã QR đã hết hạn! Vui lòng nhờ giảng viên tạo mã mới.");
        } catch (io.jsonwebtoken.JwtException e) {
            throw new RuntimeException("Mã QR không hợp lệ hoặc bị làm giả.");
        }
    }
}