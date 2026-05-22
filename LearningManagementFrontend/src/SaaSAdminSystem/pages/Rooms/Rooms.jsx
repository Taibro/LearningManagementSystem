import React from 'react';

export default function Rooms() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Phòng học</h1></div>
        <button className="btn btn-primary">+ Thêm phòng</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>ID</th><th>Số phòng</th><th>Tòa nhà</th><th>Cơ sở</th><th>Loại phòng</th><th>Sức chứa</th><th>Trang thiết bị</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td style={{ fontFamily: "'DM Mono',monospace", fontWeight: 600, color: 'var(--text)' }}>A-101</td><td>A</td><td>CS1 - HCMUT</td><td><span className="badge badge-blue">Classroom</span></td><td style={{ fontFamily: "'DM Mono',monospace" }}>50</td><td><div style={{ display: 'flex', gap: '4px', flexWrap: 'wrap' }}><span className="badge badge-gray">projector</span><span className="badge badge-gray">ac</span></div></td><td><span className="badge badge-green">Active</span></td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}