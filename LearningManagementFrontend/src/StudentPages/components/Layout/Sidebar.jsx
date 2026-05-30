import React, { useState } from 'react';
import { NavLink } from 'react-router-dom';

export default function Sidebar() {
  const [open, setOpen] = useState({
    'ttc': true, 
    'hoctap': true, 
    'dkhp': false, 
    'hocphi': false, 
    'khac': false 
  });
  
  const toggle = (id) => setOpen(prev => ({...prev, [id]: !prev[id]}));
  
  const navClass = ({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`;

  return (
    <aside className="sidebar">
      <div className="sidebar-section">
        <div className="sidebar-header"><span className="icon">🏠</span> TRANG CHỦ</div>
        <NavLink to="/dashboard" className={navClass}>Trang chủ</NavLink>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.ttc ? 'open' : ''}`} onClick={() => toggle('ttc')}>
          <span>🖥 THÔNG TIN CHUNG</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.ttc ? 'open' : ''}`}>
          <NavLink to="/student-info" className={navClass}>Thông tin sinh viên</NavLink>
          <NavLink to="/declaration" className={navClass}>Kê khai thông tin sinh viên</NavLink>
          <NavLink to="/notifications" className={navClass}>Ghi chú nhắc nhở</NavLink>
          <NavLink to="/surveys" className={navClass}>Khảo sát sự kiện</NavLink>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.hoctap ? 'open' : ''}`} onClick={() => toggle('hoctap')}>
          <span>🎓 HỌC TẬP</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.hoctap ? 'open' : ''}`}>
          <NavLink to="/grades" className={navClass}>Kết quả học tập</NavLink>
          <NavLink to="/weekly-schedule" className={navClass}>Lịch theo tuần</NavLink>
          <NavLink to="/progress-schedule" className={navClass}>Lịch theo tiến độ</NavLink>
          <NavLink to="/attendance" className={navClass}>Thông tin điểm danh</NavLink>
          <NavLink to="/conduct-score" className={navClass}>Kết quả rèn luyện</NavLink>
          <NavLink to="/scholarships" className={navClass}>Mức học bổng được xét</NavLink>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.dkhp ? 'open' : ''}`} onClick={() => toggle('dkhp')}>
          <span>✅ ĐĂNG KÝ HỌC PHẦN</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.dkhp ? 'open' : ''}`}>
          <NavLink to="/curriculum" className={navClass}>Chương trình khung</NavLink>
          <NavLink to="/student/course-registration" className={navClass}>Đăng ký học phần</NavLink>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.hocphi ? 'open' : ''}`} onClick={() => toggle('hocphi')}>
          <span>💳 HỌC PHÍ</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.hocphi ? 'open' : ''}`}>
          <NavLink to="/tuition-fee" className={navClass}>Tra cứu công nợ</NavLink>
          <NavLink to="/online-payment" className={navClass}>Thanh toán trực tuyến</NavLink>
          <NavLink to="/online-receipts" className={navClass}>Phiếu thu trực tuyến</NavLink>
        </div>
      </div>

      
      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.khac ? 'open' : ''}`} onClick={() => toggle('khac')}>
          <span>⚙ KHÁC</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.khac ? 'open' : ''}`}>
          <NavLink to="/change-password" className={navClass}>Đổi mật khẩu</NavLink>
        </div>
      </div>
      
    </aside>
  );
}