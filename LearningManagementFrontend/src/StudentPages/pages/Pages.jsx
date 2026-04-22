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

export function ThongTinSV() {
  return (
    <div className="page active">
      <div className="page-title">Thông tin sinh viên</div>
      <div className="card"><div className="card-body">
        <div style={{display:'flex',gap:'24px'}}>
          <div style={{textAlign:'center',flexShrink:0}}>
            <div style={{width:'100px',height:'100px',borderRadius:'50%',background:'linear-gradient(135deg,#1a6fb5,#60a5fa)',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontSize:'32px',fontWeight:700,margin:'0 auto 8px'}}>NT</div>
            <div style={{fontSize:'12px',color:'var(--text-light)'}}>MSSV: 2001230773</div>
            <div style={{fontSize:'13px',fontWeight:600}}>Nguyễn Thành Tài</div>
            <div style={{fontSize:'12px',color:'var(--text-light)'}}>Giới tính: Nam</div>
          </div>
          <div style={{flex:1}}>
            <h3 style={{fontSize:'15px',fontWeight:700,color:'var(--blue)',marginBottom:'12px'}}>Thông tin học vấn</h3>
            <div style={{display:'grid',gridTemplateColumns:'1fr 1fr 1fr',gap:'6px 0'}}>
              <div className="info-row"><span className="lbl">Trang thái:</span><span className="val">Đang học</span></div>
              <div className="info-row"><span className="lbl">Mã hồ sơ:</span><span className="val">2001230773</span></div>
              <div className="info-row"><span className="lbl">Ngày vào trường:</span><span className="val">26/8/2023</span></div>
              <div className="info-row"><span class="lbl">Lớp học:</span><span className="val">14DHTH05</span></div>
              <div className="info-row"><span className="lbl">Cơ sở:</span><span className="val">ĐHCT TP.HCM</span></div>
              <div className="info-row"></div>
              <div className="info-row"><span className="lbl">Bậc đào tạo:</span><span className="val">Đại học</span></div>
              <div className="info-row"><span className="lbl">Loại hình đào tạo:</span><span className="val">Chính quy</span></div>
              <div className="info-row"></div>
              <div className="info-row"><span className="lbl">Khoa:</span><span className="val">Khoa Công nghệ Thông tin</span></div>
              <div className="info-row"><span className="lbl">Ngành:</span><span className="val">Công nghệ thông tin</span></div>
              <div className="info-row"></div>
              <div className="info-row"><span className="lbl">Chuyên ngành:</span><span className="val">Công nghệ phần mềm</span></div>
              <div className="info-row"><span className="lbl">Khóa học:</span><span className="val">2023</span></div>
            </div>
          </div>
        </div>
        <hr style={{margin:'20px 0',borderColor:'#f0f2f5'}}/>
        <h3 style={{fontSize:'15px',fontWeight:700,color:'var(--blue)',marginBottom:'12px'}}>Thông tin cá nhân</h3>
        <div style={{display:'grid',gridTemplateColumns:'1fr 1fr 1fr 1fr',gap:'8px 0'}}>
          <div className="info-row"><span className="lbl">Ngày sinh:</span><span className="val">14/10/2005</span></div>
          <div className="info-row"><span className="lbl">Dân tộc:</span><span className="val">Kinh</span></div>
          <div className="info-row"><span className="lbl">Tôn giáo:</span><span className="val">Phật Giáo</span></div>
          <div className="info-row"><span className="lbl">Quốc tịch:</span><span className="val">Việt Nam</span></div>
          <div className="info-row"><span className="lbl">Số CCCD:</span><span className="val">095205000035</span></div>
          <div className="info-row"><span className="lbl">Ngày cấp:</span><span className="val">31/05/2021</span></div>
          <div className="info-row"><span className="lbl">Nơi cấp:</span><span className="val">TP Hồ Chí Minh</span></div>
          <div className="info-row"></div>
          <div className="info-row"><span className="lbl">Điện thoại:</span><span className="val">0779688379</span></div>
          <div className="info-row"><span className="lbl">Email:</span><span className="val">ntai8448@gmail.com</span></div>
          <div className="info-row"><span className="lbl">Nơi sinh:</span><span className="val">Cà Mau</span></div>
          <div className="info-row"></div>
          <div className="info-row" style={{gridColumn:'1/-1'}}><span className="lbl">Hộ khẩu thường trú:</span><span className="val">Khu phố Hải Hồ 2, Thị trấn Long Hải, Huyện Long Điền, Tỉnh Bà Rịa - Vũng Tàu</span></div>
        </div>
      </div></div>
    </div>
  );
}

