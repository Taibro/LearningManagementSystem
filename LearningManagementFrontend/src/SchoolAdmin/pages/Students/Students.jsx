import React, { useState } from 'react';

export default function Students() {
  const [sModal, setSModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Quản lý Sinh viên</div><div className="ph-sub">3 sinh viên đang theo học</div></div>
        <div style={{display:'flex', gap:'8px'}}><button className="btn btn-ghost">📥 Import Excel</button><button className="btn btn-blue" onClick={() => setSModal(true)}>+ Thêm sinh viên</button></div>
      </div>
      <div className="filter-bar">
        <input className="fc" style={{maxWidth:'260px'}} placeholder="🔍 MSSV, tên, email..." />
        <select className="fc" style={{maxWidth:'140px'}}><option>Tất cả khoa</option><option>CNTT</option><option>IELTS</option></select>
        <select className="fc" style={{maxWidth:'140px'}}><option>Tất cả lớp</option><option>CNTT21A</option></select>
        <select className="fc" style={{maxWidth:'120px'}}><option>Tất cả năm</option><option>2021</option><option>2024</option></select>
      </div>
      <div className="card">
        <table className="tbl">
          <thead><tr><th>MSSV</th><th>Sinh viên</th><th>Khoa</th><th>Chuyên ngành</th><th>Lớp HC</th><th>Năm nhập</th><th>Lớp học phần</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{fontWeight:700, color:'var(--blue)'}}>21IT001</td><td><div style={{display:'flex', alignItems:'center', gap:'9px'}}><div className="av av-blue av-lg">PD</div><div><div style={{fontWeight:700}}>Phạm Văn Đức</div><div style={{fontSize:'11px', color:'var(--muted)'}}>duc.pham@student.hcmut.edu.vn · Nam</div></div></div></td><td>CNTT</td><td>Kỹ thuật phần mềm</td><td style={{fontFamily:'monospace'}}>CNTT21A</td><td>2021</td><td><span className="badge b-blue">INT101</span> <span className="badge b-blue">INT201</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setSModal(true)}>Xem</button><button className="btn btn-ghost btn-xs">Điểm</button></div></td></tr>
            <tr><td style={{fontWeight:700, color:'var(--blue)'}}>21IT002</td><td><div style={{display:'flex', alignItems:'center', gap:'9px'}}><div className="av av-pink av-lg">HL</div><div><div style={{fontWeight:700}}>Hoàng Thị Lan</div><div style={{fontSize:'11px', color:'var(--muted)'}}>lan.hoang@student.hcmut.edu.vn · Nữ</div></div></div></td><td>CNTT</td><td>Kỹ thuật phần mềm</td><td style={{fontFamily:'monospace'}}>CNTT21A</td><td>2021</td><td><span className="badge b-blue">INT101</span> <span className="badge b-blue">INT201</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setSModal(true)}>Xem</button><button className="btn btn-ghost btn-xs">Điểm</button></div></td></tr>
            <tr><td style={{fontWeight:700, color:'var(--blue)'}}>IE240301</td><td><div style={{display:'flex', alignItems:'center', gap:'9px'}}><div className="av av-amber av-lg">VH</div><div><div style={{fontWeight:700}}>Vũ Quốc Hùng</div><div style={{fontSize:'11px', color:'var(--muted)'}}>hung.vu@ieltspro.vn · Nam</div></div></div></td><td>IELTS</td><td>IELTS General</td><td style={{color:'var(--muted)'}}>—</td><td>2024</td><td><span className="badge b-purple">IEL101</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setSModal(true)}>Xem</button><button className="btn btn-ghost btn-xs">Điểm</button></div></td></tr>
          </tbody>
        </table>
        <div className="pg"><span>Hiển thị 3/3 sinh viên</span><div className="pg-btns"><button className="pg-btn">‹</button><button className="pg-btn act">1</button><button className="pg-btn">›</button></div></div>
      </div>

      {sModal && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd"><span className="modal-title">👨‍🎓 Thêm / Xem Sinh viên</span><button className="close-btn" onClick={() => setSModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="grid2"><div className="fg"><label className="fl">Họ và tên</label><input className="fc" placeholder="Nguyễn Văn A" /></div><div className="fg"><label className="fl">MSSV</label><input className="fc" placeholder="21IT001" /></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Email</label><input className="fc" type="email" placeholder="sv@student.hcmut.edu.vn" /></div><div className="fg"><label className="fl">Giới tính</label><select className="fc"><option>Nam</option><option>Nữ</option><option>Khác</option></select></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Khoa</label><select className="fc"><option>CNTT</option><option>KTKT</option><option>IELTS</option></select></div><div className="fg"><label className="fl">Lớp hành chính</label><input className="fc" placeholder="CNTT21A" /></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Chuyên ngành</label><input className="fc" placeholder="Kỹ thuật phần mềm" /></div><div className="fg"><label className="fl">Năm nhập học</label><input type="number" className="fc" placeholder="2021" /></div></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setSModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setSModal(false)}>💾 Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}