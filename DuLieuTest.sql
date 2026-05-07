INSERT INTO School (code, name, short_name, type, email, phone, website, established_date, created_by, updated_by) VALUES
  ('HCMUT',     'Trường Đại học Bách Khoa TP.HCM', 'BK-HCM',   'university',      'info@hcmut.edu.vn',   '028-3865-4086', 'https://hcmut.edu.vn',  '1957-10-27', NULL, NULL),
  ('IELTS_PRO', 'Trung tâm Tiếng Anh IELTS Pro',   'IELTS Pro', 'language_center', 'hi@ieltspro.vn',      '028-9999-0001', 'https://ieltspro.vn',   '2015-06-01', NULL, NULL);

INSERT INTO School (code, name)
VALUES ('HUIT', 'Đại học Công Thương TP.HCM'); -- 3

INSERT INTO School_branches (school_id, code, name, address, city, district, phone, is_main, created_by, updated_by) VALUES
  (1, 'CS1', 'Cơ sở 1 - Lý Thường Kiệt', '268 Lý Thường Kiệt, P.14', 'TP.HCM',    'Quận 10',  '028-3864-7256', 1, NULL, NULL),
  (1, 'CS2', 'Cơ sở 2 - Dĩ An',          'Khu phố 6, Dĩ An',         'Bình Dương','Dĩ An',    '0274-372-5540', 0, NULL, NULL),
  (2, 'Q1',  'Chi nhánh Quận 1',          '123 Nguyễn Huệ, P.BN',     'TP.HCM',    'Quận 1',   '028-9999-0002', 1, NULL, NULL),
  (2, 'TD',  'Chi nhánh Thủ Đức',         '456 Võ Văn Ngân, P.BT',    'TP.HCM',    'Thủ Đức',  '028-9999-0003', 0, NULL, NULL);

INSERT INTO Academic_year (school_id, name, start_date, end_date, created_by, updated_by) VALUES
  (1, '2024-2025', '2024-09-01', '2025-08-31', NULL, NULL),
  (2, '2024-2025', '2024-09-01', '2025-08-31', NULL, NULL);

INSERT INTO Semester (academic_year_id, name, start_date, end_date, created_by, updated_by) VALUES
  (1, 'Học kỳ 1',    '2024-09-09', '2025-01-10', NULL, NULL),
  (1, 'Học kỳ 2',    '2025-02-10', '2025-06-13', NULL, NULL),
  (2, 'Khóa tháng 9','2024-09-02', '2024-11-30', NULL, NULL);

INSERT INTO Department (school_id, code, name, created_by, updated_by) VALUES
  (1, 'CNTT',  'Công nghệ Thông tin', NULL, NULL),
  (1, 'KTKT',  'Kỹ thuật Kinh tế', NULL, NULL),
  (2, 'IELTS', 'Bộ môn IELTS', NULL, NULL);

INSERT INTO Department (school_id, code, name)
VALUES (3, 'CNTT', 'Khoa Công nghệ Thông tin');

INSERT INTO Room (branch_id, building, room_number, capacity, type, equipment, created_by, updated_by) VALUES
  (1, 'A', '101', 50, 'classroom',    '["projector","ac","whiteboard"]', NULL, NULL),
  (1, 'B', '102', 30, 'lab',          '["computers","projector","ac"]', NULL, NULL),
  (1, 'B', '301', 80, 'lecture_hall', '["projector","ac","mic_system"]', NULL, NULL),
  (2, 'C', '201', 40, 'classroom',    '["projector","ac","smartboard"]', NULL, NULL),
  (3, 'A', '001', 20, 'seminar',      '["tv_screen","ac"]', NULL, NULL);

