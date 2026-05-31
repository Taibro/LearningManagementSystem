USE quan_ly_lop_hoc;
SET FOREIGN_KEY_CHECKS = 0;
SET @latest_semester = (SELECT id FROM semesters ORDER BY start_date DESC LIMIT 1);

-- ==========================================
-- 1. NẠP DỮ LIỆU LƯƠNG CHO THẦY TRẦN LẬP TRÌNH (GV001, ID=1)
-- ==========================================
DELETE FROM teacher_salary_detail WHERE sheet_id IN (
    SELECT id FROM teacher_salary_sheet WHERE teacher_id = 1 AND period_month = 5 AND period_year = 2026
);
DELETE FROM teacher_salary_sheet WHERE teacher_id = 1 AND period_month = 5 AND period_year = 2026;

INSERT INTO teacher_salary_sheet (
    teacher_id, salary_config_id, semester_id, period_month, period_year, degree_snapshot, coefficient_snapshot, base_salary_snapshot, planned_sessions, actual_sessions, base_amount, session_amount, bonus_amount, deduction_amount, net_amount, status, payment_date
) VALUES (
    1, 1, @latest_semester, 5, 2026, 'Thạc sĩ', 2.34, 4500000.00, 15, 15, 4500000.00, 1000000.00, 300000.00, 150000.00, 5650000.00, 'PAID', '2026-05-15'
);

SET @sheet_gv1 = LAST_INSERT_ID();

INSERT INTO teacher_salary_detail (
    sheet_id, teacher_id, class_id, session_date, session_count, teacher_role, rate_snapshot, amount, note
) VALUES (
    @sheet_gv1, 1, 1, '2026-05-10', 1, 'MAIN', 100000.00, 100000.00, 'Chi tiết dạy mẫu của thầy Trình'
);

-- ==========================================
-- 2. NẠP DỮ LIỆU LỚP HỌC VÀ LỊCH HỌC CHO GV001
-- ==========================================
DELETE FROM attendance_records WHERE schedule_id IN (9001, 9002);
DELETE FROM enrollments WHERE class_id IN (901, 902);
DELETE FROM schedules WHERE id IN (9001, 9002);
DELETE FROM class_teacher WHERE class_id IN (901, 902);
DELETE FROM classes WHERE id IN (901, 902);

INSERT INTO classes (id, code, course_id, semester_id, max_students, status, created_at, teacher_id)
VALUES 
(901, 'CTDL-101', 1, @latest_semester, 40, 'IN_PROGRESS', NOW(), 1),
(902, 'CSDL-102', 2, @latest_semester, 40, 'IN_PROGRESS', NOW(), 1);

INSERT INTO class_teacher (class_id, teacher_id, role)
VALUES 
(901, 1, 'MAIN'),
(902, 1, 'MAIN');

INSERT INTO schedules (id, class_id, room_id, day_of_week, start_period, end_period, start_time, end_time, start_date, end_date, type, created_at)
VALUES 
(9001, 901, 1, 4, 1, 3, '07:00:00', '09:25:00', '2026-03-01', '2026-06-30', 'REGULAR', NOW()),
(9002, 902, 2, 6, 4, 6, '09:35:00', '12:00:00', '2026-03-01', '2026-06-30', 'REGULAR', NOW());

-- ==========================================
-- 3. NẠP DỮ LIỆU SINH VIÊN VÀ ĐIỂM DANH CHO CÁC LỚP
-- ==========================================
INSERT IGNORE INTO enrollments (id, student_id, class_id, status, enrollment_date, grade_attendance, grade_midterm, grade_final, grade_total)
VALUES 
(90001, 1, 901, 'ENROLLED', NOW(), 10.0, 8.5, 9.0, 9.0),
(90002, 2, 901, 'ENROLLED', NOW(), 9.0, 7.5, 8.0, 8.0),
(90003, 3, 901, 'ENROLLED', NOW(), 8.0, 6.0, 7.0, 7.0),
(90004, 1, 902, 'ENROLLED', NOW(), 8.5, 7.0, 8.5, 8.0),
(90005, 4, 902, 'ENROLLED', NOW(), 10.0, 9.5, 9.0, 9.2);

