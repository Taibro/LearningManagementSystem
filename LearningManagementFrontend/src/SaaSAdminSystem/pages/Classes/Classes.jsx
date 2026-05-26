import React, { useState } from 'react';

export default function Classes() {
  const [cModal, setCModal] = useState(false);
  const [aModal, setAModal] = useState(false);

  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Quản lý Lớp học</h1><p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Phân công giảng viên · Xem sĩ số · Đổi trạng thái</p></div>
        <button className="btn btn-primary" onClick={() => setCModal(true)}>+ Tạo lớp học</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>Mã lớp</th><th>Môn học</th><th>Học kỳ</th><th>Cơ sở</th><th>Giảng viên</th><th>Sĩ số / Max</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr>
              <td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>INT101-01-HK1-2425</td>
              <td>Nhập môn Lập trình</td><td>HK1 - 2024-2025</td><td>CS1 - HCMUT</td>
              <td><div style={{ display: 'flex', flexDirection: 'column', gap: '2px' }}><span className="badge badge-purple" style={{ fontSize: '9px' }}>main: Nguyễn Văn An</span></div></td>
              <td style={{ fontFamily: "'DM Mono',monospace" }}><span style={{ color: 'var(--green)' }}>2</span>/40</td>
              <td><span className="badge badge-blue">IN_PROGRESS</span></td>
              <td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-ghost btn-xs" onClick={() => setAModal(true)}>Phân công GV</button></div></td>
            </tr>
          </tbody>
        </table>
      </div>

      {/* Tạo lớp Modal */}
      {cModal && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Tạo Lớp học mới</span><button onClick={() => setCModal(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="form-group"><label className="form-label">Mã lớp</label><input className="form-ctrl" placeholder="INT101-01-HK1-2425" /></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Môn học</label><select className="form-ctrl"><option>INT101 - Nhập môn Lập trình</option></select></div><div className="form-group"><label className="form-label">Học kỳ</label><select className="form-ctrl"><option>HK1 - 2024-2025</option></select></div></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Cơ sở</label><select className="form-ctrl"><option>CS1 - HCMUT</option></select></div><div className="form-group"><label className="form-label">Sĩ số tối đa</label><input type="number" className="form-ctrl" defaultValue="40" /></div></div>
              <div className="form-group"><label className="form-label">Trạng thái</label><select className="form-ctrl"><option>OPEN</option><option>IN_PROGRESS</option></select></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setCModal(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setCModal(false)}>Tạo lớp</button></div>
          </div>
        </div>
      )}

      {/* Phân công GV Modal */}
      {aModal && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Phân công Giảng viên</span><button onClick={() => setAModal(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="form-group"><label className="form-label">Lớp học</label><select className="form-ctrl"><option>INT101-01-HK1-2425</option></select></div>
              <div className="form-group"><label className="form-label">Giảng viên</label><select className="form-ctrl"><option>GV001 - Nguyễn Văn An</option></select></div>
              <div className="form-group"><label className="form-label">Vai trò trong lớp</label><select className="form-ctrl"><option>main – Dạy chính</option></select></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setAModal(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setAModal(false)}>Lưu phân công</button></div>
          </div>
        </div>
      )}
    </div>
  );
}