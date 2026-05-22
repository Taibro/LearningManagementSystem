import React from 'react';

export default function Courses() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Môn học</h1></div>
        <button className="btn btn-primary">+ Thêm môn học</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>Mã môn</th><th>Tên môn học</th><th>Số TC</th><th>Tổng buổi</th><th>Khoa</th><th>Môn tiên quyết</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>INT101</td><td style={{ fontWeight: 600 }}>Nhập môn Lập trình</td><td style={{ fontFamily: "'DM Mono',monospace" }}>3</td><td style={{ fontFamily: "'DM Mono',monospace" }}>30</td><td>CNTT</td><td style={{ color: 'var(--muted)' }}>—</td><td><span className="badge badge-green">Active</span></td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}