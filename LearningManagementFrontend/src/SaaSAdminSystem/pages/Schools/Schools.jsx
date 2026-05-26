import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function Schools() {
  const [modalOpen, setModalOpen] = useState(false);
  const navigate = useNavigate();

  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Trường học</h1><p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Danh sách trường / trung tâm đào tạo trong hệ thống</p></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Thêm trường</button>
      </div>
      <div className="card">
        <div style={{ padding: '14px 20px', borderBottom: '1px solid var(--border)', display: 'flex', gap: '10px' }}>
          <input className="form-ctrl" style={{ maxWidth: '280px' }} placeholder="🔍 Tìm theo tên, mã..." />
          <select className="form-ctrl" style={{ maxWidth: '160px' }}><option>Tất cả loại</option><option>UNIVERSITY</option><option>LANGUAGE_CENTER</option></select>
        </div>
        <table className="data-table">
          <thead><tr><th>#</th><th>Mã</th><th>Tên trường</th><th>Loại</th><th>Email</th><th>Điện thoại</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr>
              <td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td>
              <td><span style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>HCMUT</span></td>
              <td><div style={{ fontWeight: 600 }}>Trường ĐH Bách Khoa TP.HCM</div><div style={{ fontSize: '10px', color: 'var(--muted)' }}>BK-HCM · 27/10/1957</div></td>
              <td><span className="badge badge-blue">UNIVERSITY</span></td>
              <td style={{ fontSize: '11px', color: 'var(--muted2)' }}>info@hcmut.edu.vn</td>
              <td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>028-3865-4086</td>
              <td><span className="badge badge-green">Active</span></td>
              <td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-ghost btn-xs" onClick={() => navigate('/saas/branches')}>Cơ sở</button></div></td>
            </tr>
            <tr>
              <td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>2</td>
              <td><span style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>IELTS_PRO</span></td>
              <td><div style={{ fontWeight: 600 }}>Trung tâm Tiếng Anh IELTS Pro</div><div style={{ fontSize: '10px', color: 'var(--muted)' }}>IELTS Pro · 01/06/2015</div></td>
              <td><span className="badge badge-purple">LANGUAGE_CENTER</span></td>
              <td style={{ fontSize: '11px', color: 'var(--muted2)' }}>hi@ieltspro.vn</td>
              <td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>028-9999-0001</td>
              <td><span className="badge badge-green">Active</span></td>
              <td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-ghost btn-xs" onClick={() => navigate('/saas/branches')}>Cơ sở</button></div></td>
            </tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Thêm Trường học mới</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="grid-2"><div className="form-group"><label className="form-label">Mã trường</label><input className="form-ctrl" placeholder="VD: HCMUT" /></div><div className="form-group"><label className="form-label">Tên ngắn</label><input className="form-ctrl" placeholder="VD: BK-HCM" /></div></div>
              <div className="form-group"><label className="form-label">Tên trường (đầy đủ)</label><input className="form-ctrl" placeholder="Trường Đại học Bách Khoa TP.HCM" /></div>
              <div className="form-group"><label className="form-label">Loại hình</label><select className="form-ctrl"><option>UNIVERSITY</option><option>COLLEGE</option><option>LANGUAGE_CENTER</option></select></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Email</label><input className="form-ctrl" placeholder="info@school.edu.vn" /></div><div className="form-group"><label className="form-label">Điện thoại</label><input className="form-ctrl" placeholder="028-..." /></div></div>
              <div className="form-group"><label className="form-label">Website</label><input className="form-ctrl" placeholder="https://..." /></div>
              <div className="form-group"><label className="form-label">Ngày thành lập</label><input type="date" className="form-ctrl" /></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setModalOpen(false)}>Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}