INSERT INTO Users (full_name, email, password_hash, phone, gender, created_by, updated_by) VALUES
  ('Nguyễn Văn An', 'an.nguyen@hcmut.edu.vn',        '$2b$10$h1','0901234561','male',   NULL, NULL),
  ('Trần Thị Bích', 'bich.tran@hcmut.edu.vn',        '$2b$10$h2','0901234562','female', NULL, NULL),
  ('Lê Minh Cường', 'cuong.le@ieltspro.vn',          '$2b$10$h3','0901234563','male',   NULL, NULL),
  ('Phạm Văn Đức',  'duc.pham@student.hcmut.edu.vn', '$2b$10$h4','0912345671','male',   NULL, NULL),
  ('Hoàng Thị Lan', 'lan.hoang@student.hcmut.edu.vn','$2b$10$h5','0912345672','female', NULL, NULL),
  ('Vũ Quốc Hùng',  'hung.vu@ieltspro.vn',           '$2b$10$h6','0912345673','male',   NULL, NULL);



INSERT INTO Users (full_name, email, password_hash, is_active)
VALUES ('Nguyễn Thành Tài', '2001230773@gmail.huit.edu.vn', '$2a$10$MnzRADiXkTUsRFoc84OvsOG56b1ZUEebl5GWDzcQ/hU06Ka.G8eJ2', 1); -- 7

INSERT INTO User_School (user_id, school_id, role_id, joined_date) VALUES
  (1, 1, 2, '2018-08-01'),
  (2, 1, 2, '2020-01-15'),
  (3, 2, 2, '2019-06-01'),
  (4, 1, 3, '2021-09-01'),
  (5, 1, 3, '2021-09-01'),
  (6, 2, 3, '2024-03-01');

INSERT INTO User_School (user_id, school_id, role_id, joined_date) VALUES
  (7, 3, 3, '2018-08-01');

INSERT INTO Teacher (user_id, teacher_code, department_id, degree, specialization, join_date, created_by, updated_by) VALUES
  (1, 'GV001', 1, 'Tiến sĩ', 'Trí tuệ nhân tạo',  '2018-08-01', NULL, NULL),
  (2, 'GV002', 1, 'Thạc sĩ', 'Kỹ thuật phần mềm', '2020-01-15', NULL, NULL),
  (3, 'GV003', 3, 'Thạc sĩ', 'Ngôn ngữ học',      '2019-06-01', NULL, NULL);

INSERT INTO Student (user_id, student_code, department_id, enrollment_year, major, class_name, created_by, updated_by) VALUES
  (4, '21IT001',  1, 2021, 'Kỹ thuật phần mềm', 'CNTT21A', NULL, NULL),
  (5, '21IT002',  1, 2021, 'Kỹ thuật phần mềm', 'CNTT21A', NULL, NULL),
  (6, 'IE240301', 3, 2024, 'IELTS General',     NULL,      NULL, NULL);

INSERT INTO Student (user_id, student_code, department_id, enrollment_year)
VALUES (7, '2001230773', 4, 2023);
select * from Student;
INSERT INTO Course (code, name, credits, total_sessions, department_id, created_by, updated_by) VALUES
  ('INT101', 'Nhập môn Lập trình',            3, 30, 1, NULL, NULL),
  ('INT201', 'Cấu trúc dữ liệu & Giải thuật', 3, 30, 1, NULL, NULL),
  ('IEL101', 'IELTS Foundation',              0, 40, 3, NULL, NULL);


INSERT INTO Class (code, course_id, semester_id, max_students, status, created_by, updated_by) VALUES
  ('INT101-01-HK1-2425', 1, 1,  40, 'in_progress', NULL, NULL),
  ('INT201-01-HK1-2425', 2, 1,  35, 'in_progress', NULL, NULL),
  ('IEL101-Q1-T9-2024',  3, 3,  20, 'open',        NULL, NULL);


INSERT INTO Class_Teacher (class_id, teacher_id, role) VALUES
  (1, 1, 'main'),      -- Thầy An dạy chính lớp INT101
  (2, 2, 'main'),      -- Cô Bích dạy chính lớp INT201
  (3, 3, 'main'),      -- Thầy Cường dạy chính lớp IELTS
  (3, 1, 'assistant'); -- Thầy An làm trợ giảng cho lớp IELTS (Ví dụ cho N-N)

