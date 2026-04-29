import React, { useState } from 'react';

export default function CongNo() {
  const [tab, setTab] = useState('hp');
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Tra cứu công nợ</div>
        <div style={{display:'flex',gap:'8px'}}>
          <span style={{fontSize:'13px',alignSelf:'center'}}>Học Kỳ</span>
          <select className="form-ctrl" style={{width:'160px'}}><option>Tất cả</option><option>HK2 (2025-2026)</option></select>
          <button className="btn btn-outline btn-sm">🖨 In công nợ</button>
          <button className="btn-icon">⛶</button>
        </div>
      </div>

      <div className="card" style={{marginBottom:'16px',overflowX:'auto'}}>
        <div style={{padding:'10px 14px',fontWeight:700,fontSize:'13px',borderBottom:'1px solid var(--border)'}}>Khoản thu khác</div>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Năm học</th><th>Tên đợt</th><th>Mã khoản thu khác</th><th>Tên khoản thu khác</th><th>Mức nộp</th><th>Bắt buộc</th><th>Ngày nộp</th><th>Số tiền nộp</th><th>Công nợ</th></tr>
            <tr><td>1</td><td>2023-2024</td><td></td><td>103</td><td>BẢO HIỂM TAI NẠN NĂM 2023-2024</td><td style={{textAlign:'right'}}>93,000</td><td style={{textAlign:'center'}}><span className="icon-x">✗</span></td><td>26/08/2023</td><td style={{textAlign:'right'}}>93,000</td><td style={{textAlign:'right'}}>0</td></tr>
            <tr><td>2</td><td></td><td></td><td>124</td><td>BẢO HIỂM Y TẾ 11 THÁNG NĂM 2026</td><td style={{textAlign:'right'}}>579,150</td><td style={{textAlign:'center'}}><span className="icon-x">✗</span></td><td>20/01/2026</td><td style={{textAlign:'right'}}>579,150</td><td style={{textAlign:'right'}}>0</td></tr>
            <tr style={{background:'#f8fafc'}}><td colSpan="5" style={{textAlign:'right',fontWeight:700}}></td><td style={{textAlign:'right',fontWeight:700}}>2,942,170</td><td></td><td></td><td style={{textAlign:'right',fontWeight:700}}>2,942,170</td><td style={{textAlign:'right',fontWeight:700}}>0</td></tr>
          </tbody>
        </table>
      </div>

      <div className="tabs">
        <div className={`tab-btn ${tab==='hp'?'active':''}`} onClick={()=>setTab('hp')}>Học phí</div>
        <div className={`tab-btn ${tab==='mhdk'?'active':''}`} onClick={()=>setTab('mhdk')}>Môn học đăng ký</div>
        <div className={`tab-btn ${tab==='kht'?'active':''}`} onClick={()=>setTab('kht')}>Danh sách khấu trừ</div>
      </div>

      {tab === 'hp' && (
        <div>
          <div className="card" style={{overflowX:'auto'}}>
            <table className="tbl" style={{minWidth:'1000px'}}>
              <tbody>
                <tr><th>STT</th><th>Đợt</th><th>Mã</th><th>Mã LHP</th><th>Nội dung</th><th>Số TC</th><th>Mức phí ban đầu</th><th>% Miễn giảm</th><th>Số tiền miễn giảm</th><th>Mức nộp</th><th>Trạng thái ĐK</th><th>Ngày nộp</th></tr>
                <tr className="section-row"><td colSpan="12">Đợt: 2025_HK2 (2025 - 2026)</td></tr>
                <tr><td>1</td><td>HK2 (2025 - 2026)</td><td>0101097288</td><td>010109728801</td><td>Sinh hoạt giữa khóa năm 3</td><td>0</td><td style={{textAlign:'right'}}>0</td><td style={{textAlign:'right'}}>0</td><td style={{textAlign:'right'}}>0</td><td style={{textAlign:'right'}}>0</td><td>Đăng ký mới</td><td></td></tr>
              </tbody>
            </table>
          </div>
          <div style={{padding:'12px 0',fontSize:'13px',display:'flex',gap:'24px',flexWrap:'wrap'}}>
            <span>Tổng nộp học phí: <strong style={{color:'var(--red)'}}>102,880,250</strong></span>
            <span>Tổng nộp khoản thu khác: <strong style={{color:'var(--red)'}}>2,942,170</strong></span>
            <span>Tổng công nợ học phí: <strong style={{color:'var(--blue)'}}>0</strong></span>
          </div>
        </div>
      )}
      {tab === 'mhdk' && <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)'}}>Không có dữ liệu</div></div>}
      {tab === 'kht' && <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)'}}>Không có dữ liệu</div></div>}
    </div>
  );
}