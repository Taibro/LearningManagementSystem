import React from 'react';

export default function TTTrucTuyen() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Thanh toán trực tuyến</div>
        <div style={{display:'flex',alignItems:'center',gap:'8px'}}>
          <span style={{fontSize:'13px'}}>Đợt</span>
          <select className="form-ctrl" style={{width:'160px'}}><option>Tất cả</option></select>
        </div>
      </div>
      <div className="card">
        <div className="card-body">
          <table className="tbl" style={{marginBottom:'16px'}}>
            <tbody>
              <tr><th style={{width:'40px'}}><input type="checkbox" /></th><th>STT</th><th>Mã</th><th>Nội dung thu</th><th>Tín chỉ</th><th>Bắt buộc</th><th>Số tiền (VND)</th></tr>
              <tr><td colSpan="7" style={{textAlign:'center',padding:'20px',color:'var(--text-light)'}}>Không tìm thấy dữ liệu công nợ</td></tr>
            </tbody>
          </table>
          <div style={{background:'#fff8f0',padding:'14px',borderRadius:'6px',fontSize:'13px',lineHeight:2}}>
            <div>1. Để thanh toán trực tuyến qua ngân hàng <strong style={{color:'var(--red)'}}>thẻ ATM</strong> phải đăng ký <strong style={{color:'var(--red)'}}>Thanh toán online</strong>.</div>
            <div>2. Vui lòng kiểm tra <strong style={{color:'var(--red)'}}>HẠN MỨC THẺ</strong> trước khi thanh toán</div>
            <div>3. Khuyến cáo thanh toán qua <strong style={{color:'var(--red)'}}>QR-Code</strong>, thẻ ATM nội địa.</div>
          </div>
        </div>
      </div>
    </div>
  ); 
}