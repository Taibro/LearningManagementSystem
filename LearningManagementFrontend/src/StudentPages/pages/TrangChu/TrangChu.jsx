import React from 'react';
import { notifData } from '../../data';

export default function TrangChu({ setPage }) {
  return (
    <div className="page active">
      <div className="grid" style={{display:'grid',gridTemplateColumns:'1fr 320px',gap:'16px'}}>
        <div>
          <div className="card mb-4" style={{marginBottom:'16px'}}>
            <div className="card-body">
              <h2 style={{fontSize:'16px',fontWeight:700,marginBottom:'12px',color:'var(--text)'}}>Thông tin sinh viên</h2>
              <div style={{display:'flex',gap:'20px',alignItems:'flex-start'}}>
                <div style={{textAlign:'center'}}>
                  <div style={{width:'80px',height:'80px',borderRadius:'50%',background:'linear-gradient(135deg,#1a6fb5,#60a5fa)',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontSize:'24px',fontWeight:700,margin:'0 auto 8px'}}>NT</div>
                  <a className="link" style={{cursor:'pointer'}} onClick={() => setPage('thong-tin-sv')}>Xem chi tiết</a>
                </div>
                <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'4px 24px',flex:1}}>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>MSSV: </span><strong>2001230773</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Lớp học: </span><strong>14DHTH05</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Họ tên: </span><strong>Nguyễn Thành Tài</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Khóa học: </span><strong>2023</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Giới tính: </span><strong>Nam</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Bậc đào tạo: </span><strong>Đại học</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Ngày sinh: </span><strong>14/10/2005</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Loại hình: </span><strong>Chính quy</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Nơi sinh: </span><strong>Cà Mau</strong></div>
                  <div style={{fontSize:'13px'}}><span style={{color:'var(--text-light)'}}>Ngành: </span><strong>Công nghệ thông tin</strong></div>
                </div>
              </div>
            </div>
          </div>

          <div className="card mb-4" style={{marginBottom:'16px'}}>
            <div className="card-body">
              <div className="quick-grid">
                <div className="quick-item" onClick={() => setPage('nhac-nho')}><div className="qi-icon">📋</div><div className="qi-label">Nhắc nhở</div></div>
                <div className="quick-item" onClick={() => setPage('ket-qua-ht')}><div className="qi-icon">📊</div><div className="qi-label">Kết quả học tập</div></div>
                <div className="quick-item" onClick={() => setPage('lich-tuan')}><div className="qi-icon">📅</div><div className="qi-label">Lịch theo tuần</div></div>
                <div className="quick-item" onClick={() => setPage('lich-tien-do')}><div className="qi-icon">📈</div><div className="qi-label">Lịch theo tiến độ</div></div>
                <div className="quick-item" onClick={() => setPage('ct-khung')}><div className="qi-icon">📚</div><div className="qi-label">Chương trình khung</div></div>
                <div className="quick-item" onClick={() => setPage('dk-hp')}><div className="qi-icon">✏️</div><div className="qi-label">Đăng ký học phần</div></div>
                <div className="quick-item" onClick={() => setPage('cong-no')}><div className="qi-icon">💰</div><div className="qi-label">Tra cứu công nợ</div></div>
                <div className="quick-item" onClick={() => setPage('tt-truc-tuyen')}><div className="qi-icon">💳</div><div className="qi-label">Thanh toán trực tuyến</div></div>
                <div className="quick-item" onClick={() => setPage('tt-noi-tru')}><div className="qi-icon">🏢</div><div className="qi-label">Thanh toán nội trú</div></div>
                <div className="quick-item" onClick={() => setPage('phieu-thu-th')}><div className="qi-icon">🧾</div><div className="qi-label">Phiếu thu tổng hợp</div></div>
                <div className="quick-item" onClick={() => setPage('ho-so-sv')}><div className="qi-icon">📁</div><div className="qi-label">Hộp thư SV</div></div>
              </div>
            </div>
          </div>

          <div style={{display:'grid',gridTemplateColumns:'1fr 1fr 1fr',gap:'16px'}}>
            <div className="card"><div className="card-body">
              <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'10px'}}>
                <h3 style={{fontSize:'14px',fontWeight:700}}>Kết quả học tập</h3>
                <select className="form-ctrl" style={{width:'auto',fontSize:'12px',padding:'3px 6px'}}><option>HK2 (2025 - 2026)</option></select>
              </div>
              <div style={{textAlign:'center',color:'var(--text-light)',fontSize:'12px',padding:'20px 0'}}>Chưa có dữ liệu hiển thị</div>
            </div></div>
            
            <div className="card"><div className="card-body">
              <h3 style={{fontSize:'14px',fontWeight:700,marginBottom:'10px'}}>Tiến độ học tập</h3>
              <div style={{display:'flex',justifyContent:'center',marginBottom:'12px'}}>
                <div style={{position:'relative',width:'100px',height:'100px'}}>
                  <svg viewBox="0 0 100 100" width="100" height="100">
                    <circle cx="50" cy="50" r="40" fill="none" stroke="#e2e8f0" strokeWidth="12"/>
                    <circle cx="50" cy="50" r="40" fill="none" stroke="#3b82f6" strokeWidth="12" strokeDasharray="188 64" strokeLinecap="round" transform="rotate(-90 50 50)"/>
                    <circle cx="50" cy="50" r="40" fill="none" stroke="#22c55e" strokeWidth="12" strokeDasharray="30 222" strokeDashoffset="-188" strokeLinecap="round" transform="rotate(-90 50 50)"/>
                  </svg>
                  <div style={{position:'absolute',top:'50%',left:'50%',transform:'translate(-50%,-50%)',fontSize:'13px',fontWeight:700,textAlign:'center',lineHeight:1.2}}>119<br/><span style={{fontSize:'10px',color:'var(--text-light)'}}>TC</span></div>
                </div>
              </div>
              <div style={{fontSize:'11px',display:'flex',gap:'8px',justifyContent:'center'}}>
                <span style={{display:'flex',alignItems:'center',gap:'3px'}}><span style={{width:'8px',height:'8px',background:'#3b82f6',borderRadius:'2px',display:'inline-block'}}></span>Đã học</span>
                <span style={{display:'flex',alignItems:'center',gap:'3px'}}><span style={{width:'8px',height:'8px',background:'#22c55e',borderRadius:'2px',display:'inline-block'}}></span>Đạt</span>
              </div>
            </div></div>
            
            <div className="card"><div className="card-body">
              <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'10px'}}>
                <h3 style={{fontSize:'14px',fontWeight:700}}>Lớp học phần</h3>
                <select className="form-ctrl" style={{width:'auto',fontSize:'12px',padding:'3px 6px'}}><option>HK2 (2025 - 2026)</option></select>
              </div>
              <table className="tbl" style={{fontSize:'12px'}}>
                <tbody>
                  <tr><th>Môn học/học phần</th><th style={{width:'60px',textAlign:'center'}}>Số TC</th></tr>
                  <tr><td><a className="link" style={{fontSize:'12px'}}>0110110197602</a><br/>Phân tích thiết kế hệ thống</td><td style={{textAlign:'center'}}>2</td></tr>
                  <tr><td><a className="link" style={{fontSize:'12px'}}>0110110195604</a><br/>Deep learning</td><td style={{textAlign:'center'}}>3</td></tr>
                  <tr><td><a className="link" style={{fontSize:'12px'}}>0101100000204</a><br/>Công Nghệ Java</td><td style={{textAlign:'center'}}>3</td></tr>
                  <tr><td><a className="link" style={{fontSize:'12px'}}>0110110196910</a><br/>Lập trình di động</td><td style={{textAlign:'center'}}>3</td></tr>
                </tbody>
              </table>
            </div></div>
          </div>
        </div>

        <div>
          <div className="card" style={{marginBottom:'12px'}}><div className="card-body">
            <div style={{fontSize:'14px',fontWeight:600,color:'var(--text-light)',marginBottom:'4px'}}>Nhắc nhở mới, chưa xem</div>
            <div style={{fontSize:'36px',fontWeight:800,color:'var(--text)'}}>0</div>
            <svg style={{float:'right',marginTop:'-40px'}} width="28" height="28" fill="none" stroke="#94a3b8" viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
            <br/><a className="link" style={{cursor:'pointer'}} onClick={() => setPage('nhac-nho')}>Xem chi tiết</a>
          </div></div>
          
          <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'12px',marginBottom:'12px'}}>
            <div className="card" style={{border:'1px solid #bfdbfe'}}><div className="card-body" style={{padding:'14px'}}>
              <div style={{fontSize:'12px',color:'var(--blue)',fontWeight:600}}>Lịch học trong tuần</div>
              <div style={{fontSize:'32px',fontWeight:800,color:'var(--blue)',margin:'6px 0'}}>10</div>
              <a className="link" style={{cursor:'pointer'}} onClick={() => setPage('lich-tuan')}>Xem chi tiết</a>
            </div></div>
            <div className="card" style={{border:'1px solid #fed7aa'}}><div className="card-body" style={{padding:'14px'}}>
              <div style={{fontSize:'12px',color:'var(--orange)',fontWeight:600}}>Lịch thi trong tuần</div>
              <div style={{fontSize:'32px',fontWeight:800,color:'var(--orange)',margin:'6px 0'}}>0</div>
              <a className="link" style={{color:'var(--orange)', cursor:'pointer'}} onClick={() => setPage('lich-tuan')}>Xem chi tiết</a>
            </div></div>
          </div>
          
          <div className="card"><div className="card-body">
            <h3 style={{fontSize:'14px',fontWeight:700,marginBottom:'10px'}}>Thông báo gần đây</h3>
            <div style={{display:'flex', flexDirection:'column', gap:'8px'}}>
              <div style={{padding:'8px',background:'#fff8f0',borderRadius:'6px',borderLeft:'3px solid var(--orange)'}}>
                <div style={{fontSize:'12px',fontWeight:600,color:'var(--orange)'}}>PMT-EMS Lịch học thay đổi</div>
                <div style={{fontSize:'11px',color:'var(--text-light)',marginTop:'2px'}}>25/03/2026</div>
              </div>
              <div style={{padding:'8px',background:'#fff8f0',borderRadius:'6px',borderLeft:'3px solid var(--orange)'}}>
                <div style={{fontSize:'12px',fontWeight:600,color:'var(--orange)'}}>PMT-EMS Lịch học thay đổi</div>
                <div style={{fontSize:'11px',color:'var(--text-light)',marginTop:'2px'}}>18/03/2026</div>
              </div>
              <div style={{padding:'8px',background:'#f0f9ff',borderRadius:'6px',borderLeft:'3px solid var(--blue)'}}>
                <div style={{fontSize:'12px',fontWeight:600,color:'var(--blue)'}}>Thông báo học phí HK2</div>
                <div style={{fontSize:'11px',color:'var(--text-light)',marginTop:'2px'}}>01/01/2026</div>
              </div>
            </div>
          </div></div>
        </div>
      </div>
    </div>
  );
}