import React from 'react';

export default function Topbar({ setPage }) {
  return (
    <div className="topbar">
      <div className="logo-wrap">
        <div style={{width:'42px',height:'42px',background:'linear-gradient(135deg,#1a6fb5,#2e87d4)',borderRadius:'8px',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontWeight:800,fontSize:'12px'}}>HUIT</div>
        <div className="logo-text">HO CHI MINH CITY<br/>UNIVERSITY OF<br/>INDUSTRY AND TRADE</div>
      </div>
      <div className="search-box">
        <svg width="14" height="14" fill="none" stroke="#94a3b8" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
        <input placeholder="Tìm kiếm..." />
      </div>
      <div className="topbar-right">
        <a className="topbar-link" style={{cursor:'pointer'}} onClick={() => setPage('trang-chu')}>🏠 Trang chủ</a>
        <a className="topbar-link" style={{cursor:'pointer'}} onClick={() => setPage('nhac-nho')}>
          🔔 Tin tức <span className="notif-badge">812</span>
        </a>
        <div className="user-chip" onClick={() => setPage('thong-tin-sv')}>
          <div style={{width:'32px',height:'32px',borderRadius:'50%',background:'linear-gradient(135deg,#1a6fb5,#60a5fa)',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontSize:'13px',fontWeight:700}}>NT</div>
          <span style={{fontSize:'13px',fontWeight:500}}>Nguyễn Thành Tài ▾</span>
        </div>
      </div>
    </div>
  );
}