INSERT IGNORE INTO attendance_records (id, schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(90001, 9001, 1, '2026-04-01', 'PRESENT', 1, '2026-04-01 07:15:00'),
(90002, 9001, 2, '2026-04-01', 'PRESENT', 1, '2026-04-01 07:15:00'),
(90003, 9001, 3, '2026-04-01', 'ABSENT', 1, '2026-04-01 07:15:00'),
(90004, 9002, 1, '2026-04-03', 'PRESENT', 1, '2026-04-03 09:40:00'),
(90005, 9002, 4, '2026-04-03', 'EXCUSED', 1, '2026-04-03 09:40:00');

-- ==========================================
-- 4. NẠP DỮ LIỆU TÀI LIỆU VÀ GIẢNG VIÊN DẠY THAY
-- ==========================================
DELETE FROM class_materials WHERE class_id IN (901, 902);
INSERT INTO class_materials (id, class_id, uploaded_by, title, file_name, file_url, file_size, doc_type) VALUES
(9001, 901, 1, 'Slide bài giảng số 1', 'slide1.pdf', 'https://res.cloudinary.com/demo/image/upload/sample.pdf', 1048576, 'SLIDE'),
(9002, 901, 1, 'Bài tập tuần 1', 'bt1.docx', 'https://res.cloudinary.com/demo/image/upload/sample.pdf', 512000, 'EXERCISE'),
(9003, 902, 1, 'Đề thi trắc nghiệm mẫu', 'dethi.pdf', 'https://res.cloudinary.com/demo/image/upload/sample.pdf', 2048000, 'OTHER');

DELETE FROM teachers WHERE id = 999;
DELETE FROM users WHERE id = 999;

INSERT INTO users (id, school_id, code, citizen_id_number, full_name, email, password_hash, phone, is_active)
VALUES (999, 1, 'GV999', '079200000999', 'Trần Văn Phụ', 'phu@huit.edu.vn', '$2b$12$PqzeP1iGSLvHGoZu5Ut4W.HjFLITYipGGfTEkgXqUjhjXzqBLipNa', '0912345678', 1);

INSERT IGNORE INTO user_roles (user_id, role_id) VALUES (999, 2);
INSERT IGNORE INTO user_roles (user_id, role_id) VALUES (1, 4); 

INSERT INTO teachers (id, user_id, teacher_code, department_id, degree, specialization, join_date)
VALUES (999, 999, 'GV999', (SELECT department_id FROM (SELECT department_id FROM teachers WHERE id = 1) AS temp), 'Thạc sĩ', 'Công nghệ phần mềm', '2020-01-01');

-- ==========================================
-- 5. NẠP DỮ LIỆU ĐÁNH GIÁ (KHẢO SÁT) VÀ LỊCH SỬ DẠY THAY/BÁO NGHỈ
-- ==========================================
DELETE FROM teacher_evaluations WHERE teacher_id = 1;
INSERT INTO teacher_evaluations (teacher_id, semester_id, class_id, score_knowledge, score_method, score_interaction, score_materials, score_punctuality, comment, student_id) VALUES
(1, @latest_semester, 901, 5.0, 4.5, 5.0, 4.0, 5.0, 'Thầy dạy rất dễ hiểu, nhiệt tình!', 1),
(1, @latest_semester, 901, 4.0, 4.0, 4.5, 4.5, 5.0, 'Tài liệu đầy đủ, môn học thú vị.', 2),
(1, @latest_semester, 902, 5.0, 5.0, 5.0, 5.0, 5.0, 'Tuyệt vời!', 4);

DELETE FROM schedule_exceptions WHERE schedule_id IN (9001, 9002);
INSERT INTO schedule_exceptions (schedule_id, exception_date, reason, exception_type, approval_status, replacement_date, replacement_start_period, replacement_end_period, makeup_status, substitute_teacher_id, substitute_content, substitute_status) VALUES
(9001, '2026-04-10', 'Bận công tác trường', 'CANCELLED', 'APPROVED', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL),
(9001, '2026-04-17', 'Đi khám bệnh', 'CANCELLED', 'APPROVED', '2026-04-20', 7, 9, 'APPROVED', NULL, NULL, NULL),
(9002, '2026-04-15', 'Trùng lịch họp khoa', 'SUBSTITUTED', 'PENDING', NULL, NULL, NULL, NULL, 999, 'Ôn tập giữa kỳ', 'PENDING');

SET FOREIGN_KEY_CHECKS = 1;