export function NhacNho() {
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Ghi chú nhắc nhở</div>
        <div style={{display:'flex',alignItems:'center',gap:'10px'}}>
          <span style={{fontSize:'13px',fontWeight:500}}>Lọc bản tin</span>
          <select className="form-ctrl" style={{width:'160px'}}>
            <option>Tất cả</option><option>Lịch học</option><option>Thông báo</option>
          </select>
        </div>
      </div>
      <div className="card"><div className="card-body" style={{padding:0}}>
        {notifData.map((n,i) => (
          <div key={i} style={{padding:'14px 20px',borderBottom:'1px solid #f0f2f5',display:'flex',justifyContent:'space-between',alignItems:'flex-start'}}>
            <div>
              <div style={{fontWeight:600,color:n.urgent?'var(--orange)':'var(--blue)',fontSize:'13px'}}>{n.title} <span style={{color:'var(--red)'}}>- {n.date}</span></div>
              {n.desc && <div style={{fontSize:'12px',color:'var(--text-light)',marginTop:'4px'}}>{n.desc}</div>}
            </div>
            <a className="link" style={{whiteSpace:'nowrap',marginLeft:'16px',fontSize:'12px',cursor:'pointer'}}>Xem chi tiết</a>
          </div>
        ))}
      </div></div>
    </div>
  );
}

export function KhaoSat() {
  const [tab, setTab] = useState('da');
  return (
    <div className="page active">
      <div className="page-title">Khảo sát sự kiện</div>
      <div className="tabs">
        <div className={`tab-btn ${tab==='chua'?'active':''}`} onClick={()=>setTab('chua')}>Danh sách phiếu chưa khảo sát</div>
        <div className={`tab-btn ${tab==='da'?'active':''}`} onClick={()=>setTab('da')}>Danh sách phiếu đã khảo sát</div>
      </div>
      {tab === 'da' ? surveyData.map((s,i) => (
        <div key={i} style={{padding:'14px 20px',borderBottom:'1px solid #f0f2f5', background:'white'}}>
          <a className="link" style={{fontWeight:600,fontSize:'13px',cursor:'pointer'}}>{i+1}. {s.code} {s.title} <span style={{color:'var(--red)'}}>({s.tag}) ({s.required})</span></a>
          <div style={{fontSize:'12px',color:'var(--text-light)',marginTop:'4px'}}>Giảng viên: <strong>{s.gv}</strong></div>
        </div>
      )) : (
        <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)',padding:'40px'}}>Không có phiếu chưa khảo sát</div></div>
      )}
    </div>
  );
}