INSERT INTO Schedule (class_id, room_id, day_of_week, start_time, end_time, start_date, end_date, type, created_by, updated_by) VALUES
  (1, 1, 2, '07:30:00', '09:30:00', '2024-09-09', '2024-12-20', 'regular', NULL, NULL),
  (1, 1, 4, '13:30:00', '15:30:00', '2024-09-09', '2024-12-20', 'regular', NULL, NULL),
  (2, 2, 3, '09:45:00', '11:45:00', '2024-09-10', '2024-12-21', 'regular', NULL, NULL),
  (3, 5, 6, '08:00:00', '10:00:00', '2024-09-07', '2024-11-30', 'regular', NULL, NULL);


INSERT INTO Enrollment (student_id, class_id, status, created_by, updated_by) VALUES
  (1, 1, 'enrolled', NULL, NULL),
  (2, 1, 'enrolled', NULL, NULL),
  (1, 2, 'enrolled', NULL, NULL),
  (2, 2, 'enrolled', NULL, NULL),
  (3, 3, 'enrolled', NULL, NULL);

INSERT INTO Attendance_record (schedule_id, student_id, attendance_date, status, checked_by, updated_by, checked_at) VALUES
    (1, 1, '2024-09-09', 'PRESENT', 1, NULL, NOW()),
    (1, 2, '2024-09-09', 'PRESENT', 1, NULL, NOW()),
    (1, 1, '2024-09-11', 'LATE',    1, NULL, NOW()),
    (1, 2, '2024-09-11', 'ABSENT',  1, NULL, NOW());

INSERT INTO Schedule_exception (schedule_id, exception_date, reason, exception_type, replacement_date, created_by, updated_by) VALUES
  (1, '2024-09-02', 'Nghỉ Quốc khánh 2/9', 'rescheduled', '2024-09-07', NULL, NULL);


-- Du lieu test
INSERT INTO Users (full_name, email, password_hash, is_active, phone)
VALUES ('Trần Lập Trình', 'tranlaptrinh@huit.edu.vn', '$2a$10$MnzRADiXkTUsRFoc84OvsOG56b1ZUEebl5GWDzcQ/hU06Ka.G8eJ2', 1, '0999888777');


INSERT INTO Teacher (user_id, teacher_code, department_id, degree, specialization, join_date)
VALUES (
    (SELECT id FROM Users WHERE email = 'tranlaptrinh@huit.edu.vn'),
    'GV_PRO_2026',
    1,
    'Tiến sĩ',
    'Công nghệ phần mềm',
    '2020-01-01'
);

INSERT INTO Course (code, name, credits, total_sessions, department_id) VALUES
('SPRING26', 'Xây dựng API với Spring Boot 3', 3, 45, 1),
('REACT26', 'Lập trình Frontend với ReactJS', 3, 45, 1);


INSERT INTO Class (code, course_id, semester_id, max_students, status) VALUES
('SPRING-01-2026', (SELECT id FROM Course WHERE code = 'SPRING26'), 1, 40, 'IN_PROGRESS'),
('REACT-02-2026',  (SELECT id FROM Course WHERE code = 'REACT26'),  1, 35, 'IN_PROGRESS');


INSERT INTO Class_Teacher (class_id, teacher_id, role) VALUES
(
    (SELECT id FROM Class WHERE code = 'SPRING-01-2026'),
    (SELECT id FROM Teacher WHERE teacher_code = 'GV_PRO_2026'),
    'main'
),
(
    (SELECT id FROM Class WHERE code = 'REACT-02-2026'),
    (SELECT id FROM Teacher WHERE teacher_code = 'GV_PRO_2026'),
    'main'
);


