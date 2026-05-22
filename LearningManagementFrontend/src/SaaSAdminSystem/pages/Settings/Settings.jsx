import React from 'react';

export default function Settings() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '24px' }}>Cài đặt hệ thống</h1>
      <div className="grid-2">
        <div className="card">
          <div className="card-header"><div className="card-title">Thông tin hệ thống</div></div>
          <div className="card-body">
            <div className="form-group"><label className="form-label">Tên hệ thống</label><input className="form-ctrl" defaultValue="HUIT – Hệ thống Quản lý Lớp học" /></div>
            <div className="form-group"><label className="form-label">Phiên bản</label><input className="form-ctrl" defaultValue="v2.4.1 (Multi-tenant)" readOnly /></div>
            <div className="form-group"><label className="form-label">Email liên hệ hỗ trợ</label><input className="form-ctrl" defaultValue="admin@huit.edu.vn" /></div>
            <button className="btn btn-primary">Lưu thay đổi</button>
          </div>
        </div>
        <div className="card">
          <div className="card-header"><div className="card-title">Bảo mật & Phiên</div></div>
          <div className="card-body">
            <div className="form-group"><label className="form-label">Thời gian phiên (phút)</label><input type="number" className="form-ctrl" defaultValue="60" /></div>
            <div className="form-group"><label className="form-label">Số lần đăng nhập sai tối đa</label><input type="number" class="form-ctrl" defaultValue="5" /></div>
            <div className="form-group"><label className="form-label">Yêu cầu 2FA</label><select className="form-ctrl"><option>Không bắt buộc</option><option>Bắt buộc với Admin</option></select></div>
            <button className="btn btn-primary">Cập nhật bảo mật</button>
          </div>
        </div>
      </div>
    </div>
  );
}