export function KetQuaHT() {
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Kết quả học tập</div>
        <button className="btn btn-blue" onClick={() => alert('Đang tính toán...')}>Xét thử TN</button>
      </div>

      <div className="card" style={{marginBottom:'16px'}}>
        <div style={{background:'#fffde7',padding:'10px 16px',fontWeight:700,color:'#b45309',fontSize:'13px',borderBottom:'1px solid var(--border)'}}>CHUẨN ĐẦU RA</div>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Loại chứng chỉ</th><th>Theo quy định</th><th>Đã nộp</th><th>Xác nhận</th></tr>
            <tr><td>1</td><td>Chuẩn năng lực Ngoại ngữ</td><td>NN_Tương đương Bậc 3 theo khung NL 6 bậc của VN</td><td></td><td style={{color:'#e85d75'}}>Chưa hoàn tất</td></tr>
            <tr><td>2</td><td>Chứng chỉ Giáo dục nghề nghiệp...</td><td>CC Giáo dục nghề nghiệp và Công tác Xã hội</td><td>CC Giáo dục nghề nghiệp...</td><td style={{color:'var(--green)'}}>Hoàn tất</td></tr>
            <tr><td>3</td><td>Đánh giá chuẩn đầu ra chương trình...</td><td>Chuẩn đầu ra chương trình đào tạo ĐH</td><td></td><td style={{color:'#e85d75'}}>Chưa hoàn tất</td></tr>
            <tr><td>4</td><td>Đối chiếu bằng</td><td>Đối chiếu bằng tốt nghiệp THPT, hoặc CĐ</td><td>Đối chiếu bằng tốt nghiệp...</td><td style={{color:'var(--green)'}}>Hoàn tất</td></tr>
          </tbody>
        </table>
      </div>

      <div className="card" style={{marginBottom:'16px',overflowX:'auto'}}>
        <table className="tbl" style={{minWidth:'900px'}}>
          <tbody>
            <tr>
              <th rowSpan="3">STT</th><th rowSpan="3">Mã môn học</th><th rowSpan="3">Tên môn học/học phần</th>
              <th rowSpan="3">Lớp dự kiến</th><th rowSpan="3">Số TC</th>
              <th colSpan="2" style={{textAlign:'center'}}>Giữa kỳ</th><th colSpan="5" style={{textAlign:'center'}}>Thường xuyên LT Hệ số 1</th>
              <th colSpan="2" style={{textAlign:'center'}}>TL/BTL</th><th rowSpan="3">TB thực</th>
            </tr>
            <tr>
              <th style={{textAlign:'center'}}>1</th><th style={{textAlign:'center'}}>2</th>
              <th style={{textAlign:'center'}}>1</th><th style={{textAlign:'center'}}>6</th><th style={{textAlign:'center'}}>7</th><th style={{textAlign:'center'}}>8</th><th style={{textAlign:'center'}}>9</th>
              <th style={{textAlign:'center'}}>Tiểu luận 1</th><th style={{textAlign:'center'}}>Tiểu luận 2</th>
            </tr>
            <tr><th colSpan="10"></th></tr>
            <tr><td>1</td><td>101966</td><td>Ảo hóa và điện toán đám mây</td><td>14DHBM01</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>9,10</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>9,1</td></tr>
            <tr><td>2</td><td>101963</td><td>Công nghệ phần mềm</td><td>14DHTH15</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>8,80</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>8,8</td></tr>
            <tr><td>3</td><td>101968</td><td>Hệ quản trị cơ sở dữ liệu</td><td>14DHTH06</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>9,20</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>9,2</td></tr>
            <tr><td>4</td><td>101979</td><td>Xử lý ảnh</td><td>14DHTH15</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>8,40</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>8,4</td></tr>
            <tr><td>5</td><td>006237</td><td>Trí tuệ nhân tạo</td><td>14DHTH06</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>8,70</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>8,7</td></tr>
            <tr><td>6</td><td>002921</td><td>Lập trình web</td><td>14DHTH03</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>10,00</td><td></td><td style={{fontWeight:700,color:'var(--green)'}}>10,0</td></tr>
            <tr><td>7</td><td>101040</td><td>Thực hành Trí tuệ nhân tạo</td><td>14DHBM02</td><td>1</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
          </tbody>
        </table>
      </div>

      <div className="card" style={{marginBottom:'16px'}}>
        <div className="card-body">
          <div style={{display:'flex',gap:'20px',fontSize:'13px',flexWrap:'wrap'}}>
            <div>Điểm TB học kỳ hệ 10: <strong style={{color:'var(--blue)'}}>8,87</strong></div>
            <div>Điểm TB học kỳ hệ 4: <strong style={{color:'var(--blue)'}}>3,92</strong></div>
            <div>Điểm TB tích lũy: <strong style={{color:'var(--blue)'}}>8,29</strong></div>
            <div>Điểm TB tích lũy (hệ 4): <strong style={{color:'var(--blue)'}}>3,54</strong></div>
            <div>Tổng số tín chỉ tích lũy: <strong style={{color:'var(--blue)'}}>85</strong></div>
            <div>Xử lý học vụ: <strong>Học tiếp</strong></div>
          </div>
        </div>
      </div>

      <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:0}}>
        <div className="card" style={{borderRight:'none',borderRadius:'8px 0 0 8px'}}>
          <div className="card-body">
            <h4 style={{fontSize:'13px',fontWeight:700,marginBottom:'8px'}}>Tính theo thực học</h4>
            <div style={{display:'grid',gridTemplateColumns:'1fr auto',gap:'4px',fontSize:'13px'}}>
              <span>Tổng tín chỉ:</span><strong>119</strong>
              <span>Trung bình chung tích lũy:</span><strong>8,25 - 3,51</strong>
              <span>Xếp loại tốt nghiệp:</span><strong></strong>
            </div>
          </div>
        </div>
        <div className="card" style={{borderRadius:'0 8px 8px 0'}}>
          <div className="card-body">
            <h4 style={{fontSize:'13px',fontWeight:700,marginBottom:'8px'}}>Tính theo chương trình khung</h4>
            <div style={{display:'grid',gridTemplateColumns:'1fr auto',gap:'4px',fontSize:'13px'}}>
              <span>Tổng tín chỉ:</span><strong>88</strong>
              <span>Trung bình chung tích lũy:</span><strong>8,25 - 3,51</strong>
              <span>Số tín chỉ phải tích lũy:</span><strong style={{color:'var(--red)'}}>151</strong>
            </div>
          </div>
        </div>
      </div>
      <div style={{fontSize:'12px',color:'var(--red)',marginTop:'10px',padding:'10px',background:'#fff',borderRadius:'6px',border:'1px solid var(--border)'}}>
        <strong>Ghi chú:</strong> Điểm Giáo dục quốc phòng - an ninh 1, Giáo dục thể chất 1 (võ thuật), Giáo dục quốc phòng - an ninh 2... không tính vào Trung bình chung tích lũy
      </div>
    </div>
  );
}

