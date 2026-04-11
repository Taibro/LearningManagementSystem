// src/components/Layout/Sidebar.jsx
import { NavLink } from 'react-router-dom';
import { useState } from 'react';

const Sidebar = () => {
  const [isAttendanceOpen, setIsAttendanceOpen] = useState(true);

  // Helper function để xử lý class Active của menu
  const navClass = ({ isActive }) =>
    `sidebar-item px-4 py-2.5 text-white text-sm flex items-center gap-2 transition-all ${isActive ? 'active' : ''}`;

  return (
    <aside className="sidebar w-64 flex-shrink-0 h-screen flex flex-col">
      <div className="logo-area p-5 border-b border-white/10">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-white rounded-lg flex items-center justify-center font-bold text-purple-700">HUIT</div>
          <div className="text-white">
            <div className="font-bold text-sm">HCMC UNIVERSITY</div>
            <div className="text-[10px] opacity-70">Industry and Trade</div>
          </div>
        </div>
      </div>

      <div className="sidebar-scroll overflow-y-auto flex-1 py-4">
        <div className="section-title">CÔNG TÁC GIẢNG DẠY</div>

        <NavLink to="/ho-so" className={navClass}>Hồ sơ cá nhân</NavLink>
        <NavLink to="/luong" className={navClass}>Thông tin lương</NavLink>
        <NavLink to="/khai-bao" className={navClass}>Khai báo thông tin</NavLink>
        <NavLink to="/tai-lieu" className={navClass}>Quản lý tài liệu</NavLink>

        {/* Menu con Chuyên cần */}
        <div>
          <div
            className="sidebar-item px-4 py-2.5 text-white text-sm flex items-center justify-between cursor-pointer"
            onClick={() => setIsAttendanceOpen(!isAttendanceOpen)}
          >
            <span className="flex items-center gap-2">Chuyên cần - Rèn luyện</span>
            <span className={`transition-transform ${isAttendanceOpen ? 'rotate-180' : ''}`}>▼</span>
          </div>
          <div className={`collapse-content ${isAttendanceOpen ? 'open' : ''}`}>
            <NavLink to="/diem-danh" className={navClass + " pl-8"}>Điểm danh sinh viên</NavLink>
            <NavLink to="/qr-code" className={navClass + " pl-8"}>Điểm danh QR Code</NavLink>
            <NavLink to="/phieu-danh-gia" className={navClass + " pl-8"}>Phiếu đánh giá</NavLink>
          </div>
        </div>

        <NavLink to="/ket-qua" className={navClass}>Quản lý kết quả</NavLink>
        <NavLink to="/lich-tien-do" className={navClass}>Lịch theo tiến độ</NavLink>
        <NavLink to="/lich-tuan" className={navClass}>Lịch theo tuần</NavLink>

        <div className="section-title">ĐỀ XUẤT</div>
        <NavLink to="/de-xuat-ngung" className={navClass}>Tạm ngừng dạy</NavLink>
        <NavLink to="/day-bu" className={navClass}>Dạy bù</NavLink>
        <NavLink to="/day-thay" className={navClass}>Dạy thay</NavLink>

        <div className="section-title">BÁO CÁO</div>
        <NavLink to="/thong-ke" className={navClass}>Thống kê thực giảng</NavLink>
        <NavLink to="/khao-sat" className={navClass}>Khảo sát</NavLink>
      </div>
    </aside>
  );
};

export default Sidebar;