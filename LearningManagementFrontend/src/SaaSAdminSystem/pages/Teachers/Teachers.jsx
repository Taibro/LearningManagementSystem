import React from 'react';

export default function Teachers() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Giảng viên</h1></div>
        <button className="btn btn-primary">+ Thêm giảng viên</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>Mã GV</th><th>Giảng viên</th><th>Khoa</th><th>Học vị</th><th>Chuyên ngành</th><th>Ngày vào</th><th>Lớp đang dạy</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr>
              <td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>GV001</td>
              <td><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><div className="avatar" style={{ width: '28px', height: '28px', fontSize: '11px' }}>NA</div><div><div style={{ fontWeight: 600 }}>Nguyễn Văn An</div><div style={{ fontSize: '10px', color: 'var(--muted)' }}>an.nguyen@hcmut.edu.vn</div></div></div></td>
              <td>Công nghệ Thông tin</td><td><span className="badge badge-purple">Tiến sĩ</span></td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>Trí tuệ nhân tạo</td>
              <td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>01/08/2018</td><td><span className="badge badge-blue">INT101</span></td>
              <td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Xem</button><button className="btn btn-ghost btn-xs">Sửa</button></div></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}