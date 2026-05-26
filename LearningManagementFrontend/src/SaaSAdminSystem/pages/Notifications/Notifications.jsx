import React, { useState } from 'react';

export default function Notifications() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Thông báo</h1></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Gửi thông báo</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>#</th><th>Người nhận</th><th>Tiêu đề</th><th>Loại</th><th>Đã đọc</th><th>Thời gian</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td>Phạm Văn Đức</td><td>Lịch học INT101 thay đổi</td><td><span className="badge badge-amber">SCHEDULE_CHANGE</span></td><td><span className="badge badge-red">Chưa đọc</span></td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '10px' }}>09/09/2024 08:00</td><td><button className="btn btn-danger btn-xs">Xóa</button></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Gửi Thông báo</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="form-group"><label className="form-label">Người nhận</label><select className="form-ctrl"><option>Tất cả sinh viên</option></select></div>
              <div className="form-group"><label className="form-label">Loại thông báo</label><select className="form-ctrl"><option>SCHEDULE_CHANGE</option></select></div>
              <div className="form-group"><label className="form-label">Tiêu đề</label><input className="form-ctrl" placeholder="Thông báo lịch học thay đổi..." /></div>
              <div className="form-group"><label className="form-label">Nội dung</label><textarea className="form-ctrl" rows="4" placeholder="Nội dung thông báo chi tiết..."></textarea></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setModalOpen(false)}>Gửi</button></div>
          </div>
        </div>
      )}
    </div>
  );
}