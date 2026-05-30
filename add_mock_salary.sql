USE quan_ly_lop_hoc;
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 1. NẠP DỮ LIỆU LƯƠNG CHO THẦY LÊ BÁCH KHOA (GV002, ID=2)
-- ==========================================
DELETE FROM teacher_salary_detail WHERE sheet_id IN (
    SELECT id FROM teacher_salary_sheet WHERE teacher_id = 2 AND period_month = 5 AND period_year = 2026
);
DELETE FROM teacher_salary_sheet WHERE teacher_id = 2 AND period_month = 5 AND period_year = 2026;

INSERT INTO teacher_salary_sheet (
    teacher_id, salary_config_id, semester_id, period_month, period_year, degree_snapshot, coefficient_snapshot, base_salary_snapshot, planned_sessions, actual_sessions, base_amount, session_amount, bonus_amount, deduction_amount, net_amount, status, payment_date
) VALUES (
    2, 1, 1, 5, 2026, 'Thạc sĩ', 2.34, 4500000.00, 15, 15, 4500000.00, 1000000.00, 300000.00, 150000.00, 5650000.00, 'PAID', '2026-05-15'
);

SET @sheet_gv2 = LAST_INSERT_ID();

INSERT INTO teacher_salary_detail (
    sheet_id, teacher_id, class_id, session_date, session_count, teacher_role, rate_snapshot, amount, note
) VALUES (
    @sheet_gv2, 2, 1, '2026-05-10', 1, 'MAIN_TEACHER', 100000.00, 100000.00, 'Chi tiết dạy mẫu của thầy Khoa'
);


-- ==========================================
-- 2. NẠP DỮ LIỆU LỚP HỌC VÀ LỊCH HỌC CHO GV002
-- ==========================================
-- Xóa dữ liệu cũ (Xoá gọn gàng, không bị thừa)
DELETE FROM attendance_records WHERE schedule_id IN (9001, 9002);
DELETE FROM enrollments WHERE class_id IN (901, 902);
DELETE FROM schedules WHERE id IN (9001, 9002);
DELETE FROM class_teacher WHERE class_id IN (901, 902);
DELETE FROM classes WHERE id IN (901, 902);

-- Tạo 2 Lớp học ảo (Cho Course 1 và Course 2)
INSERT INTO classes (id, code, course_id, semester_id, max_students, status, created_at)
VALUES 
(901, 'CTDL-101', 1, 1, 40, 'IN_PROGRESS', NOW()),
(902, 'CSDL-102', 2, 1, 40, 'IN_PROGRESS', NOW());

-- Phân công thầy Lê Bách Khoa (teacher_id = 2) dạy 2 lớp này
INSERT INTO class_teacher (class_id, teacher_id, role)
VALUES 
(901, 2, 'MAIN_TEACHER'),
(902, 2, 'MAIN_TEACHER');

-- Tạo Lịch học bao trùm tháng 4/2026 (để hiện lên Lịch Tuần)
INSERT INTO schedules (id, class_id, room_id, day_of_week, start_period, end_period, start_time, end_time, start_date, end_date, type, created_at)
VALUES 
(9001, 901, 1, 4, 1, 3, '07:00:00', '09:25:00', '2026-03-01', '2026-06-30', 'REGULAR', NOW()),
(9002, 902, 2, 6, 4, 6, '09:35:00', '12:00:00', '2026-03-01', '2026-06-30', 'REGULAR', NOW());


-- ==========================================
-- 3. NẠP DỮ LIỆU SINH VIÊN VÀ ĐIỂM DANH CHO CÁC LỚP
-- ==========================================
-- Đăng ký sinh viên vào lớp 901 (CTDL-101)
INSERT INTO enrollments (id, student_id, class_id, status, enrollment_date, grade_attendance, grade_midterm, grade_final, grade_total)
VALUES 
(90001, 1, 901, 'ENROLLED', NOW(), 10.0, 8.5, 9.0, 9.0),
(90002, 2, 901, 'ENROLLED', NOW(), 9.0, 7.5, 8.0, 8.0),
(90003, 3, 901, 'ENROLLED', NOW(), 8.0, 6.0, 7.0, 7.0);

-- Đăng ký sinh viên vào lớp 902 (CSDL-102)
INSERT INTO enrollments (id, student_id, class_id, status, enrollment_date, grade_attendance, grade_midterm, grade_final, grade_total)
VALUES 
(90004, 1, 902, 'ENROLLED', NOW(), 8.5, 7.0, 8.5, 8.0),
(90005, 4, 902, 'ENROLLED', NOW(), 10.0, 9.5, 9.0, 9.2);

-- Tạo điểm danh mẫu cho lớp 901 (ngày 01/04)
INSERT INTO attendance_records (id, schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(90001, 9001, 1, '2026-04-01', 'PRESENT', 2, '2026-04-01 07:15:00'),
(90002, 9001, 2, '2026-04-01', 'PRESENT', 2, '2026-04-01 07:15:00'),
(90003, 9001, 3, '2026-04-01', 'ABSENT', 2, '2026-04-01 07:15:00');

-- Tạo điểm danh mẫu cho lớp 902 (ngày 03/04)
INSERT INTO attendance_records (id, schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(90004, 9002, 1, '2026-04-03', 'PRESENT', 2, '2026-04-03 09:40:00'),
(90005, 9002, 4, '2026-04-03', 'EXCUSED', 2, '2026-04-03 09:40:00');

SET FOREIGN_KEY_CHECKS = 1;
SELECT 'Đã tạo xong dữ liệu Lương, Lớp, Lịch dạy và Bảng điểm sạch sẽ!' AS ThongBao;
