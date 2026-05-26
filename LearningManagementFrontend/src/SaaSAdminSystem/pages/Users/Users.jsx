import React, { useState } from 'react';

export default function Users() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Tài khoản</h1><p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Tất cả người dùng trong hệ thống (Global)</p></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Tạo tài khoản</button>
      </div>
      <div className="card">
        <div style={{ padding: '14px 20px', borderBottom: '1px solid var(--border)', display: 'flex', gap: '10px', flexWrap: 'wrap' }}>
          <input className="form-ctrl" style={{ maxWidth: '280px' }} placeholder="🔍 Họ tên, email..." />
          <select className="form-ctrl" style={{ maxWidth: '140px' }}><option>Tất cả vai trò</option><option>admin</option><option>teacher</option><option>student</option></select>
          <select className="form-ctrl" style={{ maxWidth: '160px' }}><option>Tất cả trường</option><option>HCMUT</option><option>IELTS Pro</option></select>
        </div>
        <table className="data-table">
          <thead><tr><th>ID</th><th>Họ tên</th><th>Email</th><th>SĐT</th><th>Giới tính</th><th>Vai trò</th><th>Trường</th><th>Đăng nhập cuối</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><div className="avatar" style={{ width: '26px', height: '26px', fontSize: '10px' }}>NA</div>Nguyễn Văn An</div></td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>an.nguyen@hcmut.edu.vn</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>0901234561</td><td>Nam</td><td><span className="badge badge-purple">teacher</span></td><td>HCMUT</td><td style={{ fontSize: '10px', color: 'var(--muted)', fontFamily: "'DM Mono',monospace" }}>—</td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Khóa</button></div></td></tr>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>2</td><td><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><div className="avatar" style={{ width: '26px', height: '26px', fontSize: '10px', background: 'linear-gradient(135deg,#ec4899,#f97316)' }}>TB</div>Trần Thị Bích</div></td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>bich.tran@hcmut.edu.vn</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>0901234562</td><td>Nữ</td><td><span className="badge badge-purple">teacher</span></td><td>HCMUT</td><td style={{ fontSize: '10px', color: 'var(--muted)', fontFamily: "'DM Mono',monospace" }}>—</td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Khóa</button></div></td></tr>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>3</td><td><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><div className="avatar" style={{ width: '26px', height: '26px', fontSize: '10px', background: 'linear-gradient(135deg,#22d4e8,#3b7eff)' }}>LC</div>Lê Minh Cường</div></td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>cuong.le@ieltspro.vn</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>0901234563</td><td>Nam</td><td><span className="badge badge-purple">teacher</span></td><td>IELTS Pro</td><td style={{ fontSize: '10px', color: 'var(--muted)', fontFamily: "'DM Mono',monospace" }}>—</td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Khóa</button></div></td></tr>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>4</td><td><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><div className="avatar" style={{ width: '26px', height: '26px', fontSize: '10px', background: 'linear-gradient(135deg,#25d97e,#22d4e8)' }}>PD</div>Phạm Văn Đức</div></td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>duc.pham@student.hcmut.edu.vn</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>0912345671</td><td>Nam</td><td><span className="badge badge-cyan">student</span></td><td>HCMUT</td><td style={{ fontSize: '10px', color: 'var(--muted)', fontFamily: "'DM Mono',monospace" }}>—</td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Khóa</button></div></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Tạo Tài khoản mới</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="grid-2"><div className="form-group"><label className="form-label">Họ và tên</label><input className="form-ctrl" placeholder="Nguyễn Văn A" /></div><div className="form-group"><label className="form-label">Giới tính</label><select className="form-ctrl"><option>Nam</option><option>Nữ</option></select></div></div>
              <div className="form-group"><label className="form-label">Email</label><input className="form-ctrl" type="email" placeholder="user@huit.edu.vn" /></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Mật khẩu</label><input className="form-ctrl" type="password" placeholder="••••••••" /></div><div className="form-group"><label className="form-label">Số điện thoại</label><input className="form-ctrl" placeholder="09xxxxxxxx" /></div></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Ngày sinh</label><input type="date" className="form-ctrl" /></div><div className="form-group"><label className="form-label">Vai trò</label><select className="form-ctrl"><option>student</option><option>teacher</option><option>admin</option></select></div></div>
              <div className="form-group"><label className="form-label">Trường / Tổ chức</label><select className="form-ctrl"><option>HCMUT</option><option>IELTS Pro</option></select></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setModalOpen(false)}>Tạo tài khoản</button></div>
          </div>
        </div>
      )}
    </div>
  );
}