import React, { useState } from 'react';

export default function Tuition() {
  const [iModal, setIModal] = useState(false);
  return (
    <div className="page">
      <div className="ph"><div><div className="ph-title">Học phí &amp; Công nợ</div><div className="ph-sub">Quản lý hóa đơn theo học kỳ</div></div><button className="btn btn-blue" onClick={() => setIModal(true)}>+ Tạo hóa đơn</button></div>
      <div className="card"><div className="card-body" style={{textAlign:'center', padding:'50px', color:'var(--muted)'}}><div style={{fontSize:'48px', marginBottom:'12px'}}>💰</div><div style={{fontSize:'16px', fontWeight:700, marginBottom:'8px'}}>Chưa có hóa đơn học phí</div><div style={{fontSize:'13px'}}>Tạo hóa đơn mới cho sinh viên trong học kỳ hiện tại</div><button className="btn btn-blue" style={{marginTop:'16px'}} onClick={() => setIModal(true)}>+ Tạo hóa đơn đầu tiên</button></div></div>

      {iModal && (
        <div className="ov open">
          <div className="modal" style={{width:'460px'}}>
            <div className="modal-hd"><span className="modal-title">💰 Tạo Hóa đơn học phí</span><button className="close-btn" onClick={() => setIModal(false)}>×</button></div>
            <div className="modal-body">
              <div className="fg"><label className="fl">Sinh viên</label><select className="fc"><option>21IT001 – Phạm Văn Đức</option><option>21IT002 – Hoàng Thị Lan</option><option>IE240301 – Vũ Quốc Hùng</option></select></div>
              <div className="fg"><label className="fl">Học kỳ</label><select className="fc"><option>HK1 – 2024-2025</option><option>HK2 – 2024-2025</option></select></div>
              <div className="grid2"><div className="fg"><label className="fl">Tổng học phí (VNĐ)</label><input type="number" className="fc" placeholder="15000000" /></div><div className="fg"><label className="fl">Hạn đóng</label><input type="date" className="fc" /></div></div>
            </div>
            <div className="modal-ft"><button className="btn btn-ghost" onClick={() => setIModal(false)}>Hủy</button><button className="btn btn-blue" onClick={() => setIModal(false)}>💾 Tạo hóa đơn</button></div>
          </div>
        </div>
      )}
    </div>
  );
}