export function LichTuan() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Lịch học, lịch thi theo tuần</div>
        <div style={{display:'flex',alignItems:'center',gap:'8px',flexWrap:'wrap'}}>
          <div style={{display:'flex',gap:'12px',fontSize:'12px'}}>
            <label><input type="radio" name="lt" defaultChecked /> Tất cả</label>
            <label><input type="radio" name="lt" /> Lịch học</label>
            <label><input type="radio" name="lt" /> Lịch thi</label>
          </div>
          <input type="date" className="form-ctrl" style={{width:'150px'}} defaultValue="2026-03-28" />
          <button className="btn btn-blue btn-sm">Hiện tại</button>
          <button className="btn btn-outline btn-sm">In lịch</button>
          <button className="btn btn-outline btn-sm">‹ Trở về</button>
          <button className="btn btn-blue btn-sm">Tiếp ›</button>
        </div>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="week-tbl">
          <tbody>
            <tr>
              <th style={{width:'70px'}}>Ca học</th>
              <th><div style={{fontWeight:700}}>Thứ 2</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>23/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 3</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>24/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 4</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>25/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 5</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>26/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 6</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>27/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 7</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>28/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Chủ nhật</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>29/03/2026</div></th>
            </tr>
            <tr>
              <td className="ca">Sáng</td>
              <td>
                <div className="sched-gray">
                  <strong>Sinh hoạt giữa khóa năm 3</strong><br/>
                  SINHHOATGIUAKHOA - 010109728801<br/>Tiết: 2 - 3<br/>
                  Phòng: HT.C (Hội trường C - Tầng 4 dãy nhà C) - 140 Lê Trọng Tấn<br/>
                  GV: Hồ Thanh Trí
                </div>
                <div className="sched-gray" style={{marginTop:'4px'}}>
                  <strong>Sinh hoạt giữa khóa năm 3</strong><br/>
                  Tiết: 4 - 6 | GV: Vũ Đức Thịnh
                </div>
              </td>
              <td>
                <div className="sched-green">
                  <strong>Công Nghệ Java</strong><br/>
                  14DHTH12 - 010100000204<br/>Tiết: 2 – 6<br/>
                  Phòng: A202 - Phòng máy tính - 140 Lê Trọng Tấn<br/>
                  GV: Nguyễn Thị Thu Hồng
                </div>
              </td>
              <td></td><td></td>
              <td>
                <div className="sched-blue">
                  <strong>Khai phá dữ liệu</strong><br/>
                  14DHTH14 - 0110110197014<br/>Tiết: 1 – 3<br/>
                  Phòng: A301 - 140 Lê Trọng Tấn<br/>
                  GV: Phùng Thế Bảo
                </div>
              </td>
              <td></td><td></td>
            </tr>
            <tr>
              <td className="ca">Chiều</td>
              <td></td>
              <td>
                <div className="sched-green">
                  <strong>Lập trình di động</strong><br/>
                  14DHTH10 - 0110110196910<br/>Tiết: 7 – 11<br/>GV: ...
                </div>
              </td>
              <td>
                <div className="sched-blue">
                  <strong>Deep learning</strong><br/>
                  14DHTH04 - 0110110195604<br/>Tiết: 10 – 12<br/>GV: TS. Phùng Thế Bảo
                </div>
              </td>
              <td>
                <div className="sched-green">
                  <strong>Thực hành phân tích thiết kế hệ thống</strong><br/>
                  14DHTH10 - ...<br/>Tiết: 7 – 9
                </div>
              </td>
              <td>
                <div className="sched-blue">
                  <strong>Quản trị hệ thống mạng</strong><br/>
                  14DHTH04 - 0110110197304<br/>Tiết: 7 – 9
                </div>
              </td>
              <td></td><td></td>
            </tr>
            <tr>
              <td className="ca">Tối</td>
              <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>
          </tbody>
        </table>
        <div style={{padding:'10px 12px',display:'flex',gap:'16px',fontSize:'11px',borderTop:'1px solid var(--border)'}}>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#d1fae5',borderLeft:'3px solid #22c55e',display:'inline-block'}}></span>Lịch dạy lý thuyết</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#dbeafe',borderLeft:'3px solid #3b82f6',display:'inline-block'}}></span>Lịch dạy thực hành</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#fff7ed',borderLeft:'3px solid #f97316',display:'inline-block'}}></span>Lịch trực tuyến</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#f1f5f9',borderLeft:'3px solid #94a3b8',display:'inline-block'}}></span>Lịch coi thi</span>
        </div>
      </div>
    </div>
  ); 
}

export function LichTienDo() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Lịch học, lịch thi theo tiến độ</div>
        <div style={{display:'flex',alignItems:'center',gap:'8px'}}>
          <div style={{display:'flex',gap:'12px',fontSize:'12px'}}>
            <label><input type="radio" name="ltd" defaultChecked /> Tất cả</label>
            <label><input type="radio" name="ltd" /> Lịch học</label>
            <label><input type="radio" name="ltd" /> Lịch thi</label>
          </div>
          <select className="form-ctrl" style={{width:'160px'}}><option>HK2 (2025 - 2026)</option></select>
          <button className="btn btn-blue btn-sm">Xem lịch</button>
          <button className="btn btn-outline btn-sm">🖨 In lịch</button>
        </div>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl" style={{minWidth:'900px'}}>
          <tbody>
            <tr><th>STT</th><th>Mã học phần</th><th>Tên môn học/học phần</th><th>Số TC</th><th>Thứ</th><th>Tiết</th><th>Loại lịch</th><th>Phòng</th><th>Nhóm</th><th>Giờ</th><th>Bắt đầu</th><th>Kết thúc</th><th>Mã giảng viên</th><th>Giảng viên</th></tr>
            <tr><td>1</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td></td><td></td><td>Lý thuyết</td><td></td><td></td><td></td><td>12/01/2026</td><td>05/07/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>2</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td>3</td><td>2 - 6</td><td>Lý thuyết</td><td>A202 - Phòng máy tính - 140 Lê Trọng Tấn</td><td></td><td></td><td>13/01/2026</td><td>27/01/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>3</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td>3</td><td>2 - 6</td><td>Thực hành</td><td>A202 - Phòng máy tính - 140 Lê Trọng Tấn</td><td></td><td></td><td>03/02/2026</td><td>02/06/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>4</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td>5</td><td>2 - 6</td><td>Thực hành</td><td>A202 - Phòng máy tính - 140 Lê Trọng Tấn</td><td></td><td></td><td>07/05/2026</td><td>07/05/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>5</td><td>0101101956</td><td>Deep learning</td><td>3</td><td></td><td></td><td>Lý thuyết</td><td></td><td></td><td></td><td>12/01/2026</td><td>05/07/2026</td><td>01001048</td><td>TS. Phùng Thế Bảo</td></tr>
            <tr><td>6</td><td>0101101956</td><td>Deep learning</td><td>3</td><td>3</td><td>10 - 12</td><td>Lý thuyết</td><td>A303 - 140 Lê Trọng Tấn</td><td></td><td></td><td>13/01/2026</td><td>09/06/2026</td><td>01001048</td><td>ThS. Hồ Hải Quân, TS. Phùng Thế Bảo</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}

