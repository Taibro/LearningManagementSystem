import React, { useState } from 'react';

export default function Exceptions() {
  const [eModal, setEModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Ngoại lệ lịch học</div><div className="ph-sub">Nghỉ lễ · Dời lịch · Đổi phòng</div></div>
        <button className="btn btn-blue" onClick={() => setEModal(true)}>+ Thêm ngoại lệ</button>
      </div>
      <div className="card">
        <table className="tbl">
          <thead><tr><th>#</th><th>Ca học</th><th>Ngày NL</th><th>Lý do</th><th>Loại</th><th>Ngày thay thế</th><th>Phòng thay thế</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{color:'var(--muted)'}}>1</td><td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>Sch#1 · INT101 (Thứ 2)</td><td style={{fontWeight:700}}>02/09/2024</td><td>Nghỉ Quốc khánh 2/9</td><td><span className="badge b-amber">RESCHEDULED</span></td><td>07/09/2024</td><td>—</td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setEModal(true)}>Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
          </tbody>
        </table>
      </div>

      {eModal && (
        <div className="ov open">
          <div className="modal" style={{width:'500px'}}>
            <div className="modal-hd"><span className="modal-title">⚠️ Thêm Ngoại lệ Lịch học</span><button className="close-btn" onClick={() => setEModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="fg"><label className="fl">Ca học</label><select className="fc"><option>Sch#1 – INT101 (Thứ 2 · 07:30)</option><option>Sch#2 – INT101 (Thứ 4 · 13:30)</option><option>Sch#3 – INT201 (Thứ 3 · 09:45)</option><option>Sch#4 – IEL101 (Thứ 7 · 08:00)</option></select></div>
              <div className="fg"><label className="fl">Ngày ngoại lệ</label><input type="date" className="fc" /></div>
              <div className="fg"><label className="fl">Lý do</label><input className="fc" placeholder="Nghỉ Quốc khánh, GV ốm, Sự kiện..." /></div>
              <div className="fg"><label className="fl">Loại ngoại lệ</label><select className="fc"><option>cancelled – Hủy buổi học</option><option>rescheduled – Dời sang ngày khác</option><option>room_change – Đổi phòng học</option></select></div>
              <div className="grid2"><div className="fg"><label className="fl">Ngày dạy bù (nếu có)</label><input type="date" className="fc" /></div><div className="fg"><label className="fl">Phòng thay thế</label><select className="fc"><option>— Giữ nguyên —</option><option>A-101</option><option>B-102</option><option>B-301</option></select></div></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setEModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setEModal(false)}>💾 Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}