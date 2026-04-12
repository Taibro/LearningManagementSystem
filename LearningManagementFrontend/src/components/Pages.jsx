import React, { useState } from 'react';
import { notifData, surveyData } from '../data';

export function TrangChu({ setPage }) {
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
                <div className="quick-item" onClick={() => setPage('phieu-thu-th')}><div className="qi-icon">🧾</div><div className="qi-label">Phiếu thu tổng hợp</div></div>
                <div className="quick-item" onClick={() => setPage('ho-so-sv')}><div className="qi-icon">📁</div><div className="qi-label">Hộp thư SV</div></div>
              </div>
            </div>
          </div>

          <div style={{display:'grid',gridTemplateColumns:'1fr 1fr 1fr',gap:'16px'}}>
            <div className="card"><div className="card-body"><h3 style={{fontSize:'14px',fontWeight:700}}>Kết quả học tập</h3><div style={{textAlign:'center',color:'var(--text-light)',fontSize:'12px',padding:'20px 0'}}>Chưa có dữ liệu hiển thị</div></div></div>
            <div className="card">
              <div className="card-body">
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
                <div style={{fontSize:'11px',display:'flex',gap:'8px',justifyContent:'center'}}><span style={{display:'flex',alignItems:'center',gap:'3px'}}><span style={{width:'8px',height:'8px',background:'#3b82f6',borderRadius:'2px',display:'inline-block'}}></span>Đã học</span><span style={{display:'flex',alignItems:'center',gap:'3px'}}><span style={{width:'8px',height:'8px',background:'#22c55e',borderRadius:'2px',display:'inline-block'}}></span>Đạt</span></div>
              </div>
            </div>
            <div className="card"><div className="card-body"><h3 style={{fontSize:'14px',fontWeight:700}}>Lớp học phần</h3><table className="tbl" style={{fontSize:'12px'}}><tbody><tr><th>Môn học/học phần</th><th style={{width:'60px',textAlign:'center'}}>Số TC</th></tr><tr><td><a className="link">0110110197602</a><br/>Phân tích thiết kế hệ thống</td><td style={{textAlign:'center'}}>2</td></tr><tr><td><a className="link">0110110195604</a><br/>Deep learning</td><td style={{textAlign:'center'}}>3</td></tr><tr><td><a className="link">0101100000204</a><br/>Công Nghệ Java</td><td style={{textAlign:'center'}}>3</td></tr></tbody></table></div></div>
          </div>
        </div>
        <div>
          <div className="card" style={{marginBottom:'12px'}}><div className="card-body"><div style={{fontSize:'14px',fontWeight:600,color:'var(--text-light)',marginBottom:'4px'}}>Nhắc nhở mới, chưa xem</div><div style={{fontSize:'36px',fontWeight:800,color:'var(--text)'}}>0</div><br/><a className="link" onClick={() => setPage('nhac-nho')}>Xem chi tiết</a></div></div>
          <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:'12px',marginBottom:'12px'}}><div className="card" style={{border:'1px solid #bfdbfe'}}><div className="card-body" style={{padding:'14px'}}><div style={{fontSize:'12px',color:'var(--blue)',fontWeight:600}}>Lịch học trong tuần</div><div style={{fontSize:'32px',fontWeight:800,color:'var(--blue)',margin:'6px 0'}}>10</div><a className="link" onClick={() => setPage('lich-tuan')}>Xem chi tiết</a></div></div><div className="card" style={{border:'1px solid #fed7aa'}}><div className="card-body" style={{padding:'14px'}}><div style={{fontSize:'12px',color:'var(--orange)',fontWeight:600}}>Lịch thi trong tuần</div><div style={{fontSize:'32px',fontWeight:800,color:'var(--orange)',margin:'6px 0'}}>0</div><a className="link" style={{color:'var(--orange)'}} onClick={() => setPage('lich-tuan')}>Xem chi tiết</a></div></div></div>
          <div className="card"><div className="card-body"><h3 style={{fontSize:'14px',fontWeight:700,marginBottom:'10px'}}>Thông báo gần đây</h3><div>{notifData.slice(0,3).map((n,i)=><div key={i} style={{padding:'8px',background:'#fff8f0',borderRadius:'6px',marginBottom:'8px',borderLeft:'3px solid var(--orange)'}}><div style={{fontSize:'12px',fontWeight:600,color:'var(--orange)'}}>{n.title}</div><div style={{fontSize:'11px',color:'var(--text-light)',marginTop:'2px'}}>{n.date}</div></div>)}</div></div></div>
        </div>
      </div>
    </div>
  );
}

