import React from 'react';

export default function Attendance() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Điểm danh</h1></div>
        <div style={{ display: 'flex', gap: '8px' }}><select className="form-ctrl" style={{ maxWidth: '200px' }}><option>INT101-01 - HK1 2024</option></select><input type="date" className="form-ctrl" style={{ maxWidth: '160px' }} defaultValue="2024-09-09" /></div>
      </div>
      <div className="grid-4 mb-4">
        <div className="stat-card green"><div className="stat-label">Có mặt</div><div className="stat-num">2</div></div>
        <div className="stat-card amber"><div className="stat-label">Đi trễ</div><div className="stat-num">1</div></div>
        <div className="stat-card red"><div className="stat-label">Vắng</div><div className="stat-num">1</div></div>
        <div className="stat-card blue"><div className="stat-label">Tổng buổi điểm danh</div><div className="stat-num">4</div></div>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>Ca học (ID)</th><th>Sinh viên</th><th>Ngày điểm danh</th><th>Trạng thái</th><th>Ghi chú</th><th>Người điểm danh</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>Sch#1</td><td>Phạm Văn Đức</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>09/09/2024</td><td><span className="badge badge-green">PRESENT</span></td><td>—</td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>Nguyễn Văn An</td><td><button className="btn btn-ghost btn-xs">Sửa</button></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}