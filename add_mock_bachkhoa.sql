USE quan_ly_lop_hoc;
SET FOREIGN_KEY_CHECKS = 0;

-- Thêm Khoa mới cho Bách Khoa
INSERT IGNORE INTO departments (id, school_id, code, name) VALUES
(21, 2, 'KTDT', 'Khoa Kỹ thuật Điện tử'),
(22, 2, 'KTXD', 'Khoa Kỹ thuật Xây dựng'),
(23, 2, 'QLCN', 'Khoa Quản lý Công nghiệp');

-- Thêm Môn học cho Bách Khoa
INSERT IGNORE INTO courses (id, department_id, code, name, credits, total_sessions) VALUES
(21, 6, 'CO1027', 'Kỹ thuật lập trình', 3, 45),
(22, 6, 'CO2013', 'Cơ sở dữ liệu', 4, 60),
(23, 21, 'EE1001', 'Mạch điện tử', 3, 45),
(24, 22, 'CE2001', 'Cơ học kết cấu', 3, 45);

-- Thêm Users cho Bách Khoa (Giảng viên)
INSERT IGNORE INTO users (id, school_id, code, citizen_id_number, email, full_name, gender, date_of_birth, is_active, password_hash) VALUES
(30, 2, 'GV201', '079099000201', 'gv201@hcmut.edu.vn', 'Phạm Trí Tuệ', 'MALE', '1980-01-01', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(31, 2, 'GV202', '079099000202', 'gv202@hcmut.edu.vn', 'Nguyễn Thuật Toán', 'MALE', '1985-02-02', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(32, 2, 'GV203', '079099000203', 'gv203@hcmut.edu.vn', 'Trần Mạch Điện', 'FEMALE', '1990-03-03', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG');

-- Thêm Giáo viên
INSERT IGNORE INTO teachers (id, user_id, department_id, teacher_code, degree, specialization) VALUES
(21, 30, 6, 'GV201', 'Tiến sĩ', 'Khoa học máy tính'),
(22, 31, 6, 'GV202', 'Thạc sĩ', 'Kỹ thuật phần mềm'),
(23, 32, 21, 'GV203', 'Tiến sĩ', 'Kỹ thuật điện tử');

-- Thêm Users cho Bách Khoa (Sinh viên)
INSERT IGNORE INTO users (id, school_id, code, citizen_id_number, email, full_name, gender, date_of_birth, is_active, password_hash) VALUES
(40, 2, '2210001', '079099000401', '2210001@hcmut.edu.vn', 'Lê Bách Khoa', 'MALE', '2004-01-01', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(41, 2, '2210002', '079099000402', '2210002@hcmut.edu.vn', 'Nguyễn Cơ Khí', 'MALE', '2004-02-02', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(42, 2, '2210003', '079099000403', '2210003@hcmut.edu.vn', 'Trần Xây Dựng', 'FEMALE', '2004-03-03', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(43, 2, '2210004', '079099000404', '2210004@hcmut.edu.vn', 'Phạm Điện Tử', 'MALE', '2004-04-04', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(44, 2, '2210005', '079099000405', '2210005@hcmut.edu.vn', 'Đinh Chưa Phân Bổ 1', 'MALE', '2004-05-05', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG'),
(45, 2, '2210006', '079099000406', '2210006@hcmut.edu.vn', 'Hoàng Chưa Phân Bổ 2', 'FEMALE', '2004-06-06', 1, '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG');

-- Thêm Sinh viên
INSERT IGNORE INTO students (id, user_id, department_id, student_code, enrollment_year, major, class_name) VALUES
(23, 40, 6, '2210001', 2022, 'Khoa học máy tính', 'MT22KH01'),
(24, 41, 6, '2210002', 2022, 'Khoa học máy tính', 'MT22KH01'),
(25, 42, 22, '2210003', 2022, 'Kỹ thuật xây dựng', 'XD22KT01'),
(26, 43, 21, '2210004', 2022, 'Kỹ thuật điện tử', 'DT22KT01');

-- Thêm Lớp học
INSERT IGNORE INTO classes (id, code, course_id, semester_id, max_students, status, teacher_id) VALUES
(21, 'CO1027-L01', 21, 1, 40, 'OPEN', 21),
(22, 'CO2013-L01', 22, 1, 40, 'OPEN', 22);

-- Thêm phân công giáo viên cho lớp
INSERT IGNORE INTO class_teacher (class_id, teacher_id, role) VALUES
(21, 21, 'main'),
(22, 22, 'main');

-- Thêm Sinh viên vào Lớp
INSERT IGNORE INTO enrollments (class_id, student_id, enrollment_date, status) VALUES
(21, 23, '2025-08-01', 'ENROLLED'),
(21, 24, '2025-08-01', 'ENROLLED'),
(22, 23, '2025-08-01', 'ENROLLED');

-- Thêm Ca học (Schedule) cho lớp 21
INSERT IGNORE INTO schedules (id, class_id, room_id, day_of_week, start_time, end_time, start_date, end_date, start_period, end_period, type) VALUES
(21, 21, 1, 2, '07:00:00', '09:30:00', '2025-08-15', '2025-12-31', 1, 3, 'REGULAR');

-- Thêm Điểm danh vắng cho Sinh viên (Hôm nay) để hiển thị lên Dashboard
INSERT IGNORE INTO attendance_records (id, schedule_id, student_id, attendance_date, status) VALUES
(31, 21, 24, CURDATE(), 'ABSENT');

SET FOREIGN_KEY_CHECKS = 1;
