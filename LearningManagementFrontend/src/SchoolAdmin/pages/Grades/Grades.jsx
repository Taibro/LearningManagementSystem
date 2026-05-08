import React from 'react';

export default function Grades() {
  return (
    <div className="page">
      <div className="ph"><div><div className="ph-title">Kết quả &amp; Học bổng</div><div className="ph-sub">GPA · Rèn luyện · Học bổng theo học kỳ</div></div></div>
      <div className="card mb4">
        <div className="filter-bar"><select className="fc" style={{maxWidth:'200px'}}><option>HK1 – 2024-2025</option><option>HK2 – 2024-2025</option></select><select className="fc" style={{maxWidth:'180px'}}><option>INT101-01 (Tất cả SV)</option></select><button className="btn btn-blue btn-sm">Xem</button></div>
      </div>
      <div className="card">
        <table className="tbl">
          <thead><tr><th>MSSV</th><th>Sinh viên</th><th>Lớp HP</th><th>GPA HK</th><th>TC tích lũy</th><th>Điểm RLuyen</th><th>Xếp loại RL</th><th>Học bổng</th></tr></thead>
          <tbody>
            <tr><td style={{fontWeight:700, color:'var(--blue)'}}>21IT001</td><td>Phạm Văn Đức</td><td>INT101 · INT201</td><td><span style={{fontWeight:700, color:'var(--green)'}}>—</span></td><td>—</td><td>—</td><td>—</td><td>—</td></tr>
            <tr><td style={{fontWeight:700, color:'var(--blue)'}}>21IT002</td><td>Hoàng Thị Lan</td><td>INT101 · INT201</td><td><span style={{fontWeight:700, color:'var(--green)'}}>—</span></td><td>—</td><td>—</td><td>—</td><td>—</td></tr>
            <tr><td style={{fontWeight:700, color:'var(--blue)'}}>IE240301</td><td>Vũ Quốc Hùng</td><td>IEL101</td><td><span style={{fontWeight:700, color:'var(--green)'}}>—</span></td><td>—</td><td>—</td><td>—</td><td>—</td></tr>
          </tbody>
        </table>
        <div style={{padding:'14px 20px', background:'#eff6ff', fontSize:'12px', color:'var(--muted)', borderTop:'1px solid var(--border)'}}>ℹ️ Điểm chưa được nhập. Sử dụng nút "Nhập điểm" ở trang Đăng ký học phần.</div>
      </div>
    </div>
  );
}