import React from 'react';

export default function RenLuyen() { 
  return (
    <div className="page active">
      <div className="page-title">Kết quả rèn luyện</div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Ngày vi phạm</th><th>Nội dung</th><th>Hình thức</th><th>Ghi chú</th><th>Điểm Cộng/Trừ</th></tr>
            <tr className="section-row"><td colSpan="6">HK1 (2025 - 2026)</td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Điểm rèn luyện</td><td>85,00</td><td></td><td></td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Xếp loại</td><td>Tốt</td><td></td><td></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}