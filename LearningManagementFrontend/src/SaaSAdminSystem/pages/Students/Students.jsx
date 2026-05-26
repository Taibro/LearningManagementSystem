import React from 'react';

export default function Students() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Sinh viên</h1></div>
        <button className="btn btn-primary">+ Thêm sinh viên</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>MSSV</th><th>Sinh viên</th><th>Khoa</th><th>Chuyên ngành</th><th>Lớp hành chính</th><th>Năm nhập học</th><th>Lớp đăng ký</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr>
              <td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>21IT001</td>
              <td><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><div className="avatar" style={{ width: '28px', height: '28px', fontSize: '11px', background: 'linear-gradient(135deg,#25d97e,#22d4e8)' }}>PD</div><div><div style={{ fontWeight: 600 }}>Phạm Văn Đức</div><div style={{ fontSize: '10px', color: 'var(--muted)' }}>duc.pham@student.hcmut.edu.vn</div></div></div></td>
              <td>CNTT</td><td style={{ fontSize: '11px' }}>Kỹ thuật phần mềm</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>CNTT21A</td>
              <td style={{ fontFamily: "'DM Mono',monospace" }}>2021</td><td><span className="badge badge-blue">INT101</span></td>
              <td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Xem</button><button className="btn btn-ghost btn-xs">Sửa</button></div></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}