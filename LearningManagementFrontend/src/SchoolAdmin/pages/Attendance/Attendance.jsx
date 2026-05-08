import React, { useState } from 'react';

export default function Attendance() {
  const [aModal, setAModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Quản lý Điểm danh</div><div className="ph-sub">Tra cứu và chỉnh sửa điểm danh theo buổi học</div></div>
      </div>
      <div className="card mb4">
        <div className="filter-bar">
          <select className="fc" style={{maxWidth:'240px'}}><option>INT101-01-HK1-2425</option><option>INT201-01-HK1-2425</option><option>IEL101-Q1-T9-2024</option></select>
          <input type="date" className="fc" style={{maxWidth:'150px'}} defaultValue="2024-09-09" />
          <button className="btn btn-blue btn-sm">🔍 Tìm</button>
          <button className="btn btn-ghost btn-sm">📊 Xuất Excel</button>
        </div>
      </div>

      <div className="grid4 mb4">
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'var(--green)'}}></div><div className="stat-icon">✅</div><div className="stat-label">Có mặt</div><div className="stat-num">2</div></div>
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'var(--amber)'}}></div><div className="stat-icon">⏰</div><div className="stat-label">Đi trễ</div><div className="stat-num">1</div></div>
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'var(--red)'}}></div><div className="stat-icon">❌</div><div className="stat-label">Vắng không phép</div><div className="stat-num">1</div></div>
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'var(--blue-lt)'}}></div><div className="stat-icon">📝</div><div className="stat-label">Tổng bản ghi</div><div className="stat-num">4</div></div>
      </div>

      <div className="card">
        <table className="tbl">
          <thead><tr><th>Ca học</th><th>Sinh viên</th><th>Ngày điểm danh</th><th>Trạng thái</th><th>Ghi chú</th><th>Người điểm danh</th><th>Lúc</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td>Sch#1 · INT101 · T2</td><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-blue" style={{width:'26px', height:'26px', fontSize:'10px'}}>PD</div>Phạm Văn Đức</div></td><td>09/09/2024</td><td><span className="badge b-green">✓ PRESENT</span></td><td>—</td><td style={{fontSize:'11px', color:'var(--muted)'}}>Nguyễn Văn An</td><td style={{fontSize:'11px', color:'var(--muted)'}}>07:31</td><td><button className="btn btn-ghost btn-xs" onClick={() => setAModal(true)}>Sửa</button></td></tr>
            <tr><td>Sch#1 · INT101 · T2</td><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-pink" style={{width:'26px', height:'26px', fontSize:'10px'}}>HL</div>Hoàng Thị Lan</div></td><td>09/09/2024</td><td><span className="badge b-green">✓ PRESENT</span></td><td>—</td><td style={{fontSize:'11px', color:'var(--muted)'}}>Nguyễn Văn An</td><td style={{fontSize:'11px', color:'var(--muted)'}}>07:29</td><td><button className="btn btn-ghost btn-xs" onClick={() => setAModal(true)}>Sửa</button></td></tr>
            <tr><td>Sch#1 · INT101 · T2</td><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-blue" style={{width:'26px', height:'26px', fontSize:'10px'}}>PD</div>Phạm Văn Đức</div></td><td>11/09/2024</td><td><span className="badge b-amber">⏰ LATE</span></td><td>Xe hỏng</td><td style={{fontSize:'11px', color:'var(--muted)'}}>Nguyễn Văn An</td><td style={{fontSize:'11px', color:'var(--muted)'}}>07:52</td><td><button className="btn btn-ghost btn-xs" onClick={() => setAModal(true)}>Sửa</button></td></tr>
            <tr><td>Sch#1 · INT101 · T2</td><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-pink" style={{width:'26px', height:'26px', fontSize:'10px'}}>HL</div>Hoàng Thị Lan</div></td><td>11/09/2024</td><td><span className="badge b-red">✗ ABSENT</span></td><td>—</td><td style={{fontSize:'11px', color:'var(--muted)'}}>Nguyễn Văn An</td><td style={{fontSize:'11px', color:'var(--muted)'}}>—</td><td><button className="btn btn-ghost btn-xs" onClick={() => setAModal(true)}>Sửa</button></td></tr>
          </tbody>
        </table>
      </div>

      {aModal && (
        <div className="ov open">
          <div className="modal" style={{width:'440px'}}>
            <div className="modal-hd"><span className="modal-title">📋 Chỉnh sửa Điểm danh</span><button className="close-btn" onClick={() => setAModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="fg"><label className="fl">Sinh viên</label><select className="fc"><option>21IT001 – Phạm Văn Đức</option><option>21IT002 – Hoàng Thị Lan</option></select></div>
              <div className="grid2"><div className="fg"><label className="fl">Ca học</label><select className="fc"><option>Sch#1 – INT101 · Thứ 2</option></select></div><div className="fg"><label className="fl">Ngày</label><input type="date" className="fc" defaultValue="2024-09-11" /></div></div>
              <div className="fg"><label className="fl">Trạng thái</label><select className="fc"><option>PRESENT – Có mặt</option><option>ABSENT – Vắng mặt</option><option>LATE – Đi trễ</option><option>EXCUSED – Vắng có phép</option></select></div>
              <div className="fg"><label className="fl">Ghi chú</label><textarea className="fc" rows="2" placeholder="Lý do vắng, đi trễ..."></textarea></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setAModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setAModal(false)}>✓ Cập nhật</button></div>
          </div>
        </div>
      )}
    </div>
  );
}