import React, { useState } from 'react';

export default function BranchesRooms() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Cơ sở / Chi nhánh</h1><p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Quản lý các cơ sở học tập thuộc các trường</p></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Thêm cơ sở</button>
      </div>
      <div className="grid-4 mb-6">
        <div className="stat-card blue"><div className="stat-icon">📍</div><div className="stat-label">HCMUT - CS1</div><div style={{ fontSize: '12px', color: 'var(--muted2)', marginTop: '6px' }}>268 Lý Thường Kiệt, Q.10</div><div className="stat-change up">✔ Cơ sở chính</div></div>
        <div className="stat-card cyan"><div className="stat-icon">📍</div><div className="stat-label">HCMUT - CS2</div><div style={{ fontSize: '12px', color: 'var(--muted2)', marginTop: '6px' }}>Khu phố 6, Dĩ An, Bình Dương</div><div className="stat-change" style={{ color: 'var(--muted)' }}>Cơ sở phụ</div></div>
        <div className="stat-card amber"><div className="stat-icon">📍</div><div className="stat-label">IELTS Pro - Q1</div><div style={{ fontSize: '12px', color: 'var(--muted2)', marginTop: '6px' }}>123 Nguyễn Huệ, Q.1</div><div className="stat-change up">✔ Chi nhánh chính</div></div>
        <div className="stat-card green"><div className="stat-icon">📍</div><div className="stat-label">IELTS Pro - Thủ Đức</div><div style={{ fontSize: '12px', color: 'var(--muted2)', marginTop: '6px' }}>456 Võ Văn Ngân, TP.Thủ Đức</div><div className="stat-change" style={{ color: 'var(--muted)' }}>Chi nhánh phụ</div></div>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>#</th><th>Mã CS</th><th>Tên cơ sở</th><th>Trường</th><th>Địa chỉ</th><th>SĐT</th><th>Loại</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>CS1</td><td>Cơ sở 1 - Lý Thường Kiệt</td><td>HCMUT</td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>268 Lý Thường Kiệt, P.14, Q.10, TP.HCM</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>028-3864-7256</td><td><span className="badge badge-green">Chính</span></td><td><button className="btn btn-ghost btn-xs">Sửa</button></td></tr>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>2</td><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>CS2</td><td>Cơ sở 2 - Dĩ An</td><td>HCMUT</td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>Khu phố 6, Dĩ An, Bình Dương</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>0274-372-5540</td><td><span className="badge badge-gray">Phụ</span></td><td><button className="btn btn-ghost btn-xs">Sửa</button></td></tr>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>3</td><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>Q1</td><td>Chi nhánh Quận 1</td><td>IELTS Pro</td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>123 Nguyễn Huệ, P.Bến Nghé, Q.1</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>028-9999-0002</td><td><span className="badge badge-green">Chính</span></td><td><button className="btn btn-ghost btn-xs">Sửa</button></td></tr>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>4</td><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--cyan)' }}>TD</td><td>Chi nhánh Thủ Đức</td><td>IELTS Pro</td><td style={{ fontSize: '11px', color: 'var(--muted2)' }}>456 Võ Văn Ngân, P.Bình Thọ, Thủ Đức</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>028-9999-0003</td><td><span className="badge badge-gray">Phụ</span></td><td><button className="btn btn-ghost btn-xs">Sửa</button></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Thêm Cơ sở mới</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="grid-2"><div className="form-group"><label className="form-label">Trường</label><select className="form-ctrl"><option>HCMUT</option><option>IELTS Pro</option></select></div><div className="form-group"><label className="form-label">Mã cơ sở</label><input className="form-ctrl" placeholder="CS1, Q1, TD..." /></div></div>
              <div className="form-group"><label className="form-label">Tên cơ sở</label><input className="form-ctrl" placeholder="Cơ sở 1 - Lý Thường Kiệt" /></div>
              <div className="form-group"><label className="form-label">Địa chỉ</label><input className="form-ctrl" placeholder="268 Lý Thường Kiệt, P.14, Q.10" /></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Thành phố</label><input className="form-ctrl" placeholder="TP.HCM" /></div><div className="form-group"><label className="form-label">Quận/Huyện</label><input className="form-ctrl" placeholder="Quận 10" /></div></div>
              <div className="form-group"><label className="form-label">Là cơ sở chính?</label><select className="form-ctrl"><option>Không</option><option>Có</option></select></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setModalOpen(false)}>Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}