export function ThongTinSV() {
  return (
    <div className="page active"><div className="page-title">Thông tin sinh viên</div><div className="card"><div className="card-body"><div style={{display:'flex',gap:'24px'}}><div style={{textAlign:'center',flexShrink:0}}><div style={{width:'100px',height:'100px',borderRadius:'50%',background:'linear-gradient(135deg,#1a6fb5,#60a5fa)',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontSize:'32px',fontWeight:700,margin:'0 auto 8px'}}>NT</div><div style={{fontSize:'12px',color:'var(--text-light)'}}>MSSV: 2001230773</div><div style={{fontSize:'13px',fontWeight:600}}>Nguyễn Thành Tài</div></div><div style={{flex:1}}><h3 style={{fontSize:'15px',fontWeight:700,color:'var(--blue)',marginBottom:'12px'}}>Thông tin học vấn</h3><div style={{display:'grid',gridTemplateColumns:'1fr 1fr 1fr',gap:'6px 0'}}><div className="info-row"><span className="lbl">Trang thái:</span><span className="val">Đang học</span></div><div className="info-row"><span className="lbl">Lớp học:</span><span className="val">14DHTH05</span></div><div className="info-row"><span className="lbl">Ngành:</span><span className="val">Công nghệ thông tin</span></div></div></div></div><hr style={{margin:'20px 0',borderColor:'#f0f2f5'}}/><h3 style={{fontSize:'15px',fontWeight:700,color:'var(--blue)',marginBottom:'12px'}}>Thông tin cá nhân</h3><div style={{display:'grid',gridTemplateColumns:'1fr 1fr 1fr 1fr',gap:'8px 0'}}><div className="info-row"><span className="lbl">Ngày sinh:</span><span className="val">14/10/2005</span></div><div className="info-row"><span className="lbl">Điện thoại:</span><span className="val">0779688379</span></div><div className="info-row"><span className="lbl">Email:</span><span className="val">ntai8448@gmail.com</span></div></div></div></div></div>
  );
}

export function NhacNho() {
  return (
    <div className="page active"><div className="page-title-bar"><div className="page-title" style={{margin:0}}>Ghi chú nhắc nhở</div></div><div className="card"><div className="card-body" style={{padding:0}}>
      {notifData.map((n,i) => (<div key={i} style={{padding:'14px 20px',borderBottom:'1px solid #f0f2f5',display:'flex',justifyContent:'space-between',alignItems:'flex-start'}}><div><div style={{fontWeight:600,color:n.urgent?'var(--orange)':'var(--blue)',fontSize:'13px'}}>{n.title} <span style={{color:'var(--red)'}}>- {n.date}</span></div>{n.desc && <div style={{fontSize:'12px',color:'var(--text-light)',marginTop:'4px'}}>{n.desc}</div>}</div><a className="link" style={{whiteSpace:'nowrap',marginLeft:'16px',fontSize:'12px'}}>Xem chi tiết</a></div>))}
    </div></div></div>
  );
}

export function KhaoSat() {
  const [tab, setTab] = useState('da');
  return (
    <div className="page active"><div className="page-title">Khảo sát sự kiện</div><div className="tabs"><div className={`tab-btn ${tab==='chua'?'active':''}`} onClick={()=>setTab('chua')}>Danh sách phiếu chưa khảo sát</div><div className={`tab-btn ${tab==='da'?'active':''}`} onClick={()=>setTab('da')}>Danh sách phiếu đã khảo sát</div></div>
      {tab === 'da' ? surveyData.map((s,i) => (<div key={i} style={{padding:'14px 20px',borderBottom:'1px solid #f0f2f5'}}><a className="link" style={{fontWeight:600,fontSize:'13px'}}>{i+1}. {s.code} {s.title} <span style={{color:'var(--red)'}}>({s.tag}) ({s.required})</span></a><div style={{fontSize:'12px',color:'var(--text-light)',marginTop:'4px'}}>Giảng viên: <strong>{s.gv}</strong></div></div>)) : <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)',padding:'40px'}}>Không có phiếu chưa khảo sát</div></div>}
    </div>
  );
}

