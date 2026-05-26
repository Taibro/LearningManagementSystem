import React, { useState } from 'react';

export default function Enrollments() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Đăng ký học phần</h1></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Đăng ký thủ công</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>#</th><th>Sinh viên</th><th>Lớp học</th><th>Môn học</th><th>Ngày đăng ký</th><th>Trạng thái</th><th>Điểm GK</th><th>Điểm CK</th><th>Điểm TK</th><th>Xếp loại</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td>Phạm Văn Đức</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>INT101-01</td><td>Nhập môn Lập trình</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px' }}>09/09/2024</td><td><span className="badge badge-green">ENROLLED</span></td><td>—</td><td>—</td><td>—</td><td>—</td><td><button className="btn btn-ghost btn-xs">Nhập điểm</button></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal" style={{ width: '460px' }}>
            <div className="modal-header"><span className="modal-title">Đăng ký học phần thủ công</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="form-group"><label className="form-label">Sinh viên</label><select className="form-ctrl"><option>21IT001 - Phạm Văn Đức</option></select></div>
              <div className="form-group"><label className="form-label">Lớp học phần</label><select className="form-ctrl"><option>INT101-01 - Nhập môn LP</option></select></div>
              <div className="form-group"><label className="form-label">Trạng thái</label><select className="form-ctrl"><option>ENROLLED</option></select></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-success" onClick={() => setModalOpen(false)}>Đăng ký</button></div>
          </div>
        </div>
      )}
    </div>
  );
}