import React from 'react';
import { NavLink } from 'react-router-dom';

export default function Sidebar() {
  const navClass = ({ isActive }) => `nav-item ${isActive ? 'active' : ''}`;

  return (
    <aside className="sidebar">
      <div className="logo-zone">
        <div className="logo-badge">ADM</div>
        <div>
          <div className="logo-text">HUIT Admin</div>
          <div className="logo-sub">Quản trị hệ thống</div>
        </div>
      </div>
      <div style={{ flex: 1, overflowY: 'auto', padding: '8px 0' }}>
        <div className="nav-section">
          <div className="nav-label">Tổng quan</div>
          <NavLink to="/saas/dashboard" className={navClass}><span className="icon">⬛</span> Dashboard</NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Cơ sở hạ tầng</div>
          <NavLink to="/saas/schools" className={navClass}><span className="icon">🏫</span> Trường học <span className="nav-badge">2</span></NavLink>
          <NavLink to="/saas/branches" className={navClass}><span className="icon">📍</span> Cơ sở / Chi nhánh <span className="nav-badge">4</span></NavLink>
          <NavLink to="/saas/departments" className={navClass}><span className="icon">🏛</span> Khoa / Bộ môn <span className="nav-badge">3</span></NavLink>
          <NavLink to="/saas/rooms" className={navClass}><span className="icon">🚪</span> Phòng học <span className="nav-badge">5</span></NavLink>
        </div>
        {/* <div className="nav-section">
          <div className="nav-label">Học vụ</div>
          <NavLink to="/saas/academic_years" className={navClass}><span className="icon">📆</span> Năm học</NavLink>
          <NavLink to="/saas/semesters" className={navClass}><span className="icon">📅</span> Học kỳ</NavLink>
          <NavLink to="/saas/courses" className={navClass}><span className="icon">📚</span> Môn học <span className="nav-badge">3</span></NavLink>
          <NavLink to="/saas/classes" className={navClass}><span className="icon">🎓</span> Lớp học <span className="nav-badge green">3</span></NavLink>
          <NavLink to="/saas/schedules" className={navClass}><span className="icon">🗓</span> Lịch học</NavLink>
        </div> */}
        <div className="nav-section">
          <div className="nav-label">Người dùng</div>
          <NavLink to="/saas/users" className={navClass}><span className="icon">👥</span> Tài khoản <span className="nav-badge">6</span></NavLink>
          {/* <NavLink to="/saas/teachers" className={navClass}><span className="icon">👨‍🏫</span> Giảng viên <span className="nav-badge">3</span></NavLink>
          <NavLink to="/saas/students" className={navClass}><span className="icon">👨‍🎓</span> Sinh viên <span className="nav-badge">3</span></NavLink> */}
          <NavLink to="/saas/roles" className={navClass}><span className="icon">🔑</span> Vai trò & Phân quyền</NavLink>
        </div>
        {/* <div className="nav-section">
          <div className="nav-label">Hoạt động</div>
          <NavLink to="/saas/enrollments" className={navClass}><span className="icon">✅</span> Đăng ký học phần <span className="nav-badge">5</span></NavLink>
          <NavLink to="/saas/attendance" className={navClass}><span className="icon">📋</span> Điểm danh <span className="nav-badge red">4</span></NavLink>
          <NavLink to="/saas/grades" className={navClass}><span className="icon">📊</span> Kết quả học tập</NavLink>
          <NavLink to="/saas/conduct" className={navClass}><span className="icon">🏅</span> Rèn luyện & Học bổng</NavLink>
        </div> */}
        {/* <div className="nav-section">
          <div className="nav-label">Tài chính</div>
          <NavLink to="/saas/invoices" className={navClass}><span className="icon">🧾</span> Công nợ học phí</NavLink>
          <NavLink to="/saas/payments" className={navClass}><span className="icon">💳</span> Giao dịch thanh toán</NavLink>
        </div> */}
        <div className="nav-section">
          {/* <div className="nav-label">Hệ thống</div>
          <NavLink to="/saas/notifications" className={navClass}><span className="icon">🔔</span> Thông báo <span className="nav-badge red">12</span></NavLink>
          <NavLink to="/saas/exceptions" className={navClass}><span className="icon">⚠️</span> Ngoại lệ lịch học</NavLink> */}
          <NavLink to="/saas/settings" className={navClass}><span className="icon">⚙️</span> Cài đặt hệ thống</NavLink>
        </div>
      </div>
      <div className="sidebar-footer">
        <div className="user-card">
          <div className="avatar">SA</div>
          <div>
            <div className="user-name">Super Admin</div>
            <div className="user-role">Quản trị toàn hệ thống</div>
          </div>
          <span style={{ marginLeft: 'auto', color: 'var(--muted)', fontSize: '14px' }}>⋮</span>
        </div>
      </div>
    </aside>
  );
}