import React from 'react';
import { notifData } from '../../data';

export default function Notifications() {
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