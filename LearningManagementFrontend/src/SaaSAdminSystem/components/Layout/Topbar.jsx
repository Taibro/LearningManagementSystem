import React from 'react';

export default function Topbar() {
  return (
    <header className="topbar">
      <div className="breadcrumb">
        <span className="bc-parent">HUIT</span>
        <span className="bc-sep">/</span>
        <span className="bc-current">Dashboard</span>
      </div>
      <div className="topbar-actions">
        <div className="search-bar">
          <span style={{ color: 'var(--muted)', fontSize: '13px' }}>🔍</span>
          <input placeholder="Tìm kiếm... (/ để focus)" />
        </div>
        <div className="icon-btn" onClick={() => alert('Không có thông báo mới')}>
          🔔<div className="notif-dot"></div>
        </div>
        <div className="icon-btn" title="Theme">🌙</div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '4px 10px', background: 'var(--surface2)', border: '1px solid var(--border)', borderRadius: '8px', cursor: 'pointer' }}>
          <div className="avatar" style={{ width: '26px', height: '26px', fontSize: '10px' }}>SA</div>
          <span style={{ fontSize: '12px', color: 'var(--text)', fontWeight: 600 }}>Super Admin</span>
        </div>
      </div>
    </header>
  );
}