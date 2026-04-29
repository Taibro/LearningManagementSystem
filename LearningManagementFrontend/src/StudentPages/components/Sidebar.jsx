import React, { useState } from 'react';

export default function Sidebar({ activePage, setPage }) {
  const [open, setOpen] = useState({
    'ttc': true, 
    'hoctap': true, 
    'dkhp': false, 
    'hocphi': false, 
    'khac': false
  });
  
  const toggle = (id) => setOpen(prev => ({...prev, [id]: !prev[id]}));
  const cls = (p) => `sidebar-item ${activePage === p ? 'active' : ''}`;

  return (
    <aside className="sidebar">
      <div className="sidebar-section">
        <div className="sidebar-header"><span className="icon">🏠</span> TRANG CHỦ</div>
        <div className={cls('dashboard')} onClick={() => setPage('dashboard')}>Trang chủ</div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.ttc ? 'open' : ''}`} onClick={() => toggle('ttc')}>
          <span>🖥 THÔNG TIN CHUNG</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.ttc ? 'open' : ''}`}>
          <div className={cls('student-info')} onClick={() => setPage('student-info')}>Thông tin sinh viên</div>
          <div className={cls('declaration')} onClick={() => setPage('declaration')}>Kê khai thông tin sinh viên</div>
          <div className={cls('services')} onClick={() => setPage('services')}>Dịch vụ trực tuyến</div>
          <div className={cls('notifications')} onClick={() => setPage('notifications')}>Ghi chú nhắc nhở</div>
          <div className={cls('certificates')} onClick={() => setPage('certificates')}>Đề xuất chứng chỉ</div>
          <div className={cls('student-profile')} onClick={() => setPage('student-profile')}>Hồ sơ sinh viên</div>
          <div className={cls('certificate-approval')} onClick={() => setPage('certificate-approval')}>Đề xuất xét cấp chứng chỉ SV</div>
          <div className={cls('surveys')} onClick={() => setPage('surveys')}>Khảo sát sự kiện</div>
          <div className={cls('graduation-approval')} onClick={() => setPage('graduation-approval')}>Đề xuất xét tốt nghiệp</div>
          <div className={cls('bachelor-registration')} onClick={() => setPage('bachelor-registration')}>Đăng ký CT Cử nhân/Kỹ sư</div>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.hoctap ? 'open' : ''}`} onClick={() => toggle('hoctap')}>
          <span>🎓 HỌC TẬP</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.hoctap ? 'open' : ''}`}>
          <div className={cls('grades')} onClick={() => setPage('grades')}>Kết quả học tập</div>
          <div className={cls('weekly-schedule')} onClick={() => setPage('weekly-schedule')}>Lịch theo tuần</div>
          <div className={cls('progress-schedule')} onClick={() => setPage('progress-schedule')}>Lịch theo tiến độ</div>
          <div className={cls('attendance')} onClick={() => setPage('attendance')}>Thông tin điểm danh</div>
          <div className={cls('conduct-score')} onClick={() => setPage('conduct-score')}>Kết quả rèn luyện</div>
          <div className={cls('scholarships')} onClick={() => setPage('scholarships')}>Mức học bổng được xét</div>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.dkhp ? 'open' : ''}`} onClick={() => toggle('dkhp')}>
          <span>✅ ĐĂNG KÝ HỌC PHẦN</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.dkhp ? 'open' : ''}`}>
          <div className={cls('curriculum')} onClick={() => setPage('curriculum')}>Chương trình khung</div>
          <div className={cls('course-registration')} onClick={() => setPage('course-registration')}>Đăng ký học phần</div>
          <div className={cls('prerequisite-registration')} onClick={() => setPage('prerequisite-registration')}>Đăng ký môn học điều kiện</div>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.hocphi ? 'open' : ''}`} onClick={() => toggle('hocphi')}>
          <span>💳 HỌC PHÍ</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.hocphi ? 'open' : ''}`}>
          <div className={cls('tuition-fee')} onClick={() => setPage('tuition-fee')}>Tra cứu công nợ</div>
          <div className={cls('online-payment')} onClick={() => setPage('online-payment')}>Thanh toán trực tuyến</div>
          <div className={cls('dormitory-payment')} onClick={() => setPage('dormitory-payment')}>Thanh toán nội trú</div>
          <div className={cls('general-receipts')} onClick={() => setPage('general-receipts')}>Phiếu thu tổng hợp</div>
          <div className={cls('online-receipts')} onClick={() => setPage('online-receipts')}>Phiếu thu trực tuyến</div>
        </div>
      </div>

      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.khac ? 'open' : ''}`} onClick={() => toggle('khac')}>
          <span>⚙ KHÁC</span><span className="caret">▾</span>
        </div>
        <div className={`sub-menu ${open.khac ? 'open' : ''}`}>
          <div className={cls('change-password')} onClick={() => setPage('change-password')}>Đổi mật khẩu</div>
          <div className={cls('student-mailbox')} onClick={() => setPage('student-mailbox')}>Hộp thư sinh viên</div>
        </div>
      </div>
    </aside>
  );
}