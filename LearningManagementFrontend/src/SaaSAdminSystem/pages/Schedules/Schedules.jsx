import React, { useState } from 'react';

export default function Schedules() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Lịch học</h1><p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Tất cả ca học theo tuần + ngoại lệ</p></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Tạo lịch học</button>
      </div>
      <div className="card mb-4">
        <table className="data-table">
          <thead><tr><th>ID</th><th>Lớp</th><th>Phòng</th><th>Thứ</th><th>Giờ bắt đầu</th><th>Giờ kết thúc</th><th>Từ ngày</th><th>Đến ngày</th><th>Loại</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>INT101-01</td><td>A-101</td><td>Thứ 2</td><td style={{ fontFamily: "'DM Mono',monospace" }}>07:30</td><td style={{ fontFamily: "'DM Mono',monospace" }}>09:30</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>09/09/2024</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>20/12/2024</td><td><span className="badge badge-blue">REGULAR</span></td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Tạo Lịch học</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="grid-2"><div className="form-group"><label className="form-label">Lớp học</label><select className="form-ctrl"><option>INT101-01</option></select></div><div className="form-group"><label className="form-label">Phòng học</label><select className="form-ctrl"><option>A-101 (50 chỗ)</option></select></div></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Thứ trong tuần</label><select className="form-ctrl"><option value="2">Thứ 2</option></select></div><div className="form-group"><label className="form-label">Loại buổi học</label><select className="form-ctrl"><option>REGULAR</option></select></div></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Giờ bắt đầu</label><input type="time" className="form-ctrl" defaultValue="07:30" /></div><div className="form-group"><label className="form-label">Giờ kết thúc</label><input type="time" className="form-ctrl" defaultValue="09:30" /></div></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setModalOpen(false)}>Tạo lịch</button></div>
          </div>
        </div>
      )}
    </div>
  );
}