import React from 'react';

export default function DiemDanh() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Thông tin điểm danh</div>
        <div style={{display:'flex',gap:'8px'}}><button className="btn-icon">📷</button><button className="btn-icon">⛶</button></div>
      </div>
      <div className="card"><table className="tbl">
        <tbody>
          <tr><th>STT</th><th>Mã lớp học phần</th><th>Tên môn học/học phần</th><th>TC</th><th>Số tiết nghỉ có phép</th><th>Số tiết nghỉ không phép</th></tr>
          <tr className="section-row"><td colSpan="6">HK1 (2025 - 2026)</td></tr>
          <tr className="section-row"><td colSpan="6">HK2 (2025 - 2026)</td></tr>
          <tr><td>1</td><td>010110197602</td><td>Phân tích thiết kế hệ thống</td><td>2</td><td>0</td><td>0</td></tr>
          <tr><td>2</td><td>010110197304</td><td>Quản trị hệ thống mạng</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>3</td><td>010110197405</td><td>Thực hành quản trị hệ thống mạng</td><td>1</td><td>0</td><td>0</td></tr>
          <tr><td>4</td><td>010110197720</td><td>Thực hành phân tích thiết kế hệ thống</td><td>1</td><td>0</td><td style={{color:'var(--red)',fontWeight:700}}>5</td></tr>
          <tr><td>5</td><td>010100000204</td><td>Công Nghệ Java</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>6</td><td>010110197014</td><td>Khai phá dữ liệu</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>7</td><td>010110195604</td><td>Deep learning</td><td>3</td><td>0</td><td>0</td></tr>
          <tr style={{background:'#f0f6ff'}}><td colSpan="3" style={{textAlign:'center',fontWeight:700,color:'var(--blue)'}}>TỔNG:</td><td></td><td style={{textAlign:'center',fontWeight:700,color:'var(--blue)'}}>0</td><td style={{textAlign:'center',fontWeight:700,color:'var(--red)'}}>5</td></tr>
        </tbody>
      </table></div>
    </div>
  ); 
}