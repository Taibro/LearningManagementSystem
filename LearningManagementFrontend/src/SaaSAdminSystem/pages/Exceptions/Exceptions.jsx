import React, { useState } from 'react';

export default function Exceptions() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div><h1 style={{ fontSize: '20px', fontWeight: 800 }}>Ngoại lệ Lịch học</h1><p style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>Nghỉ lễ, dời lịch, đổi phòng</p></div>
        <button className="btn btn-primary" onClick={() => setModalOpen(true)}>+ Thêm ngoại lệ</button>
      </div>
      <div className="card">
        <table className="data-table">
          <thead><tr><th>#</th><th>Ca học</th><th>Ngày ngoại lệ</th><th>Lý do</th><th>Loại</th><th>Ngày thay thế</th><th>Phòng thay thế</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{ fontFamily: "'DM Mono',monospace", color: 'var(--muted)' }}>1</td><td style={{ fontFamily: "'DM Mono',monospace", fontSize: '11px', color: 'var(--cyan)' }}>Sch#1 (INT101 T2)</td><td style={{ fontFamily: "'DM Mono',monospace" }}>02/09/2024</td><td>Nghỉ Quốc khánh 2/9</td><td><span className="badge badge-amber">RESCHEDULED</span></td><td style={{ fontFamily: "'DM Mono',monospace" }}>07/09/2024</td><td>—</td><td><div style={{ display: 'flex', gap: '4px' }}><button className="btn btn-ghost btn-xs">Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="modal-header"><span className="modal-title">Thêm Ngoại lệ Lịch học</span><button onClick={() => setModalOpen(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', fontSize: '20px', cursor: 'pointer' }}>×</button></div>
            <div className="modal-body">
              <div className="form-group"><label className="form-label">Ca học</label><select className="form-ctrl"><option>Sch#1 - INT101 (Thứ 2)</option></select></div>
              <div className="form-group"><label className="form-label">Ngày ngoại lệ</label><input type="date" className="form-ctrl" /></div>
              <div className="form-group"><label className="form-label">Lý do</label><input className="form-ctrl" placeholder="Nghỉ Quốc khánh, GV bệnh..." /></div>
              <div className="form-group"><label className="form-label">Loại ngoại lệ</label><select className="form-ctrl"><option>rescheduled – Dời lịch</option></select></div>
              <div className="grid-2"><div className="form-group"><label className="form-label">Ngày thay thế</label><input type="date" className="form-ctrl" /></div><div className="form-group"><label className="form-label">Phòng thay thế</label><select className="form-ctrl"><option>—</option></select></div></div>
            </div>
            <div className="modal-footer"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-primary" onClick={() => setModalOpen(false)}>Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}