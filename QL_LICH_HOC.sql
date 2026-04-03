-- ============================================================
--  HỆ THỐNG QUẢN LÝ LỚP HỌC & LỊCH HỌC (Phiên bản có Audit Log)
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS quan_ly_lop_hoc
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE quan_ly_lop_hoc;

-- ============================================================
-- 1. TRƯỜNG HỌC / TRUNG TÂM DẠY HỌC
-- ============================================================
CREATE TABLE schools (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  code             VARCHAR(30)   NOT NULL COMMENT 'Mã trường: HCMUT, IELTS_CENTER…',
  name             VARCHAR(200)  NOT NULL,
  short_name       VARCHAR(50)   COMMENT 'Tên viết tắt',
  type             ENUM('university','college','high_school',
                        'vocational','language_center','tutoring_center','other')
                   NOT NULL DEFAULT 'university',
  accreditation    VARCHAR(100)  COMMENT 'Cơ quan kiểm định / cấp phép',
  tax_code         VARCHAR(20)   COMMENT 'Mã số thuế',
  email            VARCHAR(150),
  phone            VARCHAR(20),
  website          VARCHAR(255),
  logo_url         VARCHAR(500),
  established_date DATE,
  description      TEXT,
  is_active        TINYINT(1)    NOT NULL DEFAULT 1,

  -- Audit Columns
  created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by       INT UNSIGNED  NULL,
  updated_by       INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_school_code (code),
  INDEX idx_school_type (type),
  CONSTRAINT fk_sch_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_sch_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Trường học / Trung tâm dạy học';


-- ============================================================
-- 2. CƠ SỞ / CHI NHÁNH
-- ============================================================
CREATE TABLE school_branches (
  id         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  school_id  INT UNSIGNED  NOT NULL,
  code       VARCHAR(20)   NOT NULL COMMENT 'Mã cơ sở: CS1, CS2…',
  name       VARCHAR(150)  NOT NULL,
  address    VARCHAR(300)  NOT NULL,
  city       VARCHAR(100),
  district   VARCHAR(100),
  phone      VARCHAR(20),
  email      VARCHAR(150),
  is_main    TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '1 = Cơ sở chính',
  is_active  TINYINT(1)    NOT NULL DEFAULT 1,

  -- Audit Columns
  created_at TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by INT UNSIGNED  NULL,
  updated_by INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_branch (school_id, code),
  INDEX idx_branch_school (school_id),
  CONSTRAINT fk_branch_school FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  CONSTRAINT fk_sbr_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_sbr_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Cơ sở / Chi nhánh của trường';


-- ============================================================
-- 3. NĂM HỌC  (thuộc trường)
-- ============================================================
CREATE TABLE academic_years (
  id         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  school_id  INT UNSIGNED  NOT NULL,
  name       VARCHAR(20)   NOT NULL COMMENT 'VD: 2024-2025',
  start_date DATE          NOT NULL,
  end_date   DATE          NOT NULL,
  is_active  TINYINT(1)    NOT NULL DEFAULT 1,

  -- Audit Columns
  created_at TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by INT UNSIGNED  NULL,
  updated_by INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_year_name (school_id, name),
  INDEX idx_year_school (school_id),
  CONSTRAINT fk_year_school FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE RESTRICT,
  CONSTRAINT chk_year_dates CHECK (end_date > start_date),
  CONSTRAINT fk_ay_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_ay_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Năm học';


-- ============================================================
-- 4. HỌC KỲ
-- ============================================================
CREATE TABLE semesters (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  academic_year_id INT UNSIGNED  NOT NULL,
  name             VARCHAR(50)   NOT NULL COMMENT 'VD: Học kỳ 1, Học kỳ hè',
  start_date       DATE          NOT NULL,
  end_date         DATE          NOT NULL,
  is_active        TINYINT(1)    NOT NULL DEFAULT 1,

  -- Audit Columns
  created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by       INT UNSIGNED  NULL,
  updated_by       INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_semester (academic_year_id, name),
  CONSTRAINT fk_sem_year   FOREIGN KEY (academic_year_id) REFERENCES academic_years(id) ON DELETE RESTRICT,
  CONSTRAINT chk_sem_dates CHECK (end_date > start_date),
  CONSTRAINT fk_sem_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_sem_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Học kỳ';


-- ============================================================
-- 5. KHOA / BỘ MÔN  (thuộc trường)
-- ============================================================
CREATE TABLE departments (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  school_id   INT UNSIGNED  NOT NULL,
  code        VARCHAR(20)   NOT NULL COMMENT 'Mã khoa: CNTT, KTKT…',
  name        VARCHAR(100)  NOT NULL,
  description TEXT,

  -- Audit Columns
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by  INT UNSIGNED  NULL,
  updated_by  INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_dept_code (school_id, code),
  INDEX idx_dept_school (school_id),
  CONSTRAINT fk_dept_school FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE RESTRICT,
  CONSTRAINT fk_dep_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_dep_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Khoa / Bộ môn';


-- ============================================================
-- 6. VAI TRÒ (ROLE)
-- ============================================================
CREATE TABLE roles (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  name        VARCHAR(30)   NOT NULL COMMENT 'admin | teacher | student',
  description TEXT,

  PRIMARY KEY (id),
  UNIQUE KEY uq_role_name (name)
) ENGINE=InnoDB COMMENT='Vai trò hệ thống';

INSERT INTO roles (name, description) VALUES
  ('admin',   'Quản trị viên hệ thống'),
  ('teacher', 'Giảng viên'),
  ('student', 'Sinh viên / Học sinh');


-- ============================================================
-- 7. NGƯỜI DÙNG
-- ============================================================
CREATE TABLE users (
  id            INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  school_id     INT UNSIGNED  NOT NULL COMMENT 'Người dùng thuộc trường nào',
  code          VARCHAR(20)   NOT NULL,
  full_name     VARCHAR(100)  NOT NULL,
  email         VARCHAR(150)  NOT NULL,
  password_hash VARCHAR(255)  NOT NULL,
  phone         VARCHAR(20),
  date_of_birth DATE,
  gender        ENUM('male','female','other'),
  avatar_url    VARCHAR(500),
  is_active     TINYINT(1)    NOT NULL DEFAULT 1,
  last_login_at TIMESTAMP,

  -- Audit Columns
  created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by    INT UNSIGNED  NULL,
  updated_by    INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_user_code  (school_id, code),
  UNIQUE KEY uq_user_email (email),
  INDEX idx_user_name      (full_name),
  INDEX idx_user_school    (school_id),
  CONSTRAINT fk_user_school FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE RESTRICT,
  CONSTRAINT fk_usr_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_usr_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Tài khoản người dùng';


-- ============================================================
-- 8. NGƯỜI DÙNG ↔ VAI TRÒ
-- ============================================================
CREATE TABLE user_roles (
  user_id    INT UNSIGNED NOT NULL,
  role_id    INT UNSIGNED NOT NULL,
  granted_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  granted_by INT UNSIGNED NULL,

  PRIMARY KEY (user_id, role_id),
  CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_ur_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT,
  CONSTRAINT fk_ur_gby  FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Phân quyền người dùng';


-- ============================================================
-- 9. GIẢNG VIÊN
-- ============================================================
CREATE TABLE teachers (
  id             INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id        INT UNSIGNED  NOT NULL,
  department_id  INT UNSIGNED  NOT NULL,
  degree         VARCHAR(50)   COMMENT 'Cử nhân, Thạc sĩ, Tiến sĩ…',
  specialization VARCHAR(150),
  join_date      DATE,
  bio            TEXT,

  -- Audit Columns
  created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by     INT UNSIGNED  NULL,
  updated_by     INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_teacher_user (user_id),
  INDEX idx_teacher_dept     (department_id),
  CONSTRAINT fk_teacher_user FOREIGN KEY (user_id)       REFERENCES users(id)       ON DELETE CASCADE,
  CONSTRAINT fk_teacher_dept FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
  CONSTRAINT fk_tch_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_tch_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Hồ sơ giảng viên';


-- ============================================================
-- 10. SINH VIÊN / HỌC SINH
-- ============================================================
CREATE TABLE students (
  id              INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id         INT UNSIGNED  NOT NULL,
  student_code    VARCHAR(20)   NOT NULL COMMENT 'Mã sinh viên',
  department_id   INT UNSIGNED  NOT NULL,
  enrollment_year YEAR          NOT NULL,
  major           VARCHAR(100),
  class_name      VARCHAR(50)   COMMENT 'Lớp hành chính, VD: CNTT21A',

  -- Audit Columns
  created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by      INT UNSIGNED  NULL,
  updated_by      INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_student_user (user_id),
  UNIQUE KEY uq_student_code (student_code),
  INDEX idx_student_dept     (department_id),
  CONSTRAINT fk_student_user FOREIGN KEY (user_id)       REFERENCES users(id)       ON DELETE CASCADE,
  CONSTRAINT fk_student_dept FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
  CONSTRAINT fk_stu_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_stu_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Hồ sơ sinh viên';


-- ============================================================
-- 11. MÔN HỌC
-- ============================================================
CREATE TABLE courses (
  id             INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  code           VARCHAR(20)   NOT NULL COMMENT 'Mã môn: INT101',
  name           VARCHAR(150)  NOT NULL,
  credits        TINYINT       NOT NULL DEFAULT 3,
  total_sessions TINYINT       NOT NULL DEFAULT 30,
  description    TEXT,
  prerequisites  JSON          COMMENT 'Mảng course_id điều kiện tiên quyết',
  department_id  INT UNSIGNED  NOT NULL,
  is_active      TINYINT(1)    NOT NULL DEFAULT 1,

  -- Audit Columns
  created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by     INT UNSIGNED  NULL,
  updated_by     INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_course_code (code),
  INDEX idx_course_dept     (department_id),
  CONSTRAINT fk_course_dept FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
  CONSTRAINT chk_credits    CHECK (credits BETWEEN 1 AND 10),
  CONSTRAINT chk_sessions   CHECK (total_sessions > 0),
  CONSTRAINT fk_crs_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_crs_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Môn học / Học phần';


-- ============================================================
-- 12. PHÒNG HỌC  (thuộc cơ sở)
-- ============================================================
CREATE TABLE rooms (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  branch_id   INT UNSIGNED  NOT NULL COMMENT 'Cơ sở chứa phòng học này',
  building    VARCHAR(50)   NOT NULL,
  room_number VARCHAR(20)   NOT NULL,
  capacity    SMALLINT      NOT NULL,
  room_type   ENUM('classroom','lab','seminar','lecture_hall','online')
              NOT NULL DEFAULT 'classroom',
  equipment   JSON,
  is_active   TINYINT(1)    NOT NULL DEFAULT 1,

  -- Audit Columns
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by  INT UNSIGNED  NULL,
  updated_by  INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_room (branch_id, building, room_number),
  INDEX idx_room_branch (branch_id),
  INDEX idx_room_type   (room_type),
  CONSTRAINT fk_room_branch FOREIGN KEY (branch_id) REFERENCES school_branches(id) ON DELETE RESTRICT,
  CONSTRAINT chk_capacity   CHECK (capacity > 0),
  CONSTRAINT fk_rm_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_rm_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Phòng học';


-- ============================================================
-- 13. LỚP HỌC
-- ============================================================
CREATE TABLE classes (
  id           INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  code         VARCHAR(30)   NOT NULL,
  course_id    INT UNSIGNED  NOT NULL,
  semester_id  INT UNSIGNED  NOT NULL,
  teacher_id   INT UNSIGNED  NOT NULL,
  branch_id    INT UNSIGNED  NOT NULL COMMENT 'Lớp học tại cơ sở nào',
  max_students TINYINT       NOT NULL DEFAULT 40,
  status       ENUM('open','closed','in_progress','completed','cancelled')
               NOT NULL DEFAULT 'open',
  notes        TEXT,

  -- Audit Columns
  created_at   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by   INT UNSIGNED  NULL,
  updated_by   INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_class_code (code),
  INDEX idx_class_course   (course_id),
  INDEX idx_class_semester (semester_id),
  INDEX idx_class_teacher  (teacher_id),
  INDEX idx_class_branch   (branch_id),
  CONSTRAINT fk_class_course   FOREIGN KEY (course_id)   REFERENCES courses(id)         ON DELETE RESTRICT,
  CONSTRAINT fk_class_semester FOREIGN KEY (semester_id) REFERENCES semesters(id)       ON DELETE RESTRICT,
  CONSTRAINT fk_class_teacher  FOREIGN KEY (teacher_id)  REFERENCES teachers(id)        ON DELETE RESTRICT,
  CONSTRAINT fk_class_branch   FOREIGN KEY (branch_id)   REFERENCES school_branches(id) ON DELETE RESTRICT,
  CONSTRAINT chk_max_students  CHECK (max_students > 0),
  CONSTRAINT fk_cls_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_cls_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Lớp học (instance của môn học)';


-- ============================================================
-- 14. LỊCH HỌC
-- ============================================================
CREATE TABLE schedules (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  class_id    INT UNSIGNED  NOT NULL,
  room_id     INT UNSIGNED  NOT NULL,
  day_of_week TINYINT       NOT NULL COMMENT '1=Thứ 2 … 7=Chủ nhật',
  start_time  TIME          NOT NULL,
  end_time    TIME          NOT NULL,
  start_date  DATE          NOT NULL,
  end_date    DATE          NOT NULL,
  type        ENUM('regular','makeup','exam','lab','seminar')
              NOT NULL DEFAULT 'regular',
  notes       TEXT,

  -- Audit Columns
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by  INT UNSIGNED  NULL,
  updated_by  INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  INDEX idx_sched_class (class_id),
  INDEX idx_sched_room  (room_id),
  INDEX idx_sched_day   (day_of_week, start_time),
  CONSTRAINT fk_sched_class FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
  CONSTRAINT fk_sched_room  FOREIGN KEY (room_id)  REFERENCES rooms(id)   ON DELETE RESTRICT,
  CONSTRAINT chk_sched_time CHECK (end_time > start_time),
  CONSTRAINT chk_sched_date CHECK (end_date >= start_date),
  CONSTRAINT chk_dow        CHECK (day_of_week BETWEEN 1 AND 7),
  CONSTRAINT fk_scd_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_scd_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Lịch học (ca học lặp theo tuần)';


-- ============================================================
-- 15. NGOẠI LỆ LỊCH HỌC
-- ============================================================
CREATE TABLE schedule_exceptions (
  id                  INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  schedule_id         INT UNSIGNED  NOT NULL,
  exception_date      DATE          NOT NULL,
  reason              VARCHAR(255)  NOT NULL,
  exception_type      ENUM('cancelled','rescheduled','room_change')
                      NOT NULL DEFAULT 'cancelled',
  replacement_date    DATE,
  replacement_room_id INT UNSIGNED,

  -- Audit Columns
  created_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by          INT UNSIGNED  NULL,
  updated_by          INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_exception (schedule_id, exception_date),
  INDEX idx_exc_date (exception_date),
  CONSTRAINT fk_exc_schedule FOREIGN KEY (schedule_id)         REFERENCES schedules(id) ON DELETE CASCADE,
  CONSTRAINT fk_exc_room     FOREIGN KEY (replacement_room_id) REFERENCES rooms(id)     ON DELETE SET NULL,
  CONSTRAINT fk_se_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_se_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Ngoại lệ lịch học';


-- ============================================================
-- 16. ĐĂNG KÝ HỌC
-- ============================================================
CREATE TABLE enrollments (
  id              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
  student_id      INT UNSIGNED    NOT NULL,
  class_id        INT UNSIGNED    NOT NULL,
  enrollment_date TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Đóng vai trò created_at
  status          ENUM('pending','enrolled','dropped','completed','failed')
                  NOT NULL DEFAULT 'pending',
  grade_midterm   DECIMAL(4,2)    COMMENT 'Điểm giữa kỳ (0-10)',
  grade_final     DECIMAL(4,2)    COMMENT 'Điểm cuối kỳ (0-10)',
  grade_total     DECIMAL(4,2)    COMMENT 'Điểm tổng kết (0-10)',
  grade_letter    CHAR(2)         COMMENT 'A+, A, B+, B, C+, C, D+, D, F',
  dropped_at      TIMESTAMP,
  drop_reason     VARCHAR(255),

  -- Audit Columns (Chỉ cần Update và CreatedBy nếu Admin đăng ký hộ)
  updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by      INT UNSIGNED  NULL,
  updated_by      INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_enrollment     (student_id, class_id),
  INDEX idx_enroll_student     (student_id),
  INDEX idx_enroll_class       (class_id),
  CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  CONSTRAINT fk_enroll_class   FOREIGN KEY (class_id)   REFERENCES classes(id)  ON DELETE RESTRICT,
  CONSTRAINT chk_grade_mid     CHECK (grade_midterm IS NULL OR grade_midterm BETWEEN 0 AND 10),
  CONSTRAINT chk_grade_fin     CHECK (grade_final   IS NULL OR grade_final   BETWEEN 0 AND 10),
  CONSTRAINT chk_grade_tot     CHECK (grade_total   IS NULL OR grade_total   BETWEEN 0 AND 10),
  CONSTRAINT fk_enr_cby FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_enr_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Đăng ký học phần';


-- ============================================================
-- 17. ĐIỂM DANH
-- ============================================================
CREATE TABLE attendance_records (
  id              INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  schedule_id     INT UNSIGNED  NOT NULL,
  student_id      INT UNSIGNED  NOT NULL,
  attendance_date DATE          NOT NULL,
  status          ENUM('present','absent','late','excused')
                  NOT NULL DEFAULT 'absent',
  note            TEXT,
  checked_by      INT UNSIGNED  COMMENT 'user_id người điểm danh (CreatedBy)',
  checked_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP, -- (CreatedAt)

  -- Audit Columns
  updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by      INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_attendance (schedule_id, student_id, attendance_date),
  INDEX idx_att_student    (student_id),
  INDEX idx_att_date       (attendance_date),
  CONSTRAINT fk_att_schedule FOREIGN KEY (schedule_id) REFERENCES schedules(id) ON DELETE CASCADE,
  CONSTRAINT fk_att_student  FOREIGN KEY (student_id)  REFERENCES students(id)  ON DELETE CASCADE,
  CONSTRAINT fk_att_checker  FOREIGN KEY (checked_by)  REFERENCES users(id)     ON DELETE SET NULL,
  CONSTRAINT fk_att_uby      FOREIGN KEY (updated_by)  REFERENCES users(id)     ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Bảng điểm danh theo buổi học';


-- ============================================================
-- 18. THÔNG BÁO
-- ============================================================
CREATE TABLE notifications (
  id         INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id    INT UNSIGNED  NOT NULL,
  title      VARCHAR(200)  NOT NULL,
  body       TEXT          NOT NULL,
  type       ENUM('schedule_change','grade','enrollment','system','reminder')
             NOT NULL DEFAULT 'system',
  is_read    TINYINT(1)    NOT NULL DEFAULT 0,
  ref_type   VARCHAR(50),
  ref_id     INT UNSIGNED,
  created_at TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  read_at    TIMESTAMP,

  PRIMARY KEY (id),
  INDEX idx_notif_user (user_id, is_read),
  CONSTRAINT fk_notif_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='Thông báo người dùng';

-- ============================================================
-- 19. HỌC PHI
-- ============================================================

CREATE TABLE tuition_invoices (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  student_id       INT UNSIGNED  NOT NULL,
  semester_id      INT UNSIGNED  NOT NULL,
  total_amount     DECIMAL(12,2) NOT NULL COMMENT 'Tổng tiền học phí học kỳ',
  paid_amount      DECIMAL(12,2) NOT NULL DEFAULT 0 COMMENT 'Số tiền đã đóng',
  due_date         DATE          NOT NULL COMMENT 'Hạn chót nộp học phí',
  status           ENUM('unpaid','partial','paid','overdue','cancelled') NOT NULL DEFAULT 'unpaid',
  created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  UNIQUE KEY uq_invoice (student_id, semester_id), -- Mỗi kỳ chỉ có 1 hóa đơn tổng
  CONSTRAINT fk_inv_student  FOREIGN KEY (student_id)  REFERENCES students(id),
  CONSTRAINT fk_inv_semester FOREIGN KEY (semester_id) REFERENCES semesters(id)
) ENGINE=InnoDB COMMENT='Hóa đơn công nợ học phí theo học kỳ';

-- ============================================================
-- 20. PHIEU THU
-- ============================================================
CREATE TABLE tuition_payments (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  invoice_id       INT UNSIGNED  NOT NULL COMMENT 'Thanh toán cho hóa đơn nào',
  amount           DECIMAL(12,2) NOT NULL COMMENT 'Số tiền giao dịch',
  payment_method   ENUM('cash','bank_transfer','momo','vnpay','visa') NOT NULL,
  transaction_code VARCHAR(100)  COMMENT 'Mã giao dịch từ ngân hàng/ví điện tử',
  payment_date     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status           ENUM('pending','success','failed','refunded') NOT NULL DEFAULT 'pending',
  note             TEXT,

  PRIMARY KEY (id),
  INDEX idx_payment_invoice (invoice_id),
  CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES tuition_invoices(id) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='Lịch sử giao dịch thanh toán học phí';

-- ============================================================
-- 21. TỔNG KẾT HỌC KỲ (GPA, Điểm rèn luyện, Học bổng)
-- ============================================================
CREATE TABLE student_semester_summaries (
  id                 INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  student_id         INT UNSIGNED  NOT NULL,
  semester_id        INT UNSIGNED  NOT NULL,

  -- Thông tin tổng kết học thuật
  gpa                DECIMAL(4,2)  COMMENT 'Điểm trung bình học kỳ (hệ 4 hoặc 10)',
  credits_earned     TINYINT       COMMENT 'Số tín chỉ tích lũy được trong kỳ',

  -- Thông tin điểm rèn luyện
  conduct_score      TINYINT UNSIGNED COMMENT 'Điểm rèn luyện (0-100)',
  conduct_grade      VARCHAR(20)   COMMENT 'Xếp loại rèn luyện (VD: Xuất sắc, Tốt, Khá)',

  -- Thông tin học bổng
  scholarship_name   VARCHAR(150)  COMMENT 'Tên học bổng đạt được (nếu có)',
  scholarship_amount DECIMAL(12,2) COMMENT 'Số tiền học bổng',

  notes              TEXT,

  -- Audit Columns
  created_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by         INT UNSIGNED  NULL,
  updated_by         INT UNSIGNED  NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_student_semester (student_id, semester_id), -- Đảm bảo 1 kỳ chỉ có 1 bản tổng kết
  CONSTRAINT fk_sss_student  FOREIGN KEY (student_id)  REFERENCES students(id) ON DELETE CASCADE,
  CONSTRAINT fk_sss_semester FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE RESTRICT,
  CONSTRAINT fk_sss_cby      FOREIGN KEY (created_by)  REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_sss_uby      FOREIGN KEY (updated_by)  REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT chk_conduct     CHECK (conduct_score <= 100)
) ENGINE=InnoDB COMMENT='Tổng kết học kỳ của sinh viên (GPA, Rèn luyện, Học bổng)';


-- Bật lại kiểm tra khóa ngoại sau khi đã tạo xong các bảng
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- VIEWS
-- ============================================================

CREATE OR REPLACE VIEW v_daily_schedule AS
SELECT
  sc.name                                        AS school_name,
  sb.name                                        AS branch_name,
  s.day_of_week,
  s.start_time,
  s.end_time,
  s.type                                         AS session_type,
  c.code                                         AS class_code,
  co.code                                        AS course_code,
  co.name                                        AS course_name,
  u.full_name                                    AS teacher_name,
  CONCAT(r.building,'-',r.room_number)           AS room,
  r.capacity                                     AS room_capacity,
  sem.name                                       AS semester,
  ay.name                                        AS academic_year
FROM schedules s
JOIN classes c         ON c.id   = s.class_id
JOIN courses co        ON co.id  = c.course_id
JOIN teachers t        ON t.id   = c.teacher_id
JOIN users u           ON u.id   = t.user_id
JOIN rooms r           ON r.id   = s.room_id
JOIN school_branches sb ON sb.id = r.branch_id
JOIN schools sc        ON sc.id  = sb.school_id
JOIN semesters sem     ON sem.id = c.semester_id
JOIN academic_years ay ON ay.id  = sem.academic_year_id
WHERE c.status NOT IN ('cancelled') AND s.end_date >= CURDATE();



-- ============================================================
-- DỮ LIỆU MẪU
-- ============================================================

INSERT INTO schools (code, name, short_name, type, email, phone, website, established_date, created_by, updated_by) VALUES
  ('HCMUT',     'Trường Đại học Bách Khoa TP.HCM', 'BK-HCM',   'university',      'info@hcmut.edu.vn',   '028-3865-4086', 'https://hcmut.edu.vn',  '1957-10-27', NULL, NULL),
  ('IELTS_PRO', 'Trung tâm Tiếng Anh IELTS Pro',   'IELTS Pro', 'language_center', 'hi@ieltspro.vn',      '028-9999-0001', 'https://ieltspro.vn',   '2015-06-01', NULL, NULL);

INSERT INTO school_branches (school_id, code, name, address, city, district, phone, is_main, created_by, updated_by) VALUES
  (1, 'CS1', 'Cơ sở 1 - Lý Thường Kiệt', '268 Lý Thường Kiệt, P.14', 'TP.HCM',    'Quận 10',  '028-3864-7256', 1, NULL, NULL),
  (1, 'CS2', 'Cơ sở 2 - Dĩ An',          'Khu phố 6, Dĩ An',         'Bình Dương','Dĩ An',    '0274-372-5540', 0, NULL, NULL),
  (2, 'Q1',  'Chi nhánh Quận 1',          '123 Nguyễn Huệ, P.BN',     'TP.HCM',    'Quận 1',   '028-9999-0002', 1, NULL, NULL),
  (2, 'TD',  'Chi nhánh Thủ Đức',         '456 Võ Văn Ngân, P.BT',    'TP.HCM',    'Thủ Đức',  '028-9999-0003', 0, NULL, NULL);

INSERT INTO academic_years (school_id, name, start_date, end_date, created_by, updated_by) VALUES
  (1, '2024-2025', '2024-09-01', '2025-08-31', NULL, NULL),
  (2, '2024-2025', '2024-09-01', '2025-08-31', NULL, NULL);

INSERT INTO semesters (academic_year_id, name, start_date, end_date, created_by, updated_by) VALUES
  (1, 'Học kỳ 1',    '2024-09-09', '2025-01-10', NULL, NULL),
  (1, 'Học kỳ 2',    '2025-02-10', '2025-06-13', NULL, NULL),
  (2, 'Khóa tháng 9','2024-09-02', '2024-11-30', NULL, NULL);

INSERT INTO departments (school_id, code, name, created_by, updated_by) VALUES
  (1, 'CNTT',  'Công nghệ Thông tin', NULL, NULL),
  (1, 'KTKT',  'Kỹ thuật Kinh tế', NULL, NULL),
  (2, 'IELTS', 'Bộ môn IELTS', NULL, NULL);

INSERT INTO rooms (branch_id, building, room_number, capacity, room_type, equipment, created_by, updated_by) VALUES
  (1, 'A', '101', 50, 'classroom',    '["projector","ac","whiteboard"]', NULL, NULL),
  (1, 'B', '102', 30, 'lab',          '["computers","projector","ac"]', NULL, NULL),
  (1, 'B', '301', 80, 'lecture_hall', '["projector","ac","mic_system"]', NULL, NULL),
  (2, 'C', '201', 40, 'classroom',    '["projector","ac","smartboard"]', NULL, NULL),
  (3, 'A', '001', 20, 'seminar',      '["tv_screen","ac"]', NULL, NULL);

INSERT INTO users (school_id, code, full_name, email, password_hash, phone, gender, created_by, updated_by) VALUES
  (1,'GV001','Nguyễn Văn An', 'an.nguyen@hcmut.edu.vn',        '$2b$10$h1','0901234561','male', NULL, NULL),
  (1,'GV002','Trần Thị Bích', 'bich.tran@hcmut.edu.vn',        '$2b$10$h2','0901234562','female', NULL, NULL),
  (2,'GV003','Lê Minh Cường', 'cuong.le@ieltspro.vn',           '$2b$10$h3','0901234563','male', NULL, NULL),
  (1,'SV001','Phạm Văn Đức',  'duc.pham@student.hcmut.edu.vn',  '$2b$10$h4','0912345671','male', NULL, NULL),
  (1,'SV002','Hoàng Thị Lan', 'lan.hoang@student.hcmut.edu.vn', '$2b$10$h5','0912345672','female', NULL, NULL),
  (2,'SV003','Vũ Quốc Hùng',  'hung.vu@ieltspro.vn',            '$2b$10$h6','0912345673','male', NULL, NULL);

INSERT INTO user_roles (user_id, role_id, granted_by) VALUES
  (1,2,NULL),(2,2,NULL),(3,2,NULL),(4,3,NULL),(5,3,NULL),(6,3,NULL);

INSERT INTO teachers (user_id, department_id, degree, specialization, join_date, created_by, updated_by) VALUES
  (1,1,'Tiến sĩ','Trí tuệ nhân tạo',  '2018-08-01', NULL, NULL),
  (2,1,'Thạc sĩ','Kỹ thuật phần mềm', '2020-01-15', NULL, NULL),
  (3,3,'Thạc sĩ','Ngôn ngữ học',       '2019-06-01', NULL, NULL);

INSERT INTO students (user_id, student_code, department_id, enrollment_year, major, class_name, created_by, updated_by) VALUES
  (4,'21IT001',1,2021,'Kỹ thuật phần mềm','CNTT21A', NULL, NULL),
  (5,'21IT002',1,2021,'Kỹ thuật phần mềm','CNTT21A', NULL, NULL),
  (6,'IE240301',3,2024,'IELTS General',NULL, NULL, NULL);

INSERT INTO courses (code, name, credits, total_sessions, department_id, created_by, updated_by) VALUES
  ('INT101','Nhập môn Lập trình',              3,30,1, NULL, NULL),
  ('INT201','Cấu trúc dữ liệu & Giải thuật',   3,30,1, NULL, NULL),
  ('IEL101','IELTS Foundation',                 0,40,3, NULL, NULL);

INSERT INTO classes (code, course_id, semester_id, teacher_id, branch_id, max_students, status, created_by, updated_by) VALUES
  ('INT101-01-HK1-2425',1,1,1,1,40,'in_progress', NULL, NULL),
  ('INT201-01-HK1-2425',2,1,2,1,35,'in_progress', NULL, NULL),
  ('IEL101-Q1-T9-2024', 3,3,3,3,20,'open', NULL, NULL);

INSERT INTO schedules (class_id, room_id, day_of_week, start_time, end_time, start_date, end_date, type, created_by, updated_by) VALUES
  (1,1,2,'07:30:00','09:30:00','2024-09-09','2024-12-20','regular', NULL, NULL),
  (1,1,4,'13:30:00','15:30:00','2024-09-09','2024-12-20','regular', NULL, NULL),
  (2,2,3,'09:45:00','11:45:00','2024-09-10','2024-12-21','regular', NULL, NULL),
  (3,5,6,'08:00:00','10:00:00','2024-09-07','2024-11-30','regular', NULL, NULL);

INSERT INTO enrollments (student_id, class_id, status, created_by, updated_by) VALUES
  (1,1,'enrolled', NULL, NULL),(2,1,'enrolled', NULL, NULL),
  (1,2,'enrolled', NULL, NULL),(2,2,'enrolled', NULL, NULL),
  (3,3,'enrolled', NULL, NULL);

INSERT INTO attendance_records (schedule_id, student_id, attendance_date, status, checked_by, updated_by) VALUES
  (1,1,'2024-09-09','present',1, NULL),
  (1,2,'2024-09-09','present',1, NULL),
  (1,1,'2024-09-11','late',   1, NULL),
  (1,2,'2024-09-11','absent', 1, NULL);

INSERT INTO schedule_exceptions (schedule_id, exception_date, reason, exception_type, replacement_date, created_by, updated_by) VALUES
  (1,'2024-09-02','Nghỉ Quốc khánh 2/9','rescheduled','2024-09-07', NULL, NULL);