import React, { useState } from 'react';

export default function Teachers() {
  const [tModal, setTModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Quản lý Giảng viên</div><div className="ph-sub">3 giảng viên · Khoa CNTT &amp; IELTS</div></div>
        <button className="btn btn-blue" onClick={() => setTModal(true)}>+ Thêm giảng viên</button>
      </div>
      <div className="filter-bar">
        <input className="fc" style={{maxWidth:'260px'}} placeholder="🔍 Tìm theo tên, mã GV..." />
        <select className="fc" style={{maxWidth:'160px'}}><option>Tất cả khoa</option><option>CNTT</option><option>IELTS</option></select>
        <select className="fc" style={{maxWidth:'140px'}}><option>Tất cả học vị</option><option>Tiến sĩ</option><option>Thạc sĩ</option></select>
      </div>
      <table className="tbl" style={{background:'white'}}>
        <thead><tr><th>Mã GV</th><th>Giảng viên</th><th>Khoa</th><th>Học vị</th><th>Chuyên ngành</th><th>Ngày vào</th><th>Lớp phụ trách</th><th>Thao tác</th></tr></thead>
        <tbody>
          <tr><td style={{fontWeight:700, color:'var(--blue)'}}>GV001</td><td><div style={{display:'flex', alignItems:'center', gap:'9px'}}><div className="av av-blue av-lg">NA</div><div><div style={{fontWeight:700}}>Nguyễn Văn An</div><div style={{fontSize:'11px', color:'var(--muted)'}}>an.nguyen@hcmut.edu.vn</div></div></div></td><td>CNTT</td><td><span className="badge b-purple">Tiến sĩ</span></td><td style={{fontSize:'12px', color:'var(--muted)'}}>Trí tuệ nhân tạo</td><td style={{fontSize:'12px'}}>01/08/2018</td><td><span className="badge b-blue">INT101</span> <span className="badge b-cyan">IEL101 (TA)</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setTModal(true)}>Sửa</button><button className="btn btn-teal btn-xs">Phân công</button></div></td></tr>
          <tr><td style={{fontWeight:700, color:'var(--blue)'}}>GV002</td><td><div style={{display:'flex', alignItems:'center', gap:'9px'}}><div className="av av-pink av-lg">TB</div><div><div style={{fontWeight:700}}>Trần Thị Bích</div><div style={{fontSize:'11px', color:'var(--muted)'}}>bich.tran@hcmut.edu.vn</div></div></div></td><td>CNTT</td><td><span className="badge b-amber">Thạc sĩ</span></td><td style={{fontSize:'12px', color:'var(--muted)'}}>Kỹ thuật phần mềm</td><td style={{fontSize:'12px'}}>15/01/2020</td><td><span className="badge b-blue">INT201</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setTModal(true)}>Sửa</button><button className="btn btn-teal btn-xs">Phân công</button></div></td></tr>
          <tr><td style={{fontWeight:700, color:'var(--blue)'}}>GV003</td><td><div style={{display:'flex', alignItems:'center', gap:'9px'}}><div className="av av-teal av-lg">LC</div><div><div style={{fontWeight:700}}>Lê Minh Cường</div><div style={{fontSize:'11px', color:'var(--muted)'}}>cuong.le@ieltspro.vn</div></div></div></td><td>IELTS</td><td><span className="badge b-amber">Thạc sĩ</span></td><td style={{fontSize:'12px', color:'var(--muted)'}}>Ngôn ngữ học</td><td style={{fontSize:'12px'}}>01/06/2019</td><td><span className="badge b-blue">IEL101</span></td><td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setTModal(true)}>Sửa</button><button className="btn btn-teal btn-xs">Phân công</button></div></td></tr>
        </tbody>
      </table>

      {tModal && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd"><span className="modal-title">👨‍🏫 Thêm / Sửa Giảng viên</span><button className="close-btn" onClick={() => setTModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="grid2"><div className="fg"><label className="fl">Họ và tên</label><input className="fc" placeholder="Nguyễn Văn A" /></div><div className="fg"><label className="fl">Mã giảng viên</label><input className="fc" placeholder="GV001" /></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Email</label><input className="fc" type="email" placeholder="gv@hcmut.edu.vn" /></div><div className="fg"><label className="fl">Điện thoại</label><input className="fc" placeholder="09xxxxxxxx" /></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Khoa / Bộ môn</label><select className="fc"><option>CNTT</option><option>KTKT</option><option>IELTS</option></select></div><div className="fg"><label className="fl">Học vị</label><select className="fc"><option>Cử nhân</option><option>Thạc sĩ</option><option>Tiến sĩ</option><option>Giáo sư</option></select></div></div>
              <div className="fg"><label className="fl">Chuyên ngành</label><input className="fc" placeholder="Trí tuệ nhân tạo, Ngôn ngữ học..." /></div>
              <div className="fg"><label className="fl">Ngày vào trường</label><input type="date" className="fc" /></div>
              <div className="fg"><label className="fl">Giới thiệu ngắn</label><textarea className="fc" rows="3" placeholder="Thông tin giới thiệu..."></textarea></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setTModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setTModal(false)}>💾 Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}