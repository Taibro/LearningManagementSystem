SET SESSION sql_mode = '';
-- ============================================================
-- PHẦN 1: LỆNH XÓA SẠCH DỮ LIỆU CŨ VÀ RESET AUTO_INCREMENT
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE Teacher_salary_detail;
TRUNCATE TABLE Teacher_salary_sheet;
TRUNCATE TABLE Salary_config;
TRUNCATE TABLE Salary_grade;
TRUNCATE TABLE student_semester_summaries;
TRUNCATE TABLE tuition_payments;
TRUNCATE TABLE tuition_invoices;
TRUNCATE TABLE notifications;
TRUNCATE TABLE attendance_records;
TRUNCATE TABLE enrollments;
TRUNCATE TABLE schedule_exceptions;
TRUNCATE TABLE schedules;
TRUNCATE TABLE Class_Teacher;
TRUNCATE TABLE classes;
TRUNCATE TABLE rooms;
TRUNCATE TABLE courses;
TRUNCATE TABLE students;
TRUNCATE TABLE teachers;
TRUNCATE TABLE Users;
TRUNCATE TABLE departments;
TRUNCATE TABLE semesters;
TRUNCATE TABLE academic_years;
TRUNCATE TABLE school_branches;
TRUNCATE TABLE schools;
TRUNCATE TABLE role;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- PHẦN 2: LỆNH INSERT DỮ LIỆU MẪU (MOCK DATA)
-- ============================================================

INSERT INTO role (name, description) VALUES
  ('SAAS_ADMIN',   'Quản trị viên hệ thống'),
  ('LECTURER', 'Giảng viên'),
  ('STUDENT', 'Sinh viên / Học sinh'),
  ('SCHOOL_ADMIN', 'Admin nha truong');

INSERT INTO users (
    school_id,
    code,
    citizen_id_number,
    full_name,
    email,
    password_hash,
    phone,
    address,
    gender,
    is_active,
    created_at,
    updated_at
) VALUES (
    1,
    'ADM-HCMUT-01',
    '079200000001',
    'Admin Bách Khoa',
    'admin@hcmut.edu.vn',
    '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG', -- Đây là chuỗi Bcrypt hash của mật khẩu 'Admin@123'
    '0909123456',
    '268 Lý Thường Kiệt, Quận 10, TP.HCM',
    'MALE',
    true,
    NOW(),
    NOW()
);

INSERT INTO user_roles (user_id, role_id)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@hcmut.edu.vn' LIMIT 1),
    (SELECT id FROM role WHERE name = 'SCHOOL_ADMIN' LIMIT 1)
);

-- 2. BẢNG SCHOOL (12 dòng)
INSERT INTO schools (id, code, name, short_name, type, email) VALUES
(1, 'HUIT', 'Đại học Công Thương TP.HCM', 'HUIT', 'UNIVERSITY', 'contact@huit.edu.vn'),
(2, 'HCMUT', 'Đại học Bách Khoa TP.HCM', 'HCMUT', 'UNIVERSITY', 'info@hcmut.edu.vn'),
(3, 'KHTN', 'Đại học Khoa Học Tự Nhiên', 'HCMUS', 'UNIVERSITY', 'info@hcmus.edu.vn'),
(4, 'UEH', 'Đại học Kinh Tế TP.HCM', 'UEH', 'UNIVERSITY', 'info@ueh.edu.vn'),
(5, 'UEL', 'Đại học Kinh Tế - Luật', 'UEL', 'UNIVERSITY', 'info@uel.edu.vn'),
(6, 'UIT', 'Đại học Công Nghệ Thông Tin', 'UIT', 'UNIVERSITY', 'info@uit.edu.vn'),
(7, 'SPKT', 'Đại học Sư Phạm Kỹ Thuật', 'HCMUTE', 'UNIVERSITY', 'info@hcmute.edu.vn'),
(8, 'SGU', 'Đại học Sài Gòn', 'SGU', 'UNIVERSITY', 'info@sgu.edu.vn'),
(9, 'TDTU', 'Đại học Tôn Đức Thắng', 'TDTU', 'UNIVERSITY', 'info@tdtu.edu.vn'),
(10, 'VLU', 'Đại học Văn Lang', 'VLU', 'UNIVERSITY', 'info@vlu.edu.vn'),
(11, 'HSU', 'Đại học Hoa Sen', 'HSU', 'UNIVERSITY', 'info@hsu.edu.vn'),
(12, 'IELTS_HCM', 'Trung tâm IELTS HCM', 'IELTS', 'LANGUAGE_CENTER', 'ielts@hcm.com');

-- 3. BẢNG SCHOOL_BRANCHES (12 dòng)
INSERT INTO school_branches (id, school_id, code, name, address, is_main) VALUES
(1, 1, 'HUIT_CS1', 'Cơ sở chính HUIT', '140 Lê Trọng Tấn, Tân Phú', 1),
(2, 2, 'HCMUT_CS1', 'Cơ sở Lý Thường Kiệt', '268 Lý Thường Kiệt, Q10', 1),
(3, 3, 'KHTN_CS1', 'Cơ sở Nguyễn Văn Cừ', '227 Nguyễn Văn Cừ, Q5', 1),
(4, 4, 'UEH_CS1', 'Cơ sở A UEH', '59C Nguyễn Đình Chiểu, Q3', 1),
(5, 5, 'UEL_CS1', 'Cơ sở chính UEL', 'Khu đô thị ĐHQG, Thủ Đức', 1),
(6, 6, 'UIT_CS1', 'Cơ sở chính UIT', 'Khu đô thị ĐHQG, Thủ Đức', 1),
(7, 7, 'SPKT_CS1', 'Cơ sở chính SPKT', '1 Võ Văn Ngân, Thủ Đức', 1),
(8, 8, 'SGU_CS1', 'Cơ sở chính SGU', '273 An Dương Vương, Q5', 1),
(9, 9, 'TDTU_CS1', 'Cơ sở chính TDTU', '19 Nguyễn Hữu Thọ, Q7', 1),
(10, 10, 'VLU_CS1', 'Cơ sở chính VLU', '69/68 Đặng Thùy Trâm, Bình Thạnh', 1),
(11, 11, 'HSU_CS1', 'Cơ sở Nguyễn Văn Tráng', '8 Nguyễn Văn Tráng, Q1', 1),
(12, 12, 'IELTS_CS1', 'Chi nhánh IELTS Q1', '100 Trần Hưng Đạo, Q1', 1);

