import React from 'react';

export default function Topbar() {
  return (
    <header className="topbar">
      <div className="breadcrumb">
        <span className="bc-root">🏫 HCMUT</span>
        <span class="bc-sep">/</span>
        <span class="bc-cur">Dashboard</span>
      </div>
      <div className="topbar-right">
        <div className="search-wrap">
          <span style={{color:'var(--muted2)', fontSize:'13px'}}>🔍</span>
          <input placeholder="Tìm kiếm..." />
        </div>
        <div className="school-chip">
          🏫 HK2 · 2024-2025
        </div>
        <div className="top-btn" onClick={() => alert('Không có thông báo mới')}>🔔<span className="dot"></span></div>
        <div className="top-btn">⚙️</div>
        <div style={{display:'flex', alignItems:'center', gap:'8px', padding:'5px 12px', background:'var(--blue-pale)', border:'1px solid #b3d4f5', borderRadius:'8px', cursor:'pointer'}}>
          <div className="av av-blue" style={{width:'28px', height:'28px', fontSize:'11px'}}>AD</div>
          <span style={{fontSize:'12.5px', fontWeight:700, color:'var(--blue)'}}>Admin</span>
        </div>
      </div>
    </header>
  );
}