import React, { useState } from 'react';

export default function BranchesRooms() {
  const [modalOpen, setModalOpen] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Cơ sở &amp; Phòng học</div><div className="ph-sub">Quản lý các cơ sở và phòng học của trường</div></div>
        <button className="btn btn-blue" onClick={() => setModalOpen(true)}>+ Thêm phòng học</button>
      </div>

      <div className="grid4 mb4">
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'linear-gradient(90deg,#1976d2,#42a5f5)'}}></div><div className="stat-icon">🏢</div><div className="stat-label">CS1 – Lý Thường Kiệt</div><div style={{fontSize:'11px', color:'var(--muted)', marginTop:'6px'}}>268 Lý Thường Kiệt, Q.10, TP.HCM</div><div style={{marginTop:'8px'}}><span className="badge b-green">Cơ sở chính</span></div></div>
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'linear-gradient(90deg,#00897b,#4db6ac)'}}></div><div className="stat-icon">🏢</div><div className="stat-label">CS2 – Dĩ An, Bình Dương</div><div style={{fontSize:'11px', color:'var(--muted)', marginTop:'6px'}}>Khu phố 6, Dĩ An, Bình Dương</div><div style={{marginTop:'8px'}}><span className="badge b-gray">Cơ sở phụ</span></div></div>
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'linear-gradient(90deg,#e65100,#ffb74d)'}}></div><div className="stat-icon">🏢</div><div className="stat-label">Chi nhánh Quận 1</div><div style={{fontSize:'11px', color:'var(--muted)', marginTop:'6px'}}>123 Nguyễn Huệ, P. Bến Nghé, Q.1</div><div style={{marginTop:'8px'}}><span className="badge b-green">Chi nhánh chính</span></div></div>
        <div className="stat" style={{cursor:'default'}}><div className="stat-top" style={{background:'linear-gradient(90deg,#6a1b9a,#ce93d8)'}}></div><div className="stat-icon">🏢</div><div className="stat-label">Chi nhánh Thủ Đức</div><div style={{fontSize:'11px', color:'var(--muted)', marginTop:'6px'}}>456 Võ Văn Ngân, TP. Thủ Đức</div><div style={{marginTop:'8px'}}><span className="badge b-gray">Chi nhánh phụ</span></div></div>
      </div>

      <div className="card">
        <div className="card-hd"><div className="card-title">Danh sách phòng học</div>
          <div style={{display:'flex', gap:'8px'}}><select className="fc" style={{maxWidth:'140px', padding:'5px 10px', fontSize:'12px'}}><option>Tất cả cơ sở</option><option>CS1</option><option>CS2</option><option>Q1</option></select></div>
        </div>
        <table className="tbl">
          <thead><tr><th>#</th><th>Số phòng</th><th>Tòa</th><th>Cơ sở</th><th>Loại phòng</th><th>Sức chứa</th><th>Thiết bị</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{color:'var(--muted)'}}>1</td><td style={{fontWeight:700}}>A-101</td><td>A</td><td>CS1 – HCMUT</td><td><span className="badge b-blue">Classroom</span></td><td><strong>50</strong></td><td><span className="badge b-gray">projector</span> <span className="badge b-gray">ac</span></td><td><span className="badge b-green"><span className="dot-on"></span> Active</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setModalOpen(true)}>Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
            <tr><td style={{color:'var(--muted)'}}>2</td><td style={{fontWeight:700}}>B-102</td><td>B</td><td>CS1 – HCMUT</td><td><span className="badge b-teal">Lab</span></td><td><strong>30</strong></td><td><span className="badge b-gray">computers</span> <span className="badge b-gray">ac</span></td><td><span className="badge b-green"><span className="dot-on"></span> Active</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setModalOpen(true)}>Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
            <tr><td style={{color:'var(--muted)'}}>3</td><td style={{fontWeight:700}}>B-301</td><td>B</td><td>CS1 – HCMUT</td><td><span className="badge b-purple">Hội trường</span></td><td><strong>80</strong></td><td><span className="badge b-gray">projector</span> <span className="badge b-gray">mic</span></td><td><span className="badge b-green"><span className="dot-on"></span> Active</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setModalOpen(true)}>Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
            <tr><td style={{color:'var(--muted)'}}>4</td><td style={{fontWeight:700}}>C-201</td><td>C</td><td>CS2 – HCMUT</td><td><span className="badge b-blue">Classroom</span></td><td><strong>40</strong></td><td><span className="badge b-gray">smartboard</span></td><td><span className="badge b-green"><span className="dot-on"></span> Active</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setModalOpen(true)}>Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
            <tr><td style={{color:'var(--muted)'}}>5</td><td style={{fontWeight:700}}>A-001</td><td>A</td><td>IELTS Q1</td><td><span className="badge b-cyan">Seminar</span></td><td><strong>20</strong></td><td><span className="badge b-gray">tv_screen</span></td><td><span className="badge b-amber"><span className="dot-off"></span> Bảo trì</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setModalOpen(true)}>Sửa</button><button className="btn btn-danger btn-xs">Xóa</button></div></td></tr>
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd"><span className="modal-title">🚪 Thêm / Sửa Phòng học</span><button className="close-btn" onClick={() => setModalOpen(false)}>×</button></div>
            <div className="modal-body">
              <div className="grid2"><div className="fg"><label className="fl">Cơ sở</label><select className="fc"><option>CS1 – Lý Thường Kiệt</option><option>CS2 – Dĩ An</option><option>Q1 – Quận 1</option></select></div><div className="fg"><label className="fl">Tòa nhà</label><input className="fc" placeholder="A, B, C..." /></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Số phòng</label><input className="fc" placeholder="101, 301..." /></div><div className="fg"><label className="fl">Sức chứa (người)</label><input type="number" className="fc" placeholder="40" /></div></div>
              <div className="fg"><label className="fl">Loại phòng</label><select className="fc"><option>classroom</option><option>lab</option><option>seminar</option><option>lecture_hall</option><option>online</option></select></div>
              <div className="fg"><label className="fl">Thiết bị (phân cách bằng dấu phẩy)</label><input className="fc" placeholder="projector, ac, whiteboard..." /></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setModalOpen(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setModalOpen(false)}>💾 Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}