export function DiemDanh() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Thông tin điểm danh</div>
        <div style={{display:'flex',gap:'8px'}}><button className="btn-icon">📷</button><button className="btn-icon">⛶</button></div>
      </div>
      <div className="card"><table className="tbl">
        <tbody>
          <tr><th>STT</th><th>Mã lớp học phần</th><th>Tên môn học/học phần</th><th>TC</th><th>Số tiết nghỉ có phép</th><th>Số tiết nghỉ không phép</th></tr>
          <tr className="section-row"><td colSpan="6">HK1 (2023 - 2024)</td></tr>
          <tr className="section-row"><td colSpan="6">HK2 (2023 - 2024)</td></tr>
          <tr className="section-row"><td colSpan="6">HK1 (2024 - 2025)</td></tr>
          <tr className="section-row"><td colSpan="6">HK2 (2024 - 2025)</td></tr>
          <tr className="section-row"><td colSpan="6">HK1 (2025 - 2026)</td></tr>
          <tr className="section-row"><td colSpan="6">HK2 (2025 - 2026)</td></tr>
          <tr><td>1</td><td>010110197602</td><td>Phân tích thiết kế hệ thống</td><td>2</td><td>0</td><td>0</td></tr>
          <tr><td>2</td><td>010110197304</td><td>Quản trị hệ thống mạng</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>3</td><td>010110197405</td><td>Thực hành quản trị hệ thống mạng</td><td>1</td><td>0</td><td>0</td></tr>
          <tr><td>4</td><td>010110197720</td><td>Thực hành phân tích thiết kế hệ thống</td><td>1</td><td>0</td><td style={{color:'var(--red)',fontWeight:700}}>5</td></tr>
          <tr><td>5</td><td>010100000204</td><td>Công Nghệ Java</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>6</td><td>010110197014</td><td>Khai phá dữ liệu</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>7</td><td>010109729017</td><td>Sinh hoạt giữa khóa năm 3 gặp khoa chuyên ngành</td><td>0</td><td>0</td><td>0</td></tr>
          <tr><td>8</td><td>010110195604</td><td>Deep learning</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>9</td><td>010110195705</td><td>Thực hành deep learning</td><td>1</td><td>0</td><td>0</td></tr>
          <tr><td>10</td><td>010110196910</td><td>Lập trình di động</td><td>3</td><td>0</td><td>0</td></tr>
          <tr><td>11</td><td>010109728801</td><td>Sinh hoạt giữa khóa năm 3</td><td>0</td><td>0</td><td>0</td></tr>
          <tr style={{background:'#f0f6ff'}}><td colSpan="3" style={{textAlign:'center',fontWeight:700,color:'var(--blue)'}}>TỔNG:</td><td></td><td style={{textAlign:'center',fontWeight:700,color:'var(--blue)'}}>0</td><td style={{textAlign:'center',fontWeight:700,color:'var(--red)'}}>5</td></tr>
        </tbody>
      </table></div>
    </div>
  ); 
}

