import React, { useState } from 'react';
import { Link } from 'react-router-dom';

export default function Classes() {
  const [cModal, setCModal] = useState(false);
  const [aModal, setAModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Quản lý Lớp học</div><div className="ph-sub">Tạo lớp · Phân công giảng viên · Quản lý sĩ số</div></div>
        <button className="btn btn-blue" onClick={() => setCModal(true)}>+ Tạo lớp học</button>
      </div>
      <div className="card">
        <table className="tbl">
          <thead><tr><th>Mã lớp</th><th>Môn học</th><th>Học kỳ</th><th>Cơ sở</th><th>Giảng viên</th><th>Sĩ số</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr>
              <td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)', fontWeight:700}}>INT101-01-HK1-2425</td>
              <td><div style={{fontWeight:600}}>Nhập môn Lập trình</div><div style={{fontSize:'11px', color:'var(--muted)'}}>3 TC · 30 buổi</div></td>
              <td>HK1 · 2024-2025</td><td>CS1 – HCMUT</td>
              <td><div style={{display:'flex', flexDirection:'column', gap:'3px'}}><span className="badge b-blue">main: Nguyễn Văn An</span></div></td>
              <td><span style={{fontWeight:700, color:'var(--blue)'}}>2</span><span style={{color:'var(--muted)'}}>/40</span></td>
              <td><span className="badge b-blue">IN_PROGRESS</span></td>
              <td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setCModal(true)}>Sửa</button><button className="btn btn-teal btn-xs" onClick={() => setAModal(true)}>+ GV</button><Link to="/attendance" className="btn btn-ghost btn-xs" style={{textDecoration:'none'}}>Điểm danh</Link></div></td>
            </tr>
            <tr>
              <td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)', fontWeight:700}}>INT201-01-HK1-2425</td>
              <td><div style={{fontWeight:600}}>CTDL &amp; Giải thuật</div><div style={{fontSize:'11px', color:'var(--muted)'}}>3 TC · 30 buổi</div></td>
              <td>HK1 · 2024-2025</td><td>CS1 – HCMUT</td>
              <td><span className="badge b-blue">main: Trần Thị Bích</span></td>
              <td><span style={{fontWeight:700, color:'var(--blue)'}}>2</span><span style={{color:'var(--muted)'}}>/35</span></td>
              <td><span className="badge b-blue">IN_PROGRESS</span></td>
              <td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setCModal(true)}>Sửa</button><button className="btn btn-teal btn-xs" onClick={() => setAModal(true)}>+ GV</button><Link to="/attendance" className="btn btn-ghost btn-xs" style={{textDecoration:'none'}}>Điểm danh</Link></div></td>
            </tr>
            <tr>
              <td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)', fontWeight:700}}>IEL101-Q1-T9-2024</td>
              <td><div style={{fontWeight:600}}>IELTS Foundation</div><div style={{fontSize:'11px', color:'var(--muted)'}}>0 TC · 40 buổi</div></td>
              <td>Khóa T9 · 2024</td><td>IELTS Q1</td>
              <td><div style={{display:'flex', flexDirection:'column', gap:'3px'}}><span className="badge b-blue">main: Lê Minh Cường</span><span className="badge b-cyan">TA: Nguyễn Văn An</span></div></td>
              <td><span style={{fontWeight:700, color:'var(--amber)'}}>1</span><span style={{color:'var(--muted)'}}>/20</span></td>
              <td><span className="badge b-green">OPEN</span></td>
              <td><div style={{display:'flex', gap:'4px'}}><button className="btn btn-ghost btn-xs" onClick={() => setCModal(true)}>Sửa</button><button className="btn btn-teal btn-xs" onClick={() => setAModal(true)}>+ GV</button><Link to="/attendance" className="btn btn-ghost btn-xs" style={{textDecoration:'none'}}>Điểm danh</Link></div></td>
            </tr>
          </tbody>
        </table>
      </div>

      {cModal && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd"><span className="modal-title">🎓 Tạo / Sửa Lớp học</span><button className="close-btn" onClick={() => setCModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="fg"><label className="fl">Mã lớp</label><input className="fc" placeholder="INT101-01-HK1-2425" /></div>
              <div className="grid2"><div className="fg"><label className="fl">Môn học</label><select className="fc"><option>INT101 – Nhập môn Lập trình</option><option>INT201 – CTDL & Giải thuật</option><option>IEL101 – IELTS Foundation</option></select></div><div className="fg"><label className="fl">Học kỳ</label><select className="fc"><option>HK1 – 2024-2025</option><option>HK2 – 2024-2025</option><option>Khóa T9 – 2024</option></select></div></div>
              <div className="grid2"><div className="fg"><label className="fl">Cơ sở học</label><select className="fc"><option>CS1 – Lý Thường Kiệt</option><option>CS2 – Dĩ An</option><option>Q1 – Quận 1</option></select></div><div className="fg"><label className="fl">Sĩ số tối đa</label><input type="number" className="fc" defaultValue="40" min="1" /></div></div>
              <div className="fg"><label className="fl">Trạng thái</label><select className="fc"><option>OPEN</option><option>IN_PROGRESS</option><option>COMPLETED</option><option>CANCELLED</option></select></div>
              <div className="fg"><label className="fl">Ghi chú</label><textarea className="fc" rows="2" placeholder="Ghi chú về lớp học..."></textarea></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setCModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setCModal(false)}>💾 Lưu</button></div>
          </div>
        </div>
      )}

      {aModal && (
        <div className="ov open">
          <div className="modal" style={{width:'460px'}}>
            <div className="modal-hd"><span className="modal-title">🔗 Phân công Giảng viên vào Lớp</span><button className="close-btn" onClick={() => setAModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="fg"><label className="fl">Lớp học</label><select className="fc"><option>INT101-01-HK1-2425</option><option>INT201-01-HK1-2425</option><option>IEL101-Q1-T9-2024</option></select></div>
              <div className="fg"><label className="fl">Giảng viên</label><select className="fc"><option>GV001 – Nguyễn Văn An (TS. AI)</option><option>GV002 – Trần Thị Bích (ThS. KTPM)</option><option>GV003 – Lê Minh Cường (ThS. NNH)</option></select></div>
              <div className="fg"><label className="fl">Vai trò trong lớp</label><select className="fc"><option>main – Giảng viên chính</option><option>assistant – Trợ giảng</option><option>guest – Thỉnh giảng</option></select></div>
              <div style={{background:'#eff6ff', border:'1px solid #b3d4f5', borderRadius:'8px', padding:'10px 12px', fontSize:'12px', color:'var(--blue)'}}>ℹ️ Mỗi lớp có thể có nhiều giảng viên (N-N). Một giảng viên đóng vai main, các người còn lại là assistant hoặc guest.</div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setAModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setAModal(false)}>✓ Phân công</button></div>
          </div>
        </div>
      )}
    </div>
  );
}