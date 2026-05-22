import React from 'react';
import { useNavigate } from 'react-router-dom';

export default function Dashboard() {
  const navigate = useNavigate();

  return (
    <div>
      <div style={{ marginBottom: '24px' }}>
        <h1 style={{ fontSize: '22px', fontWeight: 800, color: 'var(--text)' }}>Tổng quan hệ thống</h1>
        <p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Dữ liệu cập nhật lúc 22/04/2026 14:30 · HK2 (2024-2025) đang hoạt động</p>
      </div>

      <div className="grid-6 mb-6">
        <div className="stat-card blue" onClick={() => navigate('/saas/schools')}>
          <div className="stat-icon">🏫</div><div className="stat-label">Trường học</div><div className="stat-num">2</div><div className="stat-change up">↑ 1 mới tháng này</div>
        </div>
        <div className="stat-card cyan" onClick={() => navigate('/saas/students')}>
          <div className="stat-icon">👨‍🎓</div><div className="stat-label">Sinh viên</div><div className="stat-num">3</div><div className="stat-change up">↑ 2 đăng ký mới</div>
        </div>
        <div className="stat-card green" onClick={() => navigate('/saas/teachers')}>
          <div className="stat-icon">👨‍🏫</div><div className="stat-label">Giảng viên</div><div className="stat-num">3</div><div className="stat-change up">↑ 100% active</div>
        </div>
        <div className="stat-card amber" onClick={() => navigate('/saas/classes')}>
          <div className="stat-icon">🎓</div><div className="stat-label">Lớp học</div><div className="stat-num">3</div><div className="stat-change up">↑ 2 in_progress</div>
        </div>
        <div className="stat-card purple" onClick={() => navigate('/saas/invoices')}>
          <div className="stat-icon">💰</div><div className="stat-label">Học phí (HK)</div><div className="stat-num">0đ</div><div className="stat-change down">↓ Chưa có hóa đơn</div>
        </div>
        <div className="stat-card red" onClick={() => navigate('/saas/attendance')}>
          <div className="stat-icon">📋</div><div className="stat-label">Vắng mặt</div><div className="stat-num">2</div><div className="stat-change down">↓ Tuần này</div>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 320px', gap: '16px', marginBottom: '16px' }}>
        <div className="card">
          <div className="card-header">
            <div><div className="card-title">Điểm danh tháng 9/2024</div><div className="card-sub">Lớp INT101-01-HK1-2425</div></div>
            <div className="tabs" style={{ transform: 'scale(.85)', transformOrigin: 'right' }}><div className="tab active">Tuần</div><div className="tab">Tháng</div></div>
          </div>
          <div className="card-body">
            <div style={{ display: 'flex', gap: '20px', marginBottom: '20px' }}>
              <div><div style={{ fontFamily: "'DM Mono',monospace", fontSize: '28px', fontWeight: 500, color: 'var(--green)' }}>75%</div><div style={{ fontSize: '11px', color: 'var(--muted)' }}>Tỉ lệ có mặt</div></div>
              <div><div style={{ fontFamily: "'DM Mono',monospace", fontSize: '28px', fontWeight: 500, color: 'var(--amber)' }}>1</div><div style={{ fontSize: '11px', color: 'var(--muted)' }}>Đi trễ</div></div>
              <div><div style={{ fontFamily: "'DM Mono',monospace", fontSize: '28px', fontWeight: 500, color: 'var(--red)' }}>1</div><div style={{ fontSize: '11px', color: 'var(--muted)' }}>Vắng</div></div>
            </div>
            <div style={{ display: 'flex', alignItems: 'flex-end', gap: '4px', height: '80px' }}>
              <div style={{ flex: 1, background: 'var(--green)', opacity: .7, borderRadius: '4px 4px 0 0', height: '90%', display: 'flex', alignItems: 'flex-start', paddingTop: '4px', justifyContent: 'center', fontSize: '9px', color: 'white', fontWeight: 700 }}>09/9</div>
              <div style={{ flex: 1, background: 'var(--amber)', opacity: .7, borderRadius: '4px 4px 0 0', height: '60%' }}></div>
              <div style={{ flex: 1, background: 'var(--blue)', opacity: .3, borderRadius: '4px 4px 0 0', height: '30%' }}></div>
              <div style={{ flex: 1, background: 'var(--blue)', opacity: .3, borderRadius: '4px 4px 0 0', height: '30%' }}></div>
              <div style={{ flex: 1, background: 'var(--blue)', opacity: .3, borderRadius: '4px 4px 0 0', height: '30%' }}></div>
            </div>
            <div style={{ display: 'flex', gap: '16px', marginTop: '12px', fontSize: '10px', color: 'var(--muted)' }}><span>🟢 Có mặt</span><span>🟡 Trễ</span><span>🔴 Vắng</span><span>⬜ Chưa học</span></div>
          </div>
        </div>

        <div className="card">
          <div className="card-header">
            <div><div className="card-title">Tình trạng đăng ký học phần</div><div className="card-sub">HK1 2024-2025</div></div>
            <button className="btn btn-ghost btn-sm" onClick={() => navigate('/saas/enrollments')}>Xem tất cả →</button>
          </div>
          <div className="card-body">
            <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '16px' }}>
              <div className="ring-wrap">
                <svg width="110" height="110" viewBox="0 0 110 110">
                  <circle cx="55" cy="55" r="40" fill="none" stroke="var(--border)" strokeWidth="12" />
                  <circle cx="55" cy="55" r="40" fill="none" stroke="var(--green)" strokeWidth="12" strokeDasharray="200 52" strokeLinecap="round" transform="rotate(-90 55 55)" />
                  <circle cx="55" cy="55" r="40" fill="none" stroke="var(--amber)" strokeWidth="12" strokeDasharray="0 252" strokeLinecap="round" transform="rotate(-90 55 55)" />
                </svg>
                <div className="ring-label">
                  <div style={{ fontFamily: "'DM Mono',monospace", fontSize: '20px', fontWeight: 500, color: 'var(--text)' }}>5</div><div style={{ fontSize: '9px', color: 'var(--muted)' }}>Tổng</div>
                </div>
              </div>
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
              <div>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '11px' }}><span style={{ color: 'var(--muted2)' }}>Enrolled</span><span style={{ fontFamily: "'DM Mono',monospace", color: 'var(--green)' }}>5 (100%)</span></div>
                <div className="prog-track"><div className="prog-fill" style={{ width: '100%', background: 'var(--green)' }}></div></div>
              </div>
              <div>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '11px' }}><span style={{ color: 'var(--muted2)' }}>Pending</span><span style={{ fontFamily: "'DM Mono',monospace", color: 'var(--amber)' }}>0 (0%)</span></div>
                <div className="prog-track"><div className="prog-fill" style={{ width: '0%', background: 'var(--amber)' }}></div></div>
              </div>
              <div>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '11px' }}><span style={{ color: 'var(--muted2)' }}>Dropped</span><span style={{ fontFamily: "'DM Mono',monospace", color: 'var(--red)' }}>0 (0%)</span></div>
                <div className="prog-track"><div className="prog-fill" style={{ width: '0%', background: 'var(--red)' }}></div></div>
              </div>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="card-header"><div className="card-title">Hoạt động gần đây</div></div>
          <div style={{ padding: '0 20px', maxHeight: '280px', overflowY: 'auto' }}>
            <div className="feed-item"><div className="feed-dot" style={{ background: 'var(--green)' }}></div><div><div style={{ fontSize: '12px', color: 'var(--text)' }}>Sinh viên <strong>Phạm Văn Đức</strong> đăng ký lớp INT101</div><div className="feed-time">09/09/2024 07:00</div></div></div>
            <div className="feed-item"><div className="feed-dot" style={{ background: 'var(--amber)' }}></div><div><div style={{ fontSize: '12px', color: 'var(--text)' }}>Ngoại lệ lịch học ngày <strong>02/09/2024</strong> – Nghỉ Quốc khánh</div><div className="feed-time">01/09/2024 10:15</div></div></div>
            <div className="feed-item"><div className="feed-dot" style={{ background: 'var(--blue)' }}></div><div><div style={{ fontSize: '12px', color: 'var(--text)' }}>Thêm phòng học mới <strong>B-301</strong> (Hội trường, 80 chỗ)</div><div className="feed-time">30/08/2024 14:30</div></div></div>
            <div className="feed-item"><div className="feed-dot" style={{ background: 'var(--purple)' }}></div><div><div style={{ fontSize: '12px', color: 'var(--text)' }}>Tạo lớp <strong>IEL101-Q1-T9-2024</strong> – IELTS Foundation</div><div className="feed-time">28/08/2024 09:00</div></div></div>
            <div className="feed-item"><div className="feed-dot" style={{ background: 'var(--cyan)' }}></div><div><div style={{ fontSize: '12px', color: 'var(--text)' }}>Tài khoản mới: <strong>Vũ Quốc Hùng</strong> – SV IELTS Pro</div><div className="feed-time">25/08/2024 16:45</div></div></div>
          </div>
        </div>
      </div>

      <div className="grid-2">
        <div className="card">
          <div className="card-header"><div className="card-title">Danh sách lớp học đang hoạt động</div></div>
          <table className="data-table">
            <thead><tr><th>Mã lớp</th><th>Môn học</th><th>Giảng viên</th><th>Sĩ số</th><th>Trạng thái</th></tr></thead>
            <tbody>
              <tr><td><span style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>INT101-01</span></td><td>Nhập môn Lập trình</td><td>Nguyễn Văn An</td><td><span style={{ fontFamily: "'DM Mono',monospace" }}>2/40</span></td><td><span className="badge badge-blue">in_progress</span></td></tr>
              <tr><td><span style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>INT201-01</span></td><td>CTDL & Giải thuật</td><td>Trần Thị Bích</td><td><span style={{ fontFamily: "'DM Mono',monospace" }}>2/35</span></td><td><span className="badge badge-blue">in_progress</span></td></tr>
              <tr><td><span style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>IEL101-Q1</span></td><td>IELTS Foundation</td><td>Lê Minh Cường</td><td><span style={{ fontFamily: "'DM Mono',monospace" }}>1/20</span></td><td><span className="badge badge-green">open</span></td></tr>
            </tbody>
          </table>
        </div>
        <div className="card">
          <div className="card-header"><div className="card-title">Phòng học</div><button className="btn btn-ghost btn-sm" onClick={() => navigate('/saas/rooms')}>Xem tất cả →</button></div>
          <table className="data-table">
            <thead><tr><th>Phòng</th><th>Loại</th><th>Sức chứa</th><th>Cơ sở</th><th>Trạng thái</th></tr></thead>
            <tbody>
              <tr><td style={{ fontFamily: "'DM Mono',monospace" }}>A-101</td><td>Classroom</td><td>50</td><td>CS1 - BK</td><td><span className="badge badge-green">Active</span></td></tr>
              <tr><td style={{ fontFamily: "'DM Mono',monospace" }}>B-102</td><td>Lab</td><td>30</td><td>CS1 - BK</td><td><span class="badge badge-green">Active</span></td></tr>
              <tr><td style={{ fontFamily: "'DM Mono',monospace" }}>B-301</td><td>Lecture Hall</td><td>80</td><td>CS1 - BK</td><td><span class="badge badge-green">Active</span></td></tr>
              <tr><td style={{ fontFamily: "'DM Mono',monospace" }}>C-201</td><td>Classroom</td><td>40</td><td>CS2 - BK</td><td><span class="badge badge-green">Active</span></td></tr>
              <tr><td style={{ fontFamily: "'DM Mono',monospace" }}>A-001</td><td>Seminar</td><td>20</td><td>IELTS Q1</td><td><span class="badge badge-green">Active</span></td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}