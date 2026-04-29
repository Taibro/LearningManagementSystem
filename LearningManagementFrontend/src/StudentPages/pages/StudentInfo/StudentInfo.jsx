import React from 'react';

export default function StudentInfo() {
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
              <div className="info-row"><span className="lbl">Lớp học:</span><span className="val">14DHTH05</span></div>
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