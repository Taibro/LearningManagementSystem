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
  type             ENUM('UNIVERSITY','COLLEGE','HIGH_SCHOOL',
                        'VOCATIONAL','LANGUAGE_CENTER','TUTORING_CENTER','OTHER')
                   NOT NULL DEFAULT 'UNIVERSITY',
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
CREATE TABLE role (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  name        VARCHAR(30)   NOT NULL COMMENT 'admin | teacher | student',
  description TEXT,

  PRIMARY KEY (id),
  UNIQUE KEY uq_role_name (name)
) ENGINE=InnoDB COMMENT='Vai trò hệ thống';

INSERT INTO role (name, description) VALUES
  ('SAAS_ADMIN',   'Quản trị viên hệ thống'),
  ('LECTURER', 'Giảng viên'),
  ('STUDENT', 'Sinh viên / Học sinh'),
  ('SCHOOL_ADMIN', 'Admin nha truong');

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
  gender        ENUM('MALE','FEMALE','OTHER'),
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
  room_type   ENUM('CLASSROOM','LAB','SEMINAR','LECTURE_HALL','ONLINE')
              NOT NULL DEFAULT 'CLASSROOM',
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
  status       ENUM('OPEN','CLOSED','IN_PROGRESS','COMPLETED','CANCELLED')
               NOT NULL DEFAULT 'OPEN',
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
  type        ENUM('REGULAR','MAKEUP','EXAM','LAB','SEMINAR')
              NOT NULL DEFAULT 'REGULAR',
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
  exception_type      ENUM('CANCELLED','RESCHEDULED','ROOM_CHANGE', 'SUBSTITUTED')
                      NOT NULL DEFAULT 'CANCELLED',
  replacement_date    DATE,
  replacement_room_id INT UNSIGNED,
  approval_status ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING' COMMENT 'Trạng thái duyệt đơn',
  proof_file_url VARCHAR(500) COMMENT 'Đường dẫn file minh chứng (Cloudinary/S3...)',
   replacement_start_period INT COMMENT 'Tiết bắt đầu ca dạy bù (VD: 1)',
    replacement_end_period INT COMMENT 'Tiết kết thúc ca dạy bù (VD: 3)',
    suggested_room VARCHAR(50) COMMENT 'Phòng học đề xuất (VD: A401)',
    makeup_notes TEXT COMMENT 'Ghi chú cho đơn dạy bù',
    makeup_status ENUM('PENDING', 'APPROVED', 'REJECTED', 'COMPLETED') DEFAULT NULL COMMENT 'Trạng thái duyệt đơn dạy bù',
    substitute_teacher_id INT UNSIGNED COMMENT 'GV được nhờ dạy thay',
    substitute_content TEXT COMMENT 'Nội dung bài dạy thay',
    substitute_status ENUM('PENDING', 'APPROVED', 'REJECTED') COMMENT 'Trạng thái duyệt dạy thay',


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
  CONSTRAINT fk_se_uby FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_se_sub_teacher FOREIGN KEY (substitute_teacher_id) REFERENCES teachers(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Ngoại lệ lịch học';


-- ============================================================
-- 16. ĐĂNG KÝ HỌC
-- ============================================================
CREATE TABLE enrollments (
  id              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
  student_id      INT UNSIGNED    NOT NULL,
  class_id        INT UNSIGNED    NOT NULL,
  enrollment_date TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Đóng vai trò created_at
  status          ENUM('PENDING','ENROLLED','DROPPED','COMPLETED','FAILED')
                  NOT NULL DEFAULT 'PENDING',
  grade_attendance FLOAT,
  grade_midterm   FLOAT    COMMENT 'Điểm giữa kỳ (0-10)',
  grade_final     FLOAT    COMMENT 'Điểm cuối kỳ (0-10)',
  grade_total     FLOAT    COMMENT 'Điểm tổng kết (0-10)',
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
  status          ENUM('PRESENT','ABSENT','LATE','EXCUSED')
                  NOT NULL DEFAULT 'ABSENT',
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
  type       ENUM('SCHEDULE_CHANGE','GRADE','ENROLLMENT','SYSTEM','REMINDER')
             NOT NULL DEFAULT 'SYSTEM',
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
  status           ENUM('UNPAID','PARTIAL','PAID','OVERDUE','CANCELLED') NOT NULL DEFAULT 'UNPAID',
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
  payment_method   ENUM('CASH','BANK_TRANSFER','MOMO','VNPAY','VISA') NOT NULL,
  transaction_code VARCHAR(100)  COMMENT 'Mã giao dịch từ ngân hàng/ví điện tử',
  payment_date     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status           ENUM('PENDING','SUCCESS','FAILED','REFUNDED') NOT NULL DEFAULT 'PENDING',
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

CREATE TABLE teacher_declarations (
  id                INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  teacher_id        INT UNSIGNED  NOT NULL,
  semester_id       INT UNSIGNED  NOT NULL,
  expected_sessions INT           NOT NULL DEFAULT 0 COMMENT 'Số tiết dạy dự kiến',
  expected_classes  INT           NOT NULL DEFAULT 0 COMMENT 'Số lớp phụ trách',
  notes             TEXT,

  created_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  UNIQUE KEY uq_declaration (teacher_id, semester_id), -- Mỗi kỳ chỉ khai báo 1 lần
  CONSTRAINT fk_td_teacher  FOREIGN KEY (teacher_id)  REFERENCES teachers(id)  ON DELETE CASCADE,
  CONSTRAINT fk_td_semester FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT='Khai báo thông tin giảng dạy dự kiến của Giảng viên';

CREATE TABLE class_materials (
  id           INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  class_id     INT UNSIGNED  NOT NULL COMMENT 'Tài liệu thuộc lớp học phần nào',
  title        VARCHAR(200)  NOT NULL COMMENT 'Tên hiển thị: Slide Chương 1...',
  file_name    VARCHAR(255)  NOT NULL COMMENT 'Tên file gốc giảng viên tải lên',
  file_url     VARCHAR(500)  NOT NULL COMMENT 'Đường dẫn HTTPS công khai từ Cloudinary',
  file_size    BIGINT        NOT NULL COMMENT 'Dung lượng file (tính bằng Byte)',
  content_type VARCHAR(100)  COMMENT 'Định dạng file (MIME type)',
  doc_type     ENUM('SLIDE', 'EXERCISE', 'SYLLABUS', 'REFERENCE', 'OTHER') NOT NULL DEFAULT 'OTHER',
  uploaded_by  INT UNSIGNED  NOT NULL COMMENT 'ID của giảng viên tải lên',

  created_at   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  INDEX idx_mat_class (class_id),
  INDEX idx_mat_type  (doc_type),
  CONSTRAINT fk_mat_class   FOREIGN KEY (class_id)    REFERENCES classes(id)  ON DELETE CASCADE,
  CONSTRAINT fk_mat_teacher FOREIGN KEY (uploaded_by) REFERENCES teachers(id) ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='Tài liệu giảng dạy của lớp học phần';

SELECT * FROM class_materials;

-- Bật lại kiểm tra khóa ngoại sau khi đã tạo xong các bảng
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- SAAS
-- ============================================================
-- BẢNG 1: GÓI CƯỚC SAAS (Saas Plans)
CREATE TABLE saas_plans (
  id             INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  code           VARCHAR(50)   NOT NULL UNIQUE COMMENT 'VD: BASIC, PRO, ENTERPRISE',
  name           VARCHAR(100)  NOT NULL,
  monthly_price  DECIMAL(12,2) NOT NULL DEFAULT 0,
  yearly_price   DECIMAL(12,2) NOT NULL DEFAULT 0,
  max_students   INT           NOT NULL COMMENT '-1 là không giới hạn (Unlimited)',
  max_storage_gb INT           NOT NULL COMMENT '-1 là không giới hạn (Unlimited)',
  features       JSON          COMMENT '["attendance", "materials", "salary"]',
  is_active      TINYINT(1)    NOT NULL DEFAULT 1,

  created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB COMMENT='Danh mục gói cước phần mềm EduSpace';

-- BẢNG 2: LỊCH SỬ THUÊ BAO CỦA TRƯỜNG (Saas Subscriptions)
CREATE TABLE saas_subscriptions (
  id             INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  school_id      INT UNSIGNED  NOT NULL,
  plan_id        INT UNSIGNED  NOT NULL,
  start_date     DATE          NOT NULL,
  end_date       DATE          NOT NULL COMMENT 'Ngày hết hạn phần mềm',
  billing_cycle  ENUM('MONTHLY', 'YEARLY', 'LIFETIME') NOT NULL,
  status         ENUM('ACTIVE', 'EXPIRED', 'SUSPENDED', 'CANCELLED') NOT NULL DEFAULT 'ACTIVE',

  created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  CONSTRAINT fk_sub_school FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  CONSTRAINT fk_sub_plan   FOREIGN KEY (plan_id)   REFERENCES saas_plans(id)
) ENGINE=InnoDB COMMENT='Hợp đồng thuê bao của các trường';

-- BẢNG 3: HÓA ĐƠN THU TIỀN PHẦN MỀM (Saas Invoices)
-- Bảng này độc lập với tuition_invoices (thu học phí của sinh viên)
CREATE TABLE saas_invoices (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  school_id        INT UNSIGNED  NOT NULL,
  subscription_id  INT UNSIGNED  NOT NULL,
  amount           DECIMAL(12,2) NOT NULL,
  payment_status   ENUM('PENDING', 'PAID', 'FAILED') NOT NULL DEFAULT 'PENDING',
  payment_method   VARCHAR(50)   COMMENT 'Momo, VNPay, Bank Transfer',
  paid_at          TIMESTAMP     NULL,

  created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_sinv_school FOREIGN KEY (school_id)       REFERENCES schools(id),
  CONSTRAINT fk_sinv_sub    FOREIGN KEY (subscription_id) REFERENCES saas_subscriptions(id)
) ENGINE=InnoDB COMMENT='Hóa đơn thu tiền thuê phần mềm từ các trường';

-- BẢNG 4: NHẬT KÝ LỖI HỆ THỐNG (System Error Logs)
CREATE TABLE system_error_logs (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  school_id     INT UNSIGNED    NULL COMMENT 'Lỗi xảy ra ở trường nào (nếu có)',
  endpoint      VARCHAR(255)    NOT NULL COMMENT 'API URL bị lỗi',
  error_message TEXT            NOT NULL COMMENT 'Nội dung lỗi ngắn',
  stack_trace   LONGTEXT        COMMENT 'Toàn bộ Stack Trace của Java',
  user_agent    VARCHAR(255)    COMMENT 'Thiết bị/Trình duyệt của khách hàng',
  is_resolved   TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '0: Chưa fix, 1: Đã fix',

  created_at    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_err_school FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Nhật ký bắt lỗi toàn hệ thống';

-- Tạo bảng lưu trữ đánh giá của sinh viên
CREATE TABLE teacher_evaluations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  teacher_id INT UNSIGNED NOT NULL,
  semester_id INT UNSIGNED NOT NULL,
  class_id INT UNSIGNED NOT NULL,

  -- 5 Tiêu chí đánh giá (Thang điểm 5)
  score_knowledge DECIMAL(2,1) NOT NULL COMMENT 'Kiến thức chuyên môn',
  score_method DECIMAL(2,1) NOT NULL COMMENT 'Phương pháp giảng dạy',
  score_interaction DECIMAL(2,1) NOT NULL COMMENT 'Tương tác với sinh viên',
  score_materials DECIMAL(2,1) NOT NULL COMMENT 'Tài liệu giảng dạy',
  score_punctuality DECIMAL(2,1) NOT NULL COMMENT 'Đúng giờ, kỷ luật',

  comment TEXT COMMENT 'Nhận xét từ sinh viên',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  -- Lưu ý: Có thể có cột student_id để hệ thống check trùng, nhưng TUYỆT ĐỐI KHÔNG JOIN để lấy tên.
  student_id INT UNSIGNED NULL,

  PRIMARY KEY (id),
  CONSTRAINT fk_eval_teacher FOREIGN KEY (teacher_id) REFERENCES teacher(id) ON DELETE CASCADE,
  CONSTRAINT fk_eval_semester FOREIGN KEY (semester_id) REFERENCES semester(id) ON DELETE CASCADE,
  CONSTRAINT fk_eval_class FOREIGN KEY (class_id) REFERENCES class(id) ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='Bảng lưu kết quả khảo sát giảng viên';
