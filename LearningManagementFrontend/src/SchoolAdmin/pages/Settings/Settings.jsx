import React from 'react';

export default function Settings() {
  return (
    <div className="page">
      <div className="ph"><div><div className="ph-title">Cài đặt Trường học</div><div className="ph-sub">Trường ĐH Bách Khoa TP.HCM · HCMUT</div></div></div>
      <div className="grid2">
        <div className="card">
          <div className="card-hd"><div className="card-title">Thông tin cơ bản</div></div>
          <div className="card-body">
            <div className="fg"><label className="fl">Mã trường</label><input className="fc" defaultValue="HCMUT" readOnly style={{background:'#f8fafc'}} /></div>
            <div className="fg"><label className="fl">Tên đầy đủ</label><input className="fc" defaultValue="Trường Đại học Bách Khoa TP.HCM" /></div>
            <div className="fg"><label className="fl">Tên viết tắt</label><input className="fc" defaultValue="BK-HCM" /></div>
            <div className="fg"><label className="fl">Loại hình</label><select className="fc"><option>UNIVERSITY</option></select></div>
            <div className="fg"><label className="fl">Ngày thành lập</label><input type="date" className="fc" defaultValue="1957-10-27" /></div>
            <div className="grid2"><div className="fg"><label className="fl">Email</label><input className="fc" defaultValue="info@hcmut.edu.vn" /></div><div className="fg"><label className="fl">Điện thoại</label><input className="fc" defaultValue="028-3865-4086" /></div></div>
            <div className="fg"><label className="fl">Website</label><input className="fc" defaultValue="https://hcmut.edu.vn" /></div>
            <button className="btn btn-blue" onClick={() => alert('Đã lưu cài đặt trường')}>💾 Lưu thay đổi</button>
          </div>
        </div>
        <div>
          <div className="card mb4">
            <div className="card-hd"><div className="card-title">Thống kê hệ thống</div></div>
            <div className="card-body">
              <div style={{display:'flex', flexDirection:'column', gap:'10px', fontSize:'13px'}}>
                <div style={{display:'flex', justifyContent:'space-between'}}><span style={{color:'var(--muted)'}}>Tổng sinh viên</span><strong>3</strong></div>
                <div style={{display:'flex', justifyContent:'space-between'}}><span style={{color:'var(--muted)'}}>Tổng giảng viên</span><strong>3</strong></div>
                <div style={{display:'flex', justifyContent:'space-between'}}><span style={{color:'var(--muted)'}}>Lớp học đang chạy</span><strong>2</strong></div>
                <div style={{display:'flex', justifyContent:'space-between'}}><span style={{color:'var(--muted)'}}>Phòng học</span><strong>5</strong></div>
                <div style={{display:'flex', justifyContent:'space-between'}}><span style={{color:'var(--muted)'}}>Môn học</span><strong>3</strong></div>
                <div style={{display:'flex', justifyContent:'space-between'}}><span style={{color:'var(--muted)'}}>Bản ghi điểm danh</span><strong>4</strong></div>
              </div>
            </div>
          </div>
          <div className="card">
            <div className="card-hd"><div className="card-title">Học kỳ hiện tại</div></div>
            <div className="card-body">
              <div className="fg"><label className="fl">Học kỳ</label><select className="fc"><option>HK1 – 2024-2025</option><option>HK2 – 2024-2025</option></select></div>
              <div className="grid2"><div className="fg"><label className="fl">Bắt đầu</label><input type="date" className="fc" defaultValue="2024-09-09" /></div><div className="fg"><label className="fl">Kết thúc</label><input type="date" className="fc" defaultValue="2025-01-10" /></div></div>
              <button className="btn btn-teal" onClick={() => alert('Đã cập nhật học kỳ')}>Cập nhật học kỳ</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}