export function KetQuaHT() {
  return (
    <div className="page active"><div className="page-title-bar"><div className="page-title" style={{margin:0}}>Kết quả học tập</div></div><div className="card" style={{marginBottom:'16px',overflowX:'auto'}}><table className="tbl" style={{minWidth:'900px'}}><tbody>
      <tr><th rowSpan="3">STT</th><th rowSpan="3">Mã môn học</th><th rowSpan="3">Tên môn học/học phần</th><th rowSpan="3">Lớp dự kiến</th><th rowSpan="3">Số tín chỉ</th><th colSpan="2">Giữa kỳ</th><th colSpan="5">Thường xuyên LT Hệ số 1</th><th colSpan="2">TL/BTL</th><th rowSpan="3">TB thực</th></tr><tr><th>1</th><th>2</th><th>1</th><th>6</th><th>7</th><th>8</th><th>9</th><th>Tiểu luận 1</th><th>Tiểu luận 2</th></tr><tr><th colSpan="10"></th></tr>
      <tr><td>1</td><td>101966</td><td>Ảo hóa và điện toán đám mây</td><td>14DHBM01</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>9,10</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>9,1</td></tr>
      <tr><td>2</td><td>002921</td><td>Lập trình web</td><td>14DHTH03</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>10,00</td><td></td><td style={{fontWeight:700,color:'var(--green)'}}>10,0</td></tr>
    </tbody></table></div><div className="card" style={{marginBottom:'16px'}}><div className="card-body"><div style={{display:'flex',gap:'20px',fontSize:'13px',flexWrap:'wrap'}}><div>Điểm trung bình học kỳ hệ 10: <strong style={{color:'var(--blue)'}}>8,87</strong></div><div>Điểm trung bình tích lũy: <strong style={{color:'var(--blue)'}}>8,29</strong></div><div>Tổng số tín chỉ tích lũy: <strong style={{color:'var(--blue)'}}>85</strong></div></div></div></div></div>
  );
}

export function LichTuan() { return <div className="page active"><div className="page-title">Lịch học, lịch thi theo tuần</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px'}}>Dữ liệu Lịch theo tuần</div></div></div>; }
export function LichTienDo() { return <div className="page active"><div className="page-title">Lịch học, lịch thi theo tiến độ</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px'}}>Dữ liệu Lịch theo tiến độ</div></div></div>; }
export function DiemDanh() { return <div className="page active"><div className="page-title">Thông tin điểm danh</div><div className="card"><table className="tbl"><tbody><tr><th>Môn học/học phần</th><th>TC</th><th>Số tiết nghỉ không phép</th></tr><tr><td>Thực hành phân tích thiết kế hệ thống</td><td>1</td><td style={{color:'var(--red)',fontWeight:700}}>5</td></tr></tbody></table></div></div>; }
export function RenLuyen() { return <div className="page active"><div className="page-title">Kết quả rèn luyện</div><div className="card"><table className="tbl"><tbody><tr><th>HK1 (2025 - 2026)</th><th>Điểm rèn luyện</th><th>85,00 (Tốt)</th></tr></tbody></table></div></div>; }
export function HocBong() { return <div className="page active"><div className="page-title">Mức học bổng được xét</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px',color:'var(--text-light)'}}>Không có dữ liệu hiển thị</div></div></div>; }
export function CTKhung() { return <div className="page active"><div className="page-title">Chương trình khung</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px'}}>Dữ liệu CT Khung</div></div></div>; }

export function CongNo() {
  const [tab, setTab] = useState('hp');
  return (
    <div className="page active"><div className="page-title-bar"><div className="page-title" style={{margin:0}}>Tra cứu công nợ</div></div>
      <div className="tabs"><div className={`tab-btn ${tab==='hp'?'active':''}`} onClick={()=>setTab('hp')}>Học phí</div><div className={`tab-btn ${tab==='mhdk'?'active':''}`} onClick={()=>setTab('mhdk')}>Môn học đăng ký</div><div className={`tab-btn ${tab==='kht'?'active':''}`} onClick={()=>setTab('kht')}>Danh sách khấu trừ</div></div>
      {tab==='hp' ? <div className="card"><div className="card-body">Tổng nộp học phí: <strong style={{color:'var(--red)'}}>102,880,250</strong><br/>Tổng công nợ học phí: <strong style={{color:'var(--blue)'}}>0</strong></div></div> : <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)'}}>Không có dữ liệu</div></div>}
    </div>
  );
}

export function TTTrucTuyen() { return <div className="page active"><div className="page-title">Thanh toán trực tuyến</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px'}}>Thanh toán online</div></div></div>; }
export function PhieuThuTH() { return <div className="page active"><div className="page-title">Phiếu thu tổng hợp</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px'}}>Danh sách phiếu thu</div></div></div>; }
export function PhieuThuTT() { return <div className="page active"><div className="page-title">Phiếu thu trực tuyến</div><div className="card"><div className="card-body" style={{textAlign:'center',padding:'40px'}}>Phiếu thu trực tuyến</div></div></div>; }

// Component hiển thị thông báo cho các trang đang cập nhật
export function DefaultPage({ title }) {
  return <div className="page active"><div className="page-title">{title}</div><div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)',padding:'40px'}}>Đang cập nhật...</div></div></div>;
}