-- 4. BẢNG ACADEMIC_YEAR (12 dòng - Tập trung cho trường 1 - HUIT)
INSERT INTO academic_years (id, school_id, name, start_date, end_date) VALUES
(1, 1, '2024-2025', '2024-08-01', '2025-07-31'),
(2, 1, '2025-2026', '2025-08-01', '2026-07-31'),
(3, 1, '2026-2027', '2026-08-01', '2027-07-31'),
(4, 2, '2025-2026', '2025-08-01', '2026-07-31'),
(5, 3, '2025-2026', '2025-08-01', '2026-07-31'),
(6, 4, '2025-2026', '2025-08-01', '2026-07-31'),
(7, 5, '2025-2026', '2025-08-01', '2026-07-31'),
(8, 6, '2025-2026', '2025-08-01', '2026-07-31'),
(9, 7, '2025-2026', '2025-08-01', '2026-07-31'),
(10, 8, '2025-2026', '2025-08-01', '2026-07-31'),
(11, 9, '2025-2026', '2025-08-01', '2026-07-31'),
(12, 10, '2025-2026', '2025-08-01', '2026-07-31');

-- 5. BẢNG SEMESTER (12 dòng)
INSERT INTO semesters (id, academic_year_id, name, start_date, end_date) VALUES
(1, 2, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(2, 2, 'Học kỳ 2', '2026-01-15', '2026-05-31'),
(3, 2, 'Học kỳ hè', '2026-06-01', '2026-07-30'),
(4, 1, 'Học kỳ 1', '2024-08-15', '2024-12-31'),
(5, 1, 'Học kỳ 2', '2025-01-15', '2025-05-31'),
(6, 4, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(7, 5, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(8, 6, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(9, 7, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(10, 8, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(11, 9, 'Học kỳ 1', '2025-08-15', '2025-12-31'),
(12, 10, 'Học kỳ 1', '2025-08-15', '2025-12-31');

-- 6. BẢNG DEPARTMENT (12 dòng)
INSERT INTO departments (id, school_id, code, name) VALUES
(1, 1, 'CNTT', 'Khoa Công Nghệ Thông Tin'),
(2, 1, 'KTDN', 'Khoa Kế toán - Tài chính'),
(3, 1, 'NN', 'Khoa Ngoại Ngữ'),
(4, 1, 'QTKD', 'Khoa Quản trị Kinh doanh'),
(5, 1, 'ĐDT', 'Khoa Điện - Điện tử'),
(6, 2, 'KHMT', 'Khoa Khoa Học Máy Tính'),
(7, 3, 'TOAN', 'Khoa Toán - Tin'),
(8, 4, 'TC', 'Khoa Tài chính'),
(9, 5, 'LTM', 'Khoa Luật Thương Mại'),
(10, 6, 'HTTT', 'Hệ thống thông tin'),
(11, 7, 'CK', 'Khoa Cơ Khí'),
(12, 12, 'IELTS_ENG', 'Bộ môn IELTS');

-- 7. BẢNG USERS (24 dòng: 12 GV, 12 SV để map cho thoải mái)
INSERT INTO users (id, school_id, code, citizen_id_number, full_name, email, password_hash, gender, address) VALUES
(99, 1, 'SAAS999', '079001000099', 'SaaS Super Admin', 'superadmin@edusaas.io', 'hash123', 'MALE', 'System'),
(1, 1, 'USR001', '079001000001', 'Nguyễn Văn Admin', 'admin@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(2, 1, 'USR002', '079001000002', 'Trần Lập Trình', 'gv1@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(3, 1, 'USR003', '079001000003', 'Lê Bách Khoa', 'gv2@hcmut.edu.vn', 'hash123', 'MALE', 'HCMC'),
(4, 1, 'USR004', '079001000004', 'Phạm Ngoại Ngữ', 'gv3@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(5, 1, 'USR005', '079001000005', 'Hoàng Kinh Tế', 'gv4@ueh.edu.vn', 'hash123', 'MALE', 'HCMC'),
(6, 1, 'USR006', '079001000006', 'Vũ Luật Sư', 'gv5@uel.edu.vn', 'hash123', 'MALE', 'HCMC'),
(7, 1, 'USR007', '079001000007', 'Đặng Máy Tính', 'gv6@uit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(8, 1, 'USR008', '079001000008', 'Bùi Cơ Khí', 'gv7@hcmute.edu.vn', 'hash123', 'MALE', 'HCMC'),
(9, 1, 'USR009', '079001000009', 'Đỗ Tài Chính', 'gv8@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(10, 1, 'USR010', '079001000010', 'Hồ Điện Tử', 'gv9@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(11, 1, 'USR011', '079001000011', 'Ngô Quản Trị', 'gv10@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(12, 1, 'USR012', '079001000012', 'Dương Kế Toán', 'gv11@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(13, 1, 'USR013', '079001000013', 'Nguyễn Thanh Tài', 'tai.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(14, 1, 'USR014', '079001000014', 'Nguyễn Minh Dũng', 'dung.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(15, 1, 'USR015', '079001000015', 'Lê Hoàng Anh', 'anh.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(16, 1, 'USR016', '079001000016', 'Phạm Thị Cúc', 'cuc.sv@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(17, 1, 'USR017', '079001000017', 'Vũ Đăng Khoa', 'khoa.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(18, 1, 'USR018', '079001000018', 'Mai Hà Thu', 'thu.sv@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(19, 1, 'USR019', '079001000019', 'Lý Hải Băng', 'bang.sv@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(20, 1, 'USR020', '079001000020', 'Trịnh Hữu Thọ', 'tho.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(21, 1, 'USR021', '079001000021', 'Vương Ngọc Yến', 'yen.sv@huit.edu.vn', 'hash123', 'FEMALE', 'HCMC'),
(22, 1, 'USR022', '079001000022', 'Châu Phát Đạt', 'dat.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(23, 1, 'USR023', '079001000023', 'Tào Tháo', 'thao.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC'),
(24, 1, 'USR024', '079001000024', 'Lưu Bị', 'bi.sv@huit.edu.vn', 'hash123', 'MALE', 'HCMC')
;

Update users
set password_hash = '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG';
SELECT * FROM users;

INSERT INTO users (
    school_id,
    code,
    citizen_id_number,
    full_name,
    email,
    password_hash,
    phone,
    address,
    gender,
    is_active,
    created_at,
    updated_at
) VALUES (
    1,
    'ADM-HCMUT-01',
    '079200000001',
    'Admin Bách Khoa',
    'admin@hcmut.edu.vn',
    '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG', -- Đây là chuỗi Bcrypt hash của mật khẩu '123456'
    '0909123456',
    '268 Lý Thường Kiệt, Quận 10, TP.HCM',
    'MALE',
    true,
    NOW(),
    NOW()
);

INSERT INTO user_roles (user_id, role_id)
VALUES (
    (SELECT id FROM users WHERE email = 'admin@hcmut.edu.vn' LIMIT 1),
    (SELECT id FROM role WHERE name = 'SCHOOL_ADMIN' LIMIT 1)
);

-- 8. BẢNG USER_SCHOOL (24 dòng tương ứng)
INSERT INTO user_roles (user_id, role_id) VALUES
(99, 1),
(1, 1), (2, 2), (3, 2), (4, 2),
(5, 2), (6, 2), (7, 2), (8, 2),
(9, 2), (10, 2), (11, 2), (12, 2),
(13, 3), (14, 3), (15, 3), (16, 3),
(17, 3), (18, 3), (19, 3), (20, 3),
(21, 3), (22, 3), (23, 3), (24, 3);

-- 9. BẢNG TEACHER (11 dòng)
INSERT INTO teachers (id, user_id, teacher_code, department_id, degree) VALUES
(1, 2, 'GV001', 1, 'Tiến sĩ'),
(2, 3, 'GV002', 6, 'Thạc sĩ'),
(3, 4, 'GV003', 3, 'Cử nhân'),
(4, 5, 'GV004', 8, 'Tiến sĩ'),
(5, 6, 'GV005', 9, 'Thạc sĩ'),
(6, 7, 'GV006', 10, 'PGS.TS'),
(7, 8, 'GV007', 11, 'Thạc sĩ'),
(8, 9, 'GV008', 2, 'Cử nhân'),
(9, 10, 'GV009', 5, 'Tiến sĩ'),
(10, 11, 'GV010', 4, 'Thạc sĩ'),
(11, 12, 'GV011', 2, 'Thạc sĩ');

-- 10. BẢNG STUDENT (12 dòng)
INSERT INTO students (id, user_id, student_code, department_id, enrollment_year, class_name) VALUES
(1, 13, '2001216301', 1, 2023, '12DHTH01'),
(2, 14, '2001216302', 1, 2023, '12DHTH01'),
(3, 15, '2001216303', 1, 2023, '12DHTH02'),
(4, 16, '2001216304', 2, 2023, '12DHKT01'),
(5, 17, '2001216305', 2, 2023, '12DHKT01'),
(6, 18, '2001216306', 3, 2024, '13DHNN01'),
(7, 19, '2001216307', 3, 2024, '13DHNN01'),
(8, 20, '2001216308', 4, 2022, '11DHQT01'),
(9, 21, '2001216309', 4, 2022, '11DHQT02'),
(10, 22, '2001216310', 5, 2025, '14DHDT01'),
(11, 23, '2001216311', 5, 2025, '14DHDT01'),
(12, 24, '2001216312', 1, 2023, '12DHTH01');


-- 11. BẢNG COURSE (12 dòng)
INSERT INTO courses (id, code, name, credits, department_id) VALUES
(1, 'INT101', 'Lập trình Java', 3, 1),
(2, 'INT102', 'Lập trình Web (Spring Boot)', 3, 1),
(3, 'INT103', 'Cơ sở dữ liệu', 3, 1),
(4, 'ENG101', 'Tiếng Anh giao tiếp 1', 2, 3),
(5, 'ENG102', 'Tiếng Anh chuyên ngành', 2, 3),
(6, 'ACC101', 'Nguyên lý kế toán', 3, 2),
(7, 'ACC102', 'Kế toán tài chính', 3, 2),
(8, 'BUS101', 'Quản trị học', 3, 4),
(9, 'BUS102', 'Marketing căn bản', 3, 4),
(10, 'ELE101', 'Mạch điện tử', 3, 5),
(11, 'ELE102', 'Vi xử lý', 3, 5),
(12, 'INT104', 'Trí tuệ nhân tạo (AI)', 4, 1);

-- 12. BẢNG ROOM (12 dòng)
INSERT INTO rooms (id, branch_id, building, room_number, capacity, type) VALUES
(1, 1, 'C', 'C101', 50, 'CLASSROOM'),
(2, 1, 'C', 'C102', 50, 'CLASSROOM'),
(3, 1, 'F', 'F201', 40, 'LAB'),
(4, 1, 'F', 'F202', 40, 'LAB'),
(5, 1, 'E', 'E101', 100, 'LECTURE_HALL'),
(6, 2, 'A', 'A101', 60, 'CLASSROOM'),
(7, 3, 'B', 'B201', 50, 'CLASSROOM'),
(8, 4, 'C', 'C301', 70, 'CLASSROOM'),
(9, 5, 'D', 'D401', 50, 'CLASSROOM'),
(10, 6, 'E', 'E501', 40, 'LAB'),
(11, 7, 'F', 'F601', 100, 'LECTURE_HALL'),
(12, 1, 'A', 'A205', 40, 'SEMINAR');

-- 13. BẢNG CLASS (12 dòng)
INSERT INTO classes (id, code, course_id, semester_id, max_students, status) VALUES
(1, 'INT101-HK2-01', 1, 2, 40, 'OPEN'),
(2, 'INT102-HK2-01', 2, 2, 40, 'OPEN'),
(3, 'INT103-HK2-01', 3, 2, 40, 'OPEN'),
(4, 'ENG101-HK2-01', 4, 2, 40, 'IN_PROGRESS'),
(5, 'ENG102-HK2-01', 5, 2, 40, 'OPEN'),
(6, 'ACC101-HK2-01', 6, 2, 50, 'OPEN'),
(7, 'ACC102-HK2-01', 7, 2, 50, 'COMPLETED'),
(8, 'BUS101-HK2-01', 8, 2, 60, 'OPEN'),
(9, 'BUS102-HK2-01', 9, 2, 60, 'CLOSED'),
(10, 'ELE101-HK2-01', 10, 2, 40, 'OPEN'),
(11, 'ELE102-HK2-01', 11, 2, 40, 'OPEN'),
(12, 'INT104-HK2-01', 12, 2, 40, 'OPEN');

-- 14. BẢNG CLASS_TEACHER (12 dòng)
INSERT INTO Class_Teacher (class_id, teacher_id, role) VALUES
(1, 1, 'main'),
(2, 1, 'main'),
(3, 2, 'main'),
(4, 3, 'main'),
(5, 3, 'main'),
(6, 8, 'main'),
(7, 11, 'main'),
(8, 10, 'main'),
(9, 10, 'main'),
(10, 9, 'main'),
(11, 9, 'assistant'),
(12, 1, 'main');

-- 15. BẢNG SCHEDULE (12 dòng)
INSERT INTO schedules (id, class_id, room_id, day_of_week, start_time, end_time, start_date, end_date, start_period, end_period, type) VALUES
(1, 1, 3, 2, '07:00:00', '09:30:00', '2026-01-15', '2026-05-15', 1, 3, 'REGULAR'),
(2, 2, 4, 3, '09:40:00', '12:10:00', '2026-01-15', '2026-05-15', 4, 6, 'REGULAR'),
(3, 3, 1, 4, '13:00:00', '15:30:00', '2026-01-15', '2026-05-15', 7, 9, 'REGULAR'),
(4, 4, 2, 5, '07:00:00', '08:40:00', '2026-01-15', '2026-05-15', 1, 2, 'REGULAR'),
(5, 5, 2, 6, '15:40:00', '17:20:00', '2026-01-15', '2026-05-15', 10, 11, 'REGULAR'),
(6, 6, 5, 2, '13:00:00', '15:30:00', '2026-01-15', '2026-05-15', 7, 9, 'REGULAR'),
(7, 7, 1, 3, '07:00:00', '09:30:00', '2026-01-15', '2026-05-15', 1, 3, 'REGULAR'),
(8, 8, 5, 4, '09:40:00', '12:10:00', '2026-01-15', '2026-05-15', 4, 6, 'REGULAR'),
(9, 9, 1, 5, '13:00:00', '15:30:00', '2026-01-15', '2026-05-15', 7, 9, 'REGULAR'),
(10, 10, 4, 6, '07:00:00', '09:30:00', '2026-01-15', '2026-05-15', 1, 3, 'REGULAR'),
(11, 11, 3, 7, '09:40:00', '12:10:00', '2026-01-15', '2026-05-15', 4, 6, 'REGULAR'),
(12, 12, 4, 2, '15:40:00', '18:10:00', '2026-01-15', '2026-05-15', 10, 12, 'REGULAR');

-- 16. BẢNG SCHEDULE_EXCEPTION (12 dòng)
INSERT INTO schedule_exceptions (id, schedule_id, exception_date, reason, exception_type) VALUES
(1, 1, '2026-03-02', 'Giảng viên bệnh', 'cancelled'),
(2, 2, '2026-03-03', 'Họp khoa', 'cancelled'),
(3, 3, '2026-03-04', 'Cúp điện', 'cancelled'),
(4, 4, '2026-03-05', 'Lễ', 'cancelled'),
(5, 5, '2026-03-06', 'Thi giữa kỳ', 'rescheduled'),
(6, 6, '2026-03-09', 'Nghỉ bù', 'cancelled'),
(7, 7, '2026-03-10', 'Bảo trì phòng máy', 'room_change'),
(8, 8, '2026-03-11', 'Lịch công tác', 'cancelled'),
(9, 9, '2026-03-12', 'Bận đột xuất', 'cancelled'),
(10, 10, '2026-03-13', 'Thi Olimpic', 'cancelled'),
(11, 11, '2026-03-14', 'Nghỉ hè', 'cancelled'),
(12, 12, '2026-03-16', 'Họp Bộ môn', 'cancelled');

-- 17. BẢNG ENROLLMENT (12 dòng)
INSERT INTO enrollments (id, student_id, class_id, status, grade_total) VALUES
(1, 1, 1, 'ENROLLED', NULL),
(2, 2, 1, 'ENROLLED', NULL),
(3, 3, 1, 'ENROLLED', NULL),
(4, 1, 2, 'ENROLLED', NULL),
(5, 2, 2, 'ENROLLED', NULL),
(6, 4, 6, 'ENROLLED', NULL),
(7, 5, 6, 'ENROLLED', NULL),
(8, 6, 4, 'ENROLLED', NULL),
(9, 7, 4, 'ENROLLED', NULL),
(10, 8, 8, 'ENROLLED', NULL),
(11, 9, 8, 'ENROLLED', NULL),
(12, 12, 1, 'ENROLLED', NULL);

-- 18. BẢNG ATTENDANCE_RECORD (12 dòng)
INSERT INTO attendance_records (id, schedule_id, student_id, attendance_date, status, checked_by, checked_at) VALUES
(1, 1, 1, '2026-02-16', 'PRESENT', 2, '2026-02-16 08:00:00'),
(2, 1, 2, '2026-02-16', 'LATE', 2, '2026-02-16 08:15:00'),
(3, 1, 3, '2026-02-16', 'ABSENT', 2, '2026-02-16 08:00:00'),
(4, 2, 1, '2026-02-17', 'PRESENT', 2, '2026-02-17 08:00:00'),
(5, 2, 2, '2026-02-17', 'PRESENT', 2, '2026-02-17 08:00:00'),
(6, 6, 4, '2026-02-16', 'PRESENT', 9, '2026-02-16 13:00:00'),
(7, 6, 5, '2026-02-16', 'EXCUSED', 9, '2026-02-16 13:00:00'),
(8, 4, 6, '2026-02-19', 'PRESENT', 4, '2026-02-19 08:00:00'),
(9, 4, 7, '2026-02-19', 'PRESENT', 4, '2026-02-19 08:00:00'),
(10, 8, 8, '2026-02-18', 'PRESENT', 11, '2026-02-18 09:40:00'),
(11, 8, 9, '2026-02-18', 'LATE', 11, '2026-02-18 09:55:00'),
(12, 1, 12, '2026-02-16', 'PRESENT', 2, '2026-02-16 08:00:00');

-- 19. BẢNG NOTIFICATION (12 dòng)
INSERT INTO notifications (id, user_id, title, body, type, is_read) VALUES
(1, 13, 'Báo nghỉ học', 'Lớp INT101 nghỉ ngày 02/03', 'SCHEDULE_CHANGE', 0),
(2, 14, 'Báo nghỉ học', 'Lớp INT101 nghỉ ngày 02/03', 'SCHEDULE_CHANGE', 0),
(3, 15, 'Báo nghỉ học', 'Lớp INT101 nghỉ ngày 02/03', 'SCHEDULE_CHANGE', 0),
(4, 13, 'Nhắc nộp học phí', 'Vui lòng nộp học phí HK2', 'REMINDER', 0),
(5, 14, 'Nhắc nộp học phí', 'Vui lòng nộp học phí HK2', 'REMINDER', 0),
(6, 15, 'Nhắc nộp học phí', 'Vui lòng nộp học phí HK2', 'REMINDER', 0),
(7, 2, 'Có lịch dạy bù', 'Vui lòng sắp xếp lịch dạy bù lớp INT101', 'SYSTEM', 0),
(8, 16, 'Có điểm thi', 'Đã có điểm môn Nguyên lý kế toán', 'GRADE', 0),
(9, 17, 'Có điểm thi', 'Đã có điểm môn Nguyên lý kế toán', 'GRADE', 0),
(10, 18, 'Thông báo', 'Đăng ký học phần HK hè', 'ENROLLMENT', 0),
(11, 19, 'Thông báo', 'Đăng ký học phần HK hè', 'ENROLLMENT', 0),
(12, 13, 'Cập nhật điểm', 'Điểm QT đã được update', 'GRADE', 0);

-- 20. BẢNG TUITION_INVOICE (12 dòng)
INSERT INTO tuition_invoices (id, student_id, semester_id, total_amount, paid_amount, due_date, status) VALUES
(1, 1, 2, 15000000.00, 15000000.00, '2026-03-30', 'PAID'),
(2, 2, 2, 15000000.00, 5000000.00, '2026-03-30', 'PARTIAL'),
(3, 3, 2, 15000000.00, 0.00, '2026-03-30', 'UNPAID'),
(4, 4, 2, 14000000.00, 14000000.00, '2026-03-30', 'PAID'),
(5, 5, 2, 14000000.00, 0.00, '2026-03-30', 'UNPAID'),
(6, 6, 2, 12000000.00, 12000000.00, '2026-03-30', 'PAID'),
(7, 7, 2, 12000000.00, 12000000.00, '2026-03-30', 'PAID'),
(8, 8, 2, 13000000.00, 0.00, '2026-03-30', 'UNPAID'),
(9, 9, 2, 13000000.00, 0.00, '2026-03-30', 'UNPAID'),
(10, 10, 2, 16000000.00, 8000000.00, '2026-03-30', 'PARTIAL'),
(11, 11, 2, 16000000.00, 16000000.00, '2026-03-30', 'PAID'),
(12, 12, 2, 15000000.00, 15000000.00, '2026-03-30', 'PAID');

-- 21. BẢNG TUITION_PAYMENT (12 dòng)
INSERT INTO tuition_payments (id, invoice_id, amount, payment_method, transaction_code, status, payment_date) VALUES
(1, 1, 15000000.00, 'BANK_TRANSFER', 'VN123456', 'SUCCESS', '2026-03-30 12:00:00'),
(2, 2, 5000000.00, 'MOMO', 'MM98765', 'SUCCESS', '2026-03-30 12:00:00'),
(3, 4, 14000000.00, 'VNPAY', 'VNP1122', 'SUCCESS', '2026-03-30 12:00:00'),
(4, 6, 12000000.00, 'CASH', 'CASH001', 'SUCCESS', '2026-03-30 12:00:00'),
(5, 7, 12000000.00, 'BANK_TRANSFER', 'VN223344', 'SUCCESS', '2026-03-30 12:00:00'),
(6, 10, 8000000.00, 'VISA', 'VS9988', 'SUCCESS', '2026-03-30 12:00:00'),
(7, 11, 16000000.00, 'MOMO', 'MM7766', 'SUCCESS', '2026-03-30 12:00:00'),
(8, 12, 15000000.00, 'BANK_TRANSFER', 'VN445566', 'SUCCESS', '2026-03-30 12:00:00'),
(9, 1, 0.00, 'BANK_TRANSFER', 'FAIL01', 'FAILED', '2026-03-30 12:00:00'),
(10, 2, 0.00, 'MOMO', 'FAIL02', 'FAILED', '2026-03-30 12:00:00'),
(11, 4, 0.00, 'VNPAY', 'FAIL03', 'FAILED', '2026-03-30 12:00:00'),
(12, 6, 0.00, 'VISA', 'FAIL04', 'FAILED', '2026-03-30 12:00:00');

-- 22. BẢNG STUDENT_SEMESTER_SUMMARY (12 dòng)
INSERT INTO student_semester_summaries (id, student_id, semester_id, gpa, credits_earned, conduct_score, conduct_grade) VALUES
(1, 1, 1, 3.50, 15, 90, 'Xuất sắc'),
(2, 2, 1, 3.20, 15, 85, 'Tốt'),
(3, 3, 1, 2.80, 15, 75, 'Khá'),
(4, 4, 1, 3.80, 18, 95, 'Xuất sắc'),
(5, 5, 1, 2.50, 12, 65, 'Trung bình'),
(6, 6, 1, 3.10, 16, 80, 'Tốt'),
(7, 7, 1, 3.90, 20, 98, 'Xuất sắc'),
(8, 8, 1, 2.90, 15, 78, 'Khá'),
(9, 9, 1, 3.00, 15, 82, 'Tốt'),
(10, 10, 1, 3.60, 18, 88, 'Tốt'),
(11, 11, 1, 2.20, 10, 60, 'Trung bình'),
(12, 12, 1, 3.51, 15, 92, 'Xuất sắc');

-- 23. BẢNG SALARY_GRADE (12 dòng)
INSERT INTO Salary_grade (id, school_id, degree, coefficient, rate_per_session, effective_from) VALUES
(1, 1, 'Tiến sĩ', 1.60, 250000.00, '2026-01-01'),
(2, 1, 'Thạc sĩ', 1.30, 180000.00, '2026-01-01'),
(3, 1, 'Cử nhân', 1.00, 120000.00, '2026-01-01'),
(4, 1, 'PGS.TS', 1.90, 350000.00, '2026-01-01'),
(5, 1, 'GS.TS', 2.20, 500000.00, '2026-01-01'),
(6, 2, 'Tiến sĩ', 1.60, 300000.00, '2026-01-01'),
(7, 3, 'Thạc sĩ', 1.30, 200000.00, '2026-01-01'),
(8, 4, 'Tiến sĩ', 1.60, 280000.00, '2026-01-01'),
(9, 5, 'Thạc sĩ', 1.30, 190000.00, '2026-01-01'),
(10, 6, 'PGS.TS', 1.90, 400000.00, '2026-01-01'),
(11, 7, 'Thạc sĩ', 1.30, 170000.00, '2026-01-01'),
(12, 8, 'Cử nhân', 1.00, 110000.00, '2026-01-01');

-- 24. BẢNG SALARY_CONFIG (12 dòng)
INSERT INTO Salary_config (id, school_id, salary_grade_id, name, base_salary, effective_from) VALUES
(1, 1, 1, 'Lương TS 2026', 2340000.00, '2026-01-01'),
(2, 1, 2, 'Lương ThS 2026', 2340000.00, '2026-01-01'),
(3, 1, 3, 'Lương CN 2026', 2340000.00, '2026-01-01'),
(4, 1, 4, 'Lương PGS 2026', 2340000.00, '2026-01-01'),
(5, 1, 5, 'Lương GS 2026', 2340000.00, '2026-01-01'),
(6, 2, 6, 'Lương TS HCMUT', 2500000.00, '2026-01-01'),
(7, 3, 7, 'Lương ThS KHTN', 2340000.00, '2026-01-01'),
(8, 4, 8, 'Lương TS UEH', 2600000.00, '2026-01-01'),
(9, 5, 9, 'Lương ThS UEL', 2340000.00, '2026-01-01'),
(10, 6, 10, 'Lương PGS UIT', 2800000.00, '2026-01-01'),
(11, 7, 11, 'Lương ThS SPKT', 2340000.00, '2026-01-01'),
(12, 8, 12, 'Lương CN SGU', 2340000.00, '2026-01-01');

-- 25. BẢNG TEACHER_SALARY_SHEET (12 dòng)
-- 25. BẢNG TEACHER_SALARY_SHEET (12 dòng)
INSERT INTO Teacher_salary_sheet (id, teacher_id, salary_config_id, semester_id, period_month, period_year, degree_snapshot, coefficient_snapshot, base_salary_snapshot, rate_snapshot, planned_sessions, actual_sessions, base_amount, session_amount, bonus_amount, deduction_amount, net_amount, status) VALUES
(1, 1, 1, 2, 3, 2026, 'Tiến sĩ', 1.60, 2340000.00, 250000.00, 20, 20, 3744000.00, 5000000.00, 1000000.00, 500000.00, 9244000.00, 'CONFIRMED'),
(2, 2, 2, 2, 3, 2026, 'Thạc sĩ', 1.30, 2340000.00, 180000.00, 16, 15, 3042000.00, 2700000.00, 500000.00, 300000.00, 5942000.00, 'CONFIRMED'),
(3, 3, 3, 2, 3, 2026, 'Cử nhân', 1.00, 2340000.00, 120000.00, 10, 10, 2340000.00, 1200000.00, 0.00, 200000.00, 3340000.00, 'DRAFT'),
(4, 4, 8, 2, 3, 2026, 'Tiến sĩ', 1.60, 2600000.00, 280000.00, 25, 25, 4160000.00, 7000000.00, 2000000.00, 800000.00, 12360000.00, 'PAID'),
(5, 5, 9, 2, 3, 2026, 'Thạc sĩ', 1.30, 2340000.00, 190000.00, 12, 12, 3042000.00, 2280000.00, 0.00, 250000.00, 5072000.00, 'DRAFT'),
(6, 6, 10, 2, 3, 2026, 'PGS.TS', 1.90, 2800000.00, 400000.00, 30, 30, 5320000.00, 12000000.00, 5000000.00, 1500000.00, 20820000.00, 'PAID'),
(7, 7, 11, 2, 3, 2026, 'Thạc sĩ', 1.30, 2340000.00, 170000.00, 20, 18, 3042000.00, 3060000.00, 500000.00, 350000.00, 6252000.00, 'CONFIRMED'),
(8, 8, 3, 2, 3, 2026, 'Cử nhân', 1.00, 2340000.00, 120000.00, 15, 14, 2340000.00, 1680000.00, 0.00, 200000.00, 3820000.00, 'DRAFT'),
(9, 9, 1, 2, 3, 2026, 'Tiến sĩ', 1.60, 2340000.00, 250000.00, 22, 22, 3744000.00, 5500000.00, 1200000.00, 600000.00, 9844000.00, 'CONFIRMED'),
(10, 10, 2, 2, 3, 2026, 'Thạc sĩ', 1.30, 2340000.00, 180000.00, 16, 16, 3042000.00, 2880000.00, 800000.00, 400000.00, 6322000.00, 'PAID'),
(11, 11, 2, 2, 3, 2026, 'Thạc sĩ', 1.30, 2340000.00, 180000.00, 20, 20, 3042000.00, 3600000.00, 1000000.00, 500000.00, 7142000.00, 'CONFIRMED'),
(12, 1, 1, 2, 4, 2026, 'Tiến sĩ', 1.60, 2340000.00, 250000.00, 24, 24, 3744000.00, 6000000.00, 1000000.00, 600000.00, 10144000.00, 'DRAFT');

-- 26. BẢNG TEACHER_SALARY_DETAIL (12 dòng)
INSERT INTO Teacher_salary_detail (id, sheet_id, teacher_id, class_id, schedule_id, session_date, session_count, teacher_role, rate_snapshot, amount) VALUES
(1, 1, 1, 1, 1, '2026-03-02', 3, 'MAIN', 250000.00, 750000.00),
(2, 1, 1, 1, 1, '2026-03-09', 3, 'MAIN', 250000.00, 750000.00),
(3, 1, 1, 2, 2, '2026-03-03', 3, 'MAIN', 250000.00, 750000.00),
(4, 2, 2, 3, 3, '2026-03-04', 3, 'MAIN', 180000.00, 540000.00),
(5, 2, 2, 3, 3, '2026-03-11', 3, 'MAIN', 180000.00, 540000.00),
(6, 3, 3, 4, 4, '2026-03-05', 2, 'MAIN', 120000.00, 240000.00),
(7, 3, 3, 5, 5, '2026-03-06', 2, 'MAIN', 120000.00, 240000.00),
(8, 8, 8, 6, 6, '2026-03-10', 3, 'MAIN', 120000.00, 360000.00),
(9, 11, 11, 7, 7, '2026-03-11', 3, 'MAIN', 180000.00, 540000.00),
(10, 10, 10, 8, 8, '2026-03-12', 3, 'MAIN', 180000.00, 540000.00),
(11, 9, 9, 10, 10, '2026-03-14', 3, 'MAIN', 250000.00, 750000.00),
(12, 12, 1, 12, 12, '2026-04-01', 3, 'MAIN', 250000.00, 750000.00);

INSERT INTO teacher_evaluations (teacher_id, semester_id, class_id, score_knowledge, score_method, score_interaction, score_materials, score_punctuality, comment) VALUES
(1, 2, 1, 5.0, 4.5, 5.0, 4.0, 5.0, 'Thầy giảng rất rõ ràng và dễ hiểu. Có nhiều ví dụ thực tế.'),
(1, 2, 1, 4.5, 4.5, 4.0, 4.5, 5.0, 'Môn học thú vị, thầy nhiệt tình.'),
(1, 2, 1, 4.0, 4.0, 4.5, 4.0, 4.5, 'Tốc độ giảng đôi lúc hơi nhanh nhưng slide rất chi tiết.'),
(1, 2, 2, 5.0, 5.0, 5.0, 5.0, 5.0, 'Không có gì để chê, 10 điểm không có nhưng!'),
(1, 2, 2, 4.5, 4.0, 4.5, 4.5, 4.5, 'Thầy vui tính, hay tương tác hỏi bài sinh viên.');

INSERT INTO saas_plans (id, code, name, monthly_price, yearly_price, max_students, max_storage_gb, features, is_active, created_at, updated_at) VALUES
(1, 'STARTER', 'Starter', 1500000.00, 15000000.00, 500, 10,
 '[{"name":"Quản lý lớp học & Lịch học","included":true},{"name":"Điểm danh & Đăng ký","included":true},{"name":"Thông báo trong app","included":true},{"name":"1 cơ sở","included":true},{"name":"Học phí & Lương GV","included":false},{"name":"Báo cáo nâng cao","included":false},{"name":"API & SSO","included":false}]',
 true, NOW(), NOW()),

(2, 'PRO', 'Pro', 5800000.00, 58000000.00, 5000, 100,
 '[{"name":"Tất cả tính năng Starter","included":true},{"name":"5 cơ sở","included":true},{"name":"Học phí & Lương GV","included":true},{"name":"Báo cáo nâng cao","included":true},{"name":"QR Code điểm danh","included":true},{"name":"API & SSO / Azure AD","included":false}]',
 true, NOW(), NOW()),

(3, 'ENTERPRISE', 'Enterprise', 12500000.00, 150000000.00, -1, -1,
 '[{"name":"Tất cả tính năng Pro","included":true},{"name":"Không giới hạn cơ sở","included":true},{"name":"Storage theo yêu cầu","included":true},{"name":"API tích hợp ERP","included":true},{"name":"SSO / Azure AD / Google","included":true},{"name":"Backup riêng · SLA 99.9%","included":true},{"name":"Audit Log đầy đủ","included":true}]',
 true, NOW(), NOW());

-- ============================================================
-- 3. BẢNG SAAS_SUBSCRIPTIONS (8 subscriptions cho 8 trường)
-- ============================================================

INSERT INTO saas_subscriptions (id, school_id, plan_id, start_date, end_date, billing_cycle, status, created_at, updated_at) VALUES
(1, 1, 3, '2025-01-01', '2025-12-31', 'YEARLY', 'ACTIVE', NOW(), NOW()),
(2, 2, 3, '2025-01-01', '2026-09-01', 'YEARLY', 'ACTIVE', NOW(), NOW()),
(3, 3, 2, '2025-03-01', '2025-06-18', 'MONTHLY', 'ACTIVE', NOW(), NOW()),
(4, 4, 2, '2025-04-01', '2025-07-14', 'MONTHLY', 'ACTIVE', NOW(), NOW()),
(5, 5, 1, '2025-01-01', '2025-06-28', 'YEARLY', 'ACTIVE', NOW(), NOW()),
(6, 6, 1, '2025-01-01', '2025-04-10', 'MONTHLY', 'CANCELLED', NOW(), NOW()),
(7, 7, 3, '2025-01-01', '2025-12-01', 'YEARLY', 'ACTIVE', NOW(), NOW()),
(8, 8, 2, '2025-02-01', '2025-08-15', 'MONTHLY', 'ACTIVE', NOW(), NOW());

-- Cập nhật is_active cho các trường
UPDATE schools SET is_active = true WHERE id IN (1,2,3,4,5,7,8,9,10,11);
UPDATE schools SET is_active = false WHERE id = 6;

-- ============================================================
-- 4. BẢNG SAAS_INVOICES (7 hoá đơn)
-- ============================================================

INSERT INTO saas_invoices (id, school_id, subscription_id, amount, payment_status, payment_method, paid_at, created_at) VALUES
(1, 2, 2, 150000000.00, 'PAID', 'BANK_TRANSFER', '2025-01-15 10:00:00', '2025-01-15 08:00:00'),
(2, 1, 1, 12500000.00, 'PENDING', 'MOMO', NULL, '2025-05-01 08:00:00'),
(3, 3, 3, 5800000.00, 'PAID', 'VNPAY', '2025-05-02 14:30:00', '2025-05-01 08:00:00'),
(4, 4, 4, 5800000.00, 'PENDING', 'MOMO', NULL, '2025-04-15 08:00:00'),
(5, 5, 5, 15000000.00, 'PAID', 'BANK_TRANSFER', '2025-05-03 09:15:00', '2025-05-02 08:00:00'),
(6, 6, 6, 1500000.00, 'FAILED', 'CASH', NULL, '2025-04-10 08:00:00'),
(7, 7, 7, 120000000.00, 'PAID', 'BANK_TRANSFER', '2025-05-04 11:20:00', '2025-05-03 08:00:00');

-- ============================================================
-- 5. BẢNG SYSTEM_ERROR_LOGS (6 log entries)
-- ============================================================

INSERT INTO system_error_logs (id, school_id, endpoint, error_message, stack_trace, user_agent, is_resolved, created_at) VALUES
(1, 2, 'POST /api/v1/enrollments', 'Duplicate entry for student_id+class_id', 'com.mysql.cj.jdbc.exceptions.MysqlDataTruncation...', 'Mozilla/5.0', false, '2025-05-10 14:32:18'),
(2, 1, 'GET /api/v1/schedules/weekly', 'NullPointerException at ScheduleService.java:142', 'java.lang.NullPointerException\n\tat ScheduleService.getWeeklySchedule(ScheduleService.java:142)', 'Mozilla/5.0', false, '2025-05-10 11:08:44'),
(3, 7, 'POST /api/v1/salary/generate', 'salary_grade_id not found for degree=PGS.TS', 'org.springframework.dao.DataIntegrityViolationException...', 'Mozilla/5.0', false, '2025-05-10 09:21:03'),
(4, 3, 'PUT /api/v1/classes/471/status', 'Foreign key constraint fails on teacher_id', 'com.mysql.cj.jdbc.exceptions.MySQLIntegrityConstraintViolationException...', 'Mozilla/5.0', true, '2025-05-09 17:55:12'),
(5, 2, 'GET /api/v1/reports/attendance', 'Query timeout after 30s', 'org.hibernate.QueryTimeoutException...', 'Mozilla/5.0', true, '2025-05-09 14:01:09'),
(6, 4, 'POST /api/v1/auth/login', 'Too many login attempts from 118.70.x.x', 'org.springframework.security.authentication.LockedException...', 'Mozilla/5.0', true, '2025-05-08 22:14:37');


INSERT INTO audit_logs (id, school_id, user_email, action, table_name, record_id, ip_address, created_at) VALUES
(1, 2, 'admin.hcmut@edu.vn', 'UPDATE', 'classes', 471, '203.113.x.x', '2025-05-10 15:44:22'),
(2, 1, 'gv.nguyen@huit.edu.vn', 'INSERT', 'attendance_records', 98234, '14.225.x.x', '2025-05-10 14:30:11'),
(3, 5, 'admin@uel.edu.vn', 'DELETE', 'schedule_exceptions', 312, '27.72.x.x', '2025-05-10 13:22:09'),
(4, 2, 'admin@hcmut.edu.vn', 'LOGIN', 'users', 1, '203.113.x.x', '2025-05-10 11:05:38'),
(5, 3, 'admin.fpoly@hcmus.edu.vn', 'UPDATE', 'salary_grade', 5, '117.4.x.x', '2025-05-10 09:48:14'),
(6, 4, 'gv.tran@ueh.edu.vn', 'INSERT', 'class_materials', 1041, '118.70.x.x', '2025-05-09 22:31:07');

-- ============================================================
-- KIỂM TRA DỮ LIỆU
-- ============================================================
SELECT 'saas_plans' AS tbl, COUNT(*) AS cnt FROM saas_plans
UNION ALL SELECT 'saas_subscriptions', COUNT(*) FROM saas_subscriptions
UNION ALL SELECT 'saas_invoices', COUNT(*) FROM saas_invoices
UNION ALL SELECT 'system_error_logs', COUNT(*) FROM system_error_logs
UNION ALL SELECT 'audit_logs', COUNT(*) FROM audit_logs;