export function RenLuyen() { 
  return (
    <div className="page active">
      <div className="page-title">Kết quả rèn luyện</div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Ngày vi phạm</th><th>Nội dung</th><th>Hình thức</th><th>Ghi chú</th><th>Điểm Cộng/Trừ</th></tr>
            <tr className="section-row"><td colSpan="6">HK1 (2023 - 2024)</td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Điểm rèn luyện</td><td>70,00</td><td></td><td></td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Xếp loại</td><td>Khá</td><td></td><td></td></tr>
            <tr className="section-row"><td colSpan="6">HK2 (2023 - 2024)</td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Điểm rèn luyện</td><td>79,00</td><td></td><td></td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Xếp loại</td><td>Khá</td><td></td><td></td></tr>
            <tr className="section-row"><td colSpan="6">HK1 (2024 - 2025)</td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Điểm rèn luyện</td><td>101,00</td><td></td><td></td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Xếp loại</td><td style={{color:'var(--green)',fontWeight:600}}>Xuất sắc</td><td></td><td></td></tr>
            <tr className="section-row"><td colSpan="6">HK2 (2024 - 2025)</td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Điểm rèn luyện</td><td>83,00</td><td></td><td></td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Xếp loại</td><td>Tốt</td><td></td><td></td></tr>
            <tr className="section-row"><td colSpan="6">HK1 (2025 - 2026)</td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Điểm rèn luyện</td><td>85,00</td><td></td><td></td></tr>
            <tr><td></td><td></td><td style={{color:'var(--orange)',fontWeight:600}}>Xếp loại</td><td>Tốt</td><td></td><td></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}

export function HocBong() { 
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

export function CTKhung() { 
  return (
    <div className="page active">
      <div className="page-title">Chương trình khung</div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl" style={{minWidth:'800px'}}>
          <tbody>
            <tr><th>STT</th><th>Tên môn học/Học phần</th><th>Mã Học phần</th><th>Học phần</th><th>Số TC</th><th>Số tiết LT</th><th>Số tiết TH</th><th>Nhóm tự chọn</th><th>Số TC bắt buộc của nhóm</th><th>Đạt</th></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 1 &nbsp;&nbsp;&nbsp; <strong>16 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 2 &nbsp;&nbsp;&nbsp; <strong>16 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 3 &nbsp;&nbsp;&nbsp; <strong>17 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 4 &nbsp;&nbsp;&nbsp; <strong>17 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 5 &nbsp;&nbsp;&nbsp; <strong>19 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 6 &nbsp;&nbsp;&nbsp; <strong>20 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học kỳ 7 &nbsp;&nbsp;&nbsp; <strong>16 TC</strong></td></tr>
            <tr className="section-row"><td colSpan="10">Học phần bắt buộc &nbsp;&nbsp;&nbsp; <strong>12 TC</strong></td></tr>
            <tr><td>1</td><td>Nhập môn Big Data</td><td>0101101971</td><td></td><td>2</td><td>30</td><td>0</td><td>0</td><td></td><td></td></tr>
            <tr><td>2</td><td>Thực hành nhập môn Big data</td><td>0101101972</td><td></td><td>1</td><td>0</td><td>30</td><td>0</td><td></td><td></td></tr>
            <tr><td>3</td><td>Internet of Things</td><td>0101101975</td><td></td><td>3</td><td>45</td><td>0</td><td>0</td><td></td><td></td></tr>
            <tr className="red-row"><td>4</td><td>Thực tập nghề nghiệp</td><td>0101102007</td><td></td><td>2</td><td>0</td><td>60</td><td>0</td><td></td><td></td></tr>
            <tr className="red-row"><td>5</td><td>Khóa luận cử nhân</td><td>0101102008</td><td></td><td>4</td><td>0</td><td>0</td><td>0</td><td></td><td></td></tr>
            <tr className="section-row"><td colSpan="10">Học phần tự chọn &nbsp;&nbsp;&nbsp; <strong>4 TC</strong></td></tr>
            <tr><td colSpan="10" style={{color:'var(--red)',fontSize:'12px',fontWeight:600}}>Ghi chú: Học phần tự chọn (sinh viên học đủ số tín chỉ bắt buộc của từng nhóm tự chọn...)</td></tr>
            <tr><td>6</td><td>Lập trình mã nguồn mở</td><td>0101101978</td><td></td><td>2</td><td>0</td><td>60</td><td>1</td><td>4</td><td></td></tr>
            <tr><td>7</td><td>Dữ liệu NoSQL</td><td>0101101981</td><td></td><td>2</td><td>0</td><td>60</td><td>1</td><td>4</td><td></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}

export function CongNo() {
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
            <tr><td>2</td><td>2023-2024</td><td></td><td>104</td><td>BẢO HIỂM Y TẾ 15 THÁNG (10/2023 -12/2024)</td><td style={{textAlign:'right'}}>850,500</td><td style={{textAlign:'center'}}><span className="icon-x">✗</span></td><td>26/08/2023</td><td style={{textAlign:'right'}}>850,500</td><td style={{textAlign:'right'}}>0</td></tr>
            <tr><td>3</td><td>2023-2024</td><td></td><td>105</td><td>ĐỒNG PHỤC</td><td style={{textAlign:'right'}}>535,000</td><td style={{textAlign:'center'}}><span className="icon-x">✗</span></td><td>26/08/2023</td><td style={{textAlign:'right'}}>535,000</td><td style={{textAlign:'right'}}>0</td></tr>
            <tr><td>4</td><td></td><td></td><td>117</td><td>BAO HIEM Y TE 2025 12 THANG DOT 1(1/1/2025-31/12/2025)</td><td style={{textAlign:'right'}}>884,520</td><td style={{textAlign:'center'}}><span className="icon-x">✗</span></td><td>25/11/2024</td><td style={{textAlign:'right'}}>884,520</td><td style={{textAlign:'right'}}>0</td></tr>
            <tr><td>5</td><td></td><td></td><td>124</td><td>BẢO HIỂM Y TẾ 11 THÁNG NĂM 2026</td><td style={{textAlign:'right'}}>579,150</td><td style={{textAlign:'center'}}><span className="icon-x">✗</span></td><td>20/01/2026</td><td style={{textAlign:'right'}}>579,150</td><td style={{textAlign:'right'}}>0</td></tr>
            <tr style={{background:'#f8fafc'}}><td colSpan="5" style={{textAlign:'right',fontWeight:700}}></td><td style={{textAlign:'right',fontWeight:700}}>2,942,170</td><td></td><td></td><td style={{textAlign:'right',fontWeight:700}}>2,942,170</td><td style={{textAlign:'right',fontWeight:700}}>0</td></tr>
          </tbody>
        </table>
        <div style={{display:'flex',alignItems:'center',gap:'8px',padding:'8px 12px',fontSize:'12px',borderTop:'1px solid var(--border)'}}>
          <button className="btn-icon btn-sm">|◄</button>
          <button className="btn-icon btn-sm">◄</button>
          <button className="btn btn-blue btn-sm" style={{padding:'3px 10px'}}>1</button>
          <button className="btn-icon btn-sm">►</button>
          <button className="btn-icon btn-sm">►|</button>
          <select className="form-ctrl" style={{width:'60px',fontSize:'12px',padding:'2px 4px'}}><option>50</option><option>100</option></select>
          <span>mẫu tin/trang</span>
          <span style={{marginLeft:'auto'}}>1 - 5 của 5</span>
        </div>
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
                <tr><td>2</td><td>HK2 (2025 - 2026)</td><td>0101097200</td><td>010109720017</td><td>Sinh hoạt giữa khóa năm 3 gặp khoa chuyên ngành</td><td>0</td><td style={{textAlign:'right'}}>0</td><td style={{textAlign:'right'}}>0</td><td style={{textAlign:'right'}}>0</td><td style={{textAlign:'right'}}>0</td><td>Đăng ký mới</td><td></td></tr>
              </tbody>
            </table>
          </div>
          <div style={{padding:'12px 0',fontSize:'13px',display:'flex',gap:'24px',flexWrap:'wrap'}}>
            <span>Tổng nộp học phí: <strong style={{color:'var(--red)'}}>102,880,250</strong></span>
            <span>Tổng nộp khoản thu khác: <strong style={{color:'var(--red)'}}>2,942,170</strong></span>
            <span>Tổng công nợ học phí: <strong style={{color:'var(--blue)'}}>0</strong></span>
            <span>Tổng công nợ thu khác: <strong style={{color:'var(--blue)'}}>0</strong></span>
          </div>
        </div>
      )}
      {tab === 'mhdk' && <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)'}}>Không có dữ liệu</div></div>}
      {tab === 'kht' && <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)'}}>Không có dữ liệu</div></div>}
    </div>
  );
}

