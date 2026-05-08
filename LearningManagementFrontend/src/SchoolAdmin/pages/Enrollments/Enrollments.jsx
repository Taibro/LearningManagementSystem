import React, { useState } from 'react';

export default function Enrollments() {
  const [eModal, setEModal] = useState(false);
  const [gModal, setGModal] = useState(false);
  return (
    <div className="page">
      <div className="ph">
        <div><div className="ph-title">Đăng ký học phần</div><div className="ph-sub">5 lượt đăng ký · 100% Enrolled</div></div>
        <button className="btn btn-blue" onClick={() => setEModal(true)}>+ Đăng ký thủ công</button>
      </div>
      <div className="card">
        <table className="tbl">
          <thead><tr><th>#</th><th>Sinh viên</th><th>Lớp học phần</th><th>Ngày ĐK</th><th>Trạng thái</th><th>Điểm GK</th><th>Điểm CK</th><th>Điểm TK</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{color:'var(--muted)'}}>1</td><td>Phạm Văn Đức</td><td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>INT101-01</td><td>09/09/2024</td><td><span className="badge b-green">ENROLLED</span></td><td>—</td><td>—</td><td>—</td><td><button className="btn btn-ghost btn-xs" onClick={() => setGModal(true)}>Nhập điểm</button></td></tr>
            <tr><td style={{color:'var(--muted)'}}>2</td><td>Hoàng Thị Lan</td><td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>INT101-01</td><td>09/09/2024</td><td><span className="badge b-green">ENROLLED</span></td><td>—</td><td>—</td><td>—</td><td><button className="btn btn-ghost btn-xs" onClick={() => setGModal(true)}>Nhập điểm</button></td></tr>
            <tr><td style={{color:'var(--muted)'}}>3</td><td>Phạm Văn Đức</td><td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>INT201-01</td><td>09/09/2024</td><td><span className="badge b-green">ENROLLED</span></td><td>—</td><td>—</td><td>—</td><td><button className="btn btn-ghost btn-xs" onClick={() => setGModal(true)}>Nhập điểm</button></td></tr>
            <tr><td style={{color:'var(--muted)'}}>4</td><td>Hoàng Thị Lan</td><td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>INT201-01</td><td>09/09/2024</td><td><span className="badge b-green">ENROLLED</span></td><td>—</td><td>—</td><td>—</td><td><button className="btn btn-ghost btn-xs" onClick={() => setGModal(true)}>Nhập điểm</button></td></tr>
            <tr><td style={{color:'var(--muted)'}}>5</td><td>Vũ Quốc Hùng</td><td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>IEL101-Q1</td><td>01/03/2024</td><td><span className="badge b-green">ENROLLED</span></td><td>—</td><td>—</td><td>—</td><td><button className="btn btn-ghost btn-xs" onClick={() => setGModal(true)}>Nhập điểm</button></td></tr>
          </tbody>
        </table>
      </div>

      {eModal && (
        <div className="ov open">
          <div className="modal" style={{width:'440px'}}>
            <div className="modal-hd"><span className="modal-title">✅ Đăng ký học phần thủ công</span><button className="close-btn" onClick={() => setEModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="fg"><label className="fl">Sinh viên</label><select className="fc"><option>21IT001 – Phạm Văn Đức</option><option>21IT002 – Hoàng Thị Lan</option><option>IE240301 – Vũ Quốc Hùng</option></select></div>
              <div className="fg"><label className="fl">Lớp học phần</label><select className="fc"><option>INT101-01 – Nhập môn Lập trình</option><option>INT201-01 – CTDL</option><option>IEL101-Q1 – IELTS Foundation</option></select></div>
              <div className="fg"><label className="fl">Trạng thái đăng ký</label><select className="fc"><option>ENROLLED</option><option>PENDING</option></select></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setEModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setEModal(false)}>✓ Đăng ký</button></div>
          </div>
        </div>
      )}

      {gModal && (
        <div className="ov open">
          <div className="modal" style={{width:'440px'}}>
            <div className="modal-hd"><span className="modal-title">📊 Nhập điểm</span><button className="close-btn" onClick={() => setGModal(false)}>×</button></div>
            <div className="modal-body">
              <div style={{background:'#eff6ff', borderRadius:'8px', padding:'10px 14px', marginBottom:'16px', fontSize:'13px'}}><strong>Sinh viên:</strong> Phạm Văn Đức · <strong>Lớp:</strong> INT101-01</div>
              <div className="grid3">
                <div className="fg"><label className="fl">Điểm GK (0–10)</label><input type="number" className="fc" placeholder="0.00" min="0" max="10" step="0.01" /></div>
                <div className="fg"><label className="fl">Điểm CK (0–10)</label><input type="number" className="fc" placeholder="0.00" min="0" max="10" step="0.01" /></div>
                <div className="fg"><label className="fl">Điểm TK (0–10)</label><input type="number" className="fc" placeholder="0.00" min="0" max="10" step="0.01" /></div>
              </div>
              <div className="fg"><label className="fl">Xếp loại (chữ)</label><select className="fc"><option>— Tự động —</option><option>A+</option><option>A</option><option>B+</option><option>B</option><option>C+</option><option>C</option><option>D+</option><option>D</option><option>F</option></select></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setGModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setGModal(false)}>💾 Lưu điểm</button></div>
          </div>
        </div>
      )}
    </div>
  );
}