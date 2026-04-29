import React from 'react';

export default function Scholarships() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Mức học bổng được xét</div>
        <div style={{display:'flex',gap:'8px'}}>
          <select className="form-ctrl" style={{width:'160px'}}><option>Tất cả</option></select>
          <button className="btn-icon">⛶</button>
        </div>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Loại học bổng</th><th>Tổng số TC học lần đầu</th><th>Điểm hệ 10</th><th>Điểm TB học lần đầu</th><th>Mức học bổng</th><th>Số tiền</th><th>Đã nhận</th></tr>
            <tr><td colSpan="8" style={{textAlign:'center',color:'var(--text-light)',padding:'30px'}}>Không có dữ liệu hiển thị</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}