export function TTTrucTuyen() { 
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
            <div>3. Xem hướng dẫn thanh toán <a className="link" style={{cursor:'pointer'}}>tại đây</a></div>
            <div>4. Để hủy giao dịch chờ gạch nợ, vui lòng bấm <a className="link" style={{cursor:'pointer'}}>vào đây</a>.</div>
            <div>5. Khuyến cáo thanh toán qua <strong style={{color:'var(--red)'}}>QR-Code</strong>, thẻ ATM nội địa.</div>
          </div>
        </div>
      </div>
    </div>
  ); 
}

export function PhieuThuTH() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0, borderLeft:'4px solid var(--blue)', paddingLeft:'10px'}}>Phiếu thu tổng hợp</div>
        <button className="btn-icon">⛶</button>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Số phiếu</th><th>Mã hóa đơn</th><th>Ngày thu</th><th>Số tiền</th><th>Đơn vị thu</th><th>Loại HĐĐT</th><th>HĐDT</th><th>Chi tiết</th><th>Nhật ký</th></tr>
            <tr><td>1</td><td>193813</td><td></td><td>20/01/2026 09:35</td><td style={{textAlign:'right'}}>579,150</td><td>Ngân hàng ngoài trường 2</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">🔄</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>2</td><td>832565</td><td>C25TTP61588</td><td>30/12/2025 20:03</td><td style={{textAlign:'right'}}>17,205,000</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">☁</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr style={{background:'#fff9e6'}}><td>3</td><td>796667</td><td></td><td>10/08/2025 18:54</td><td style={{textAlign:'right'}}>2,785,000</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">🔄</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr style={{background:'#fff9e6'}}><td>4</td><td>786191</td><td></td><td>19/07/2025 10:09</td><td style={{textAlign:'right'}}>2,785,000</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">🔄</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr style={{background:'#fff9e6'}}><td>5</td><td>784429</td><td></td><td>18/07/2025 06:43</td><td style={{textAlign:'right'}}>11,280,000</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">🔄</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>6</td><td>733829</td><td>C25TTP6084</td><td>09/01/2025 07:43</td><td style={{textAlign:'right'}}>17,990,000</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">☁</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>7</td><td>160402</td><td></td><td>25/11/2024 16:24</td><td style={{textAlign:'right'}}>884,520</td><td>Ngân hàng ngoài trường</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">🔄</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>8</td><td>686110</td><td>C24TTP39947</td><td>27/07/2024 14:01</td><td style={{textAlign:'right'}}>18,363,750</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">☁</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>9</td><td>634935</td><td>C24TTP1472</td><td>11/01/2024 19:39</td><td style={{textAlign:'right'}}>16,481,500</td><td>NH Sacombank</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">☁</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>10</td><td>130752</td><td>C23TTP39465</td><td>26/08/2023 09:25</td><td style={{textAlign:'right'}}>1,478,500</td><td>Ngân hàng ngoài trường</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">🔄</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
            <tr><td>11</td><td>604265</td><td>C23TTP39465</td><td>26/08/2023 09:25</td><td style={{textAlign:'right'}}>15,990,000</td><td>Ngân hàng ngoài trường</td><td>Cá nhân</td><td><button className="btn-icon btn-sm">☁</button></td><td><button className="btn-icon btn-sm">✏️</button></td><td><button className="btn-icon btn-sm">☰</button></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}

