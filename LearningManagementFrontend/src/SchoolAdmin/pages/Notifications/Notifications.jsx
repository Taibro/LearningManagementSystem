import React, { useState } from 'react';

export default function Notifications() {
  const [nModal, setNModal] = useState(false);
  return (
    <div className="page">
      <div className="ph"><div><div className="ph-title">Quản lý Thông báo</div></div><button className="btn btn-blue" onClick={() => setNModal(true)}>📢 Gửi thông báo</button></div>
      <div className="card">
        <table className="tbl">
          <thead><tr><th>#</th><th>Người nhận</th><th>Tiêu đề</th><th>Loại</th><th>Đã đọc</th><th>Thời gian</th><th>Thao tác</th></tr></thead>
          <tbody>
            <tr><td style={{color:'var(--muted)'}}>1</td><td>Phạm Văn Đức</td><td style={{fontWeight:600}}>Lịch học INT101 thay đổi</td><td><span className="badge b-amber">SCHEDULE_CHANGE</span></td><td><span className="badge b-red">Chưa đọc</span></td><td style={{fontSize:'11px', color:'var(--muted)'}}>09/09/2024 08:00</td><td><button className="btn btn-danger btn-xs">Xóa</button></td></tr>
            <tr><td style={{color:'var(--muted)'}}>2</td><td>Hoàng Thị Lan</td><td style={{fontWeight:600}}>Điểm môn INT101 đã cập nhật</td><td><span className="badge b-green">GRADE</span></td><td><span className="badge b-green">Đã đọc</span></td><td style={{fontSize:'11px', color:'var(--muted)'}}>10/09/2024 14:20</td><td><button className="btn btn-danger btn-xs">Xóa</button></td></tr>
            <tr><td style={{color:'var(--muted)'}}>3</td><td>Vũ Quốc Hùng</td><td style={{fontWeight:600}}>Xác nhận đăng ký IEL101</td><td><span className="badge b-blue">ENROLLMENT</span></td><td><span className="badge b-red">Chưa đọc</span></td><td style={{fontSize:'11px', color:'var(--muted)'}}>01/09/2024 09:00</td><td><button className="btn btn-danger btn-xs">Xóa</button></td></tr>
          </tbody>
        </table>
      </div>

      {nModal && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd"><span className="modal-title">📢 Gửi Thông báo</span><button className="close-btn" onClick={() => setNModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="grid2"><div className="fg"><label className="fl">Gửi đến</label><select className="fc"><option>Tất cả sinh viên</option><option>Tất cả giảng viên</option><option>Lớp INT101-01</option><option>Lớp INT201-01</option><option>Lớp IEL101-Q1</option><option>Cá nhân cụ thể</option></select></div><div className="fg"><label className="fl">Loại thông báo</label><select className="fc"><option>SCHEDULE_CHANGE</option><option>GRADE</option><option>ENROLLMENT</option><option>SYSTEM</option><option>REMINDER</option></select></div></div>
              <div className="fg"><label className="fl">Tiêu đề</label><input className="fc" placeholder="VD: Lịch học ngày 25/04 thay đổi" /></div>
              <div className="fg"><label className="fl">Nội dung</label><textarea className="fc" rows="4" placeholder="Nội dung chi tiết của thông báo..."></textarea></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setNModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setNModal(false)}>📤 Gửi ngay</button></div>
          </div>
        </div>
      )}
    </div>
  );
}