INSERT INTO Schedule (class_id, room_id, day_of_week, start_time, end_time, start_period, end_period, start_date, end_date, type) VALUES
(
    (SELECT id FROM Class WHERE code = 'SPRING-01-2026'),
    1, -- room_id = 1 (Phòng 101)
    2, -- Thứ 2
    '07:30:00', '09:30:00',
    1, 3, -- start_period, end_period (Sáng)
    '2026-01-01', '2026-12-31',
    'REGULAR'
),
(
    (SELECT id FROM Class WHERE code = 'SPRING-01-2026'),
    1,
    4, -- Thứ 4
    '13:00:00', '15:30:00',
    7, 9, -- start_period, end_period (Chiều)
    '2026-01-01', '2026-12-31',
    'REGULAR'
);


INSERT INTO Schedule (class_id, room_id, day_of_week, start_time, end_time, start_period, end_period, start_date, end_date, type) VALUES
(
    (SELECT id FROM Class WHERE code = 'REACT-02-2026'),
    2, -- room_id = 2 (Phòng Lab 102)
    7, -- Thứ 7
    '08:00:00', '16:00:00',
    1, 10, -- start_period, end_period (Cả ngày)
    '2026-01-01', '2026-12-31',
    'LAB'
);

-- ========================================================================
-- SCRIPT TEST: TẠO DỮ LIỆU ĐIỂM DANH (TÍNH TIẾN ĐỘ LỚP HỌC)
-- ========================================================================

-- 1. Tìm ID của Sinh viên Tài (2001230773) và Thầy Lập Trình
SET @student_id = (SELECT id FROM Student WHERE student_code = '2001230773' LIMIT 1);
SET @teacher_user_id = (SELECT id FROM Users WHERE email = 'tranlaptrinh@huit.edu.vn' LIMIT 1);

-- 2. Tìm ID của các Lịch học (Schedule) vừa được tạo
-- Lớp Spring Boot (Mỗi ca 3 tiết)
SET @sched_spring_t2 = (SELECT s.id
                        FROM Schedule s
                                 JOIN Class c ON s.class_id = c.id
                        WHERE c.code = 'SPRING-01-2026'
                          AND s.day_of_week = 2
                        LIMIT 1);
SET @sched_spring_t4 = (SELECT s.id
                        FROM Schedule s
                                 JOIN Class c ON s.class_id = c.id
                        WHERE c.code = 'SPRING-01-2026'
                          AND s.day_of_week = 4
                        LIMIT 1);

-- Lớp ReactJS (Mỗi ca 10 tiết)
SET @sched_react_t7 = (SELECT s.id
                       FROM Schedule s
                                JOIN Class c ON s.class_id = c.id
                       WHERE c.code = 'REACT-02-2026'
                         AND s.day_of_week = 7
                       LIMIT 1);


-- ========================================================================
-- 3. INSERT DỮ LIỆU ĐIỂM DANH ĐỂ TÍNH TIẾN ĐỘ
-- ========================================================================

INSERT INTO Attendance_record (schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(@sched_spring_t2, @student_id, '2026-01-05', 'PRESENT', @teacher_user_id, NOW()),
(@sched_spring_t2, @student_id, '2026-01-12', 'PRESENT', @teacher_user_id, NOW());

-- Điểm danh 2 buổi Thứ 4 (Có 1 buổi sinh viên vắng, nhưng vẫn tính là Giảng viên đã dạy)
INSERT INTO Attendance_record (schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(@sched_spring_t4, @student_id, '2026-01-07', 'PRESENT', @teacher_user_id, NOW()),
(@sched_spring_t4, @student_id, '2026-01-14', 'ABSENT', @teacher_user_id, NOW());


-- B. Lớp ReactJS (Mục tiêu test: Dạy 3 buổi = 30 tiết)
-- Điểm danh 3 buổi Thứ 7
INSERT INTO Attendance_record (schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(@sched_react_t7, @student_id, '2026-01-03', 'PRESENT', @teacher_user_id, NOW()),
(@sched_react_t7, @student_id, '2026-01-10', 'PRESENT', @teacher_user_id, NOW()),
(@sched_react_t7, @student_id, '2026-01-17', 'PRESENT', @teacher_user_id, NOW());