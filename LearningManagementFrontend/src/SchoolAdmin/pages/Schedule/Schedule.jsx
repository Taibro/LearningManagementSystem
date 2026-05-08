import React, { useState } from 'react';

export default function Schedule() {
  const [sModal, setSModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Lịch học theo tuần</div><div className="ph-sub">Tuần 21/04/2026 – 27/04/2026</div></div>
        <div style={{display:'flex', gap:'8px'}}>
          <button className="btn btn-ghost btn-sm">‹ Tuần trước</button>
          <button className="btn btn-blue btn-sm">Hôm nay</button>
          <button className="btn btn-ghost btn-sm">Tuần sau ›</button>
          <button className="btn btn-blue" onClick={() => setSModal(true)}>+ Tạo lịch</button>
        </div>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <div className="wk-grid">
          <div className="wk-head" style={{fontSize:'10px'}}>Ca học</div>
          <div className="wk-head"><div>Thứ 2</div><div style={{fontSize:'10px', opacity:'.75'}}>21/04</div></div>
          <div className="wk-head"><div>Thứ 3</div><div style={{fontSize:'10px', opacity:'.75'}}>22/04</div></div>
          <div className="wk-head"><div>Thứ 4</div><div style={{fontSize:'10px', opacity:'.75'}}>23/04</div></div>
          <div className="wk-head"><div>Thứ 5</div><div style={{fontSize:'10px', opacity:'.75'}}>24/04</div></div>
          <div className="wk-head"><div>Thứ 6</div><div style={{fontSize:'10px', opacity:'.75'}}>25/04</div></div>
          <div className="wk-head"><div>Thứ 7</div><div style={{fontSize:'10px', opacity:'.75'}}>26/04</div></div>
          <div className="wk-head"><div>CN</div><div style={{fontSize:'10px', opacity:'.75'}}>27/04</div></div>

          <div className="wk-cell ca">SÁNG</div>
          <div className="wk-cell">
            <div className="sc-card sc-reg"><strong>INT101-01</strong><br/>07:30–09:30<br/>Phòng A-101<br/>GV: Nguyễn Văn An</div>
          </div>
          <div className="wk-cell">
            <div className="sc-card sc-lab"><strong>INT201-01</strong><br/>09:45–11:45<br/>Phòng B-102 (Lab)<br/>GV: Trần Thị Bích</div>
          </div>
          <div className="wk-cell">
            <div className="sc-card sc-reg"><strong>INT101-01</strong><br/>07:30–09:30<br/>Phòng A-101<br/>GV: Nguyễn Văn An</div>
          </div>
          <div className="wk-cell"></div><div className="wk-cell"></div>
          <div className="wk-cell">
            <div className="sc-card sc-lab"><strong>IEL101-Q1</strong><br/>08:00–10:00<br/>Phòng A-001<br/>GV: Lê Minh Cường</div>
          </div>
          <div className="wk-cell"></div>

          <div className="wk-cell ca">CHIỀU</div>
          <div className="wk-cell"></div><div className="wk-cell"></div>
          <div className="wk-cell">
            <div className="sc-card sc-ex"><strong>INT101-01 (Bù)</strong><br/>13:30–15:30<br/>Phòng A-101</div>
          </div>
          <div className="wk-cell"></div><div className="wk-cell"></div><div className="wk-cell"></div><div className="wk-cell"></div>

          <div className="wk-cell ca">TỐI</div>
          <div className="wk-cell"></div><div className="wk-cell"></div><div className="wk-cell"></div>
          <div className="wk-cell"></div><div className="wk-cell"></div><div className="wk-cell"></div><div className="wk-cell"></div>
        </div>
        <div style={{padding:'10px 16px', display:'flex', gap:'16px', fontSize:'11px', background:'#f8fafc', borderTop:'1px solid var(--border)'}}>
          <span><span style={{display:'inline-block', width:'10px', height:'10px', background:'#dbeafe', borderLeft:'3px solid var(--blue-lt)', marginRight:'4px', verticalAlign:'middle'}}></span>Regular</span>
          <span><span style={{display:'inline-block', width:'10px', height:'10px', background:'#dcfce7', borderLeft:'3px solid #22c55e', marginRight:'4px', verticalAlign:'middle'}}></span>Lab</span>
          <span><span style={{display:'inline-block', width:'10px', height:'10px', background:'#fef3c7', borderLeft:'3px solid #f59e0b', marginRight:'4px', verticalAlign:'middle'}}></span>Makeup/Exam</span>
        </div>
      </div>

      {sModal && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd"><span className="modal-title">🗓 Tạo / Sửa Lịch học</span><button className="close-btn" onClick={() => setSModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="grid2"><div className="fg"><label className="fl">Lớp học</label><select className="fc"><option>INT101-01</option><option>INT201-01</option><option>IEL101-Q1</option></select></div><div className="fg"><label className="fl">Phòng học</label><select className="fc"><option>A-101 (Classroom · 50)</option><option>B-102 (Lab · 30)</option><option>B-301 (HT · 80)</option><option>A-001 (Seminar · 20)</option></select></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Thứ trong tuần</label><select className="fc"><option value="2">Thứ 2</option><option value="3">Thứ 3</option><option value="4">Thứ 4</option><option value="5">Thứ 5</option><option value="6">Thứ 6</option><option value="7">Thứ 7</option><option value="1">Chủ nhật</option></select></div><div className="fg"><label className="fl">Loại buổi</label><select className="fc"><option>REGULAR</option><option>MAKEUP</option><option>EXAM</option><option>LAB</option><option>SEMINAR</option></select></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Giờ bắt đầu</label><input type="time" className="fc" defaultValue="07:30" /></div><div className="fg"><label className="fl">Giờ kết thúc</label><input type="time" className="fc" defaultValue="09:30" /></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Áp dụng từ ngày</label><input type="date" className="fc" /></div><div className="fg"><label className="fl">Áp dụng đến ngày</label><input type="date" className="fc" /></div></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setSModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setSModal(false)}>💾 Lưu</button></div>
          </div>
        </div>
      )}
    </div>
  );
}