export function PhieuThuTT() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Phiếu thu</div>
        <button className="btn btn-blue" onClick={() => alert('Đang mở trang thanh toán...')}>Tiếp tục thanh toán ›</button>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Mã đơn</th><th>Nội dung thu</th><th>Số tiền (VNĐ)</th><th>Ngày thanh toán</th><th>Đã thanh toán</th><th>Đã cập nhật công nợ</th><th>Trạng thái giao dịch</th></tr>
            <tr><td>1</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUITA71BCCCAC8324C</td><td>Thu học phí</td><td style={{textAlign:'right'}}>17,205,000</td><td>30/12/2025 19:59:45</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{color:'var(--green)',fontWeight:600}}>Thành công</td></tr>
            <tr><td>2</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUITA56B542A006B46</td><td>Thu học phí</td><td style={{textAlign:'right'}}>2,785,000</td><td>10/08/2025 18:54:09</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{color:'var(--green)',fontWeight:600}}>Thành công</td></tr>
            <tr><td>3</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT2409C62D8AF54D</td><td>Thu học phí</td><td style={{textAlign:'right'}}>2,785,000</td><td>19/07/2025 10:35:27</td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{color:'var(--red)'}}>Giao dịch đã hủy</td></tr>
            <tr><td>4</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT7760E7B1DCCB4F</td><td>Thu học phí</td><td style={{textAlign:'right'}}>2,785,000</td><td>19/07/2025 10:09:02</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{color:'var(--green)',fontWeight:600}}>Thành công</td></tr>
            <tr><td>5</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT4B7CB07905614 8</td><td>Thu học phí</td><td style={{textAlign:'right'}}>2,785,000</td><td>18/07/2025 06:44:02</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{color:'var(--red)'}}>Giao dịch đã hủy</td></tr>
            <tr><td>6</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT64F49D46FB564B</td><td>Thu học phí</td><td style={{textAlign:'right'}}>11,280,000</td><td>18/07/2025 06:41:21</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{color:'var(--green)',fontWeight:600}}>Thành công</td></tr>
            <tr><td>7</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUITE620A645E9AE4F</td><td>Thu học phí</td><td style={{textAlign:'right'}}>11,280,000</td><td>18/07/2025 06:37:35</td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{color:'var(--red)'}}>Giao dịch đã hủy</td></tr>
            <tr><td>8</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT769336180AA24F</td><td>Thu học phí</td><td style={{textAlign:'right'}}>17,990,000</td><td>09/01/2025 07:38:52</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{color:'var(--green)',fontWeight:600}}>Thành công</td></tr>
            <tr><td>9</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT4585EFAFFDBE43</td><td>Thu học phí</td><td style={{textAlign:'right'}}>18,363,750</td><td>27/07/2024 14:00:17</td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--green)',fontSize:'18px'}}>✔</span></td><td style={{color:'var(--green)',fontWeight:600}}>Thành công</td></tr>
            <tr><td>10</td><td style={{fontFamily:'monospace',fontSize:'11px'}}>HUIT6910EDF3967E41</td><td>Thu học phí</td><td style={{textAlign:'right'}}>18,363,750</td><td>27/07/2024 09:00:19</td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{textAlign:'center'}}><span style={{color:'var(--red)',fontSize:'18px'}}>✗</span></td><td style={{color:'var(--red)'}}>Giao dịch đã hủy</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}

// Component hiển thị thông báo cho các trang chưa có dữ liệu chi tiết
export function DefaultPage({ title }) {
  return (
    <div className="page active">
      <div className="page-title">{title}</div>
      <div className="card">
        <div className="card-body" style={{textAlign:'center',color:'var(--text-light)',padding:'40px'}}>
          Đang cập nhật dữ liệu...
        </div>
      </div>
    </div>
  );
}