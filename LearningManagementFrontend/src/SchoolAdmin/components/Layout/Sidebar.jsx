import React from 'react';
import { NavLink } from 'react-router-dom';

export default function Sidebar() {
  const navClass = ({ isActive }) => `nav-item ${isActive ? 'active' : ''}`;
  return (
    <aside className="admin-sidebar">
      <div className="logo-zone">
        <div className="logo-badge">HUIT</div>
        <div>
          <div className="admin-logo-text">ĐH Bách Khoa HCM</div>
          <div className="logo-sub">Quản trị cơ sở đào tạo</div>
        </div>
      </div>
      <div className="nav-wrap">
        <div className="nav-section">
          <div className="nav-label">Tổng quan</div>
          <NavLink to="/dashboard" className={navClass}><span className="nav-icon">⬡</span> Dashboard</NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Cơ sở hạ tầng</div>
          <NavLink to="/branches" className={navClass}><span className="nav-icon">📍</span> Cơ sở &amp; Phòng học</NavLink>
          <NavLink to="/departments" className={navClass}><span className="nav-icon">🏛</span> Khoa / Bộ môn</NavLink>
          <NavLink to="/semesters" className={navClass}><span className="nav-icon">📆</span> Năm học &amp; Học kỳ</NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Học vụ</div>
          <NavLink to="/courses" className={navClass}><span className="nav-icon">📚</span> Môn học</NavLink>
          <NavLink to="/classes" className={navClass}><span className="nav-icon">🎓</span> Lớp học <span className="nav-badge">3</span></NavLink>
          <NavLink to="/schedule" className={navClass}><span className="nav-icon">🗓</span> Lịch học</NavLink>
          <NavLink to="/exceptions" className={navClass}><span className="nav-icon">⚠️</span> Ngoại lệ lịch <span className="nav-badge warn">1</span></NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Nhân sự &amp; Học sinh</div>
          <NavLink to="/teachers" className={navClass}><span className="nav-icon">👨‍🏫</span> Giảng viên <span className="nav-badge">3</span></NavLink>
          <NavLink to="/students" className={navClass}><span className="nav-icon">👨‍🎓</span> Sinh viên <span className="nav-badge">3</span></NavLink>
          <NavLink to="/users" className={navClass}><span className="nav-icon">👤</span> Tài khoản</NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Học tập</div>
          <NavLink to="/enrollments" className={navClass}><span className="nav-icon">✅</span> Đăng ký học phần</NavLink>
          <NavLink to="/attendance" className={navClass}><span className="nav-icon">📋</span> Điểm danh <span className="nav-badge danger">4</span></NavLink>
          <NavLink to="/grades" className={navClass}><span className="nav-icon">📊</span> Kết quả &amp; Học bổng</NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Tài chính</div>
          <NavLink to="/tuition" className={navClass}><span className="nav-icon">💰</span> Học phí &amp; Công nợ</NavLink>
          <NavLink to="/payments" className={navClass}><span className="nav-icon">🧾</span> Phiếu thu</NavLink>
        </div>
        <div className="nav-section">
          <div className="nav-label">Hệ thống</div>
          <NavLink to="/notifications" className={navClass}><span className="nav-icon">🔔</span> Thông báo <span class="nav-badge danger">12</span></NavLink>
          <NavLink to="/settings" className={navClass}><span className="nav-icon">⚙️</span> Cài đặt trường</NavLink>
        </div>
      </div>
      <div className="sidebar-bottom">
        <div className="user-chip">
          <div className="user-av">AD</div>
          <div>
            <div className="user-name">Quản trị viên</div>
            <div className="user-role">admin@hcmut.edu.vn</div>
          </div>
          <span style={{marginLeft:'auto', color:'rgba(255,255,255,.4)', fontSize:'16px'}}>⋮</span>
        </div>
      </div>
    </aside>
  );
}