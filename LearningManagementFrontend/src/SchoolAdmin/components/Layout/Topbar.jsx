import React, { useState, useRef, useEffect } from 'react';

export default function Topbar() {
  const [open, setOpen] = useState(false);
  const ref = useRef(null);

  // Đóng dropdown khi click ra ngoài
  useEffect(() => {
    const handler = (e) => { if (ref.current && !ref.current.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, []);

  const handleLogout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('adminToken');
    localStorage.removeItem('adminName');
    localStorage.removeItem('adminEmail');
    localStorage.removeItem('schoolId');
    window.location.href = '/login';
  };

  return (
    <header className="admin-topbar">
      <div className="breadcrumb">
        <span className="bc-root">🏫 {localStorage.getItem('schoolId') === '1' ? 'HUIT' : 'HCMUT'}</span>
        <span className="bc-sep">/</span>
        <span className="bc-cur">Dashboard</span>
      </div>
      <div className="topbar-right">
        <div className="search-wrap">
          <span style={{color:'var(--muted2)', fontSize:'13px'}}>🔍</span>
          <input placeholder="Tìm kiếm..." />
        </div>
        <div className="school-chip">🏫 HK2 · 2024-2025</div>
        <div className="top-btn" onClick={() => alert('Không có thông báo mới')}>🔔<span className="dot"></span></div>
        <div className="top-btn">⚙️</div>

        {/* Profile + Dropdown - Click based */}
        <div ref={ref} style={{position: 'relative'}}>
          <div
            onClick={() => setOpen(!open)}
            style={{
              display:'flex', alignItems:'center', gap:'8px', padding:'5px 12px',
              background: open ? '#dbeafe' : 'var(--blue-pale)',
              border:'1px solid #b3d4f5', borderRadius:'8px', cursor:'pointer', userSelect:'none'
            }}
          >
            <div className="av av-blue" style={{width:'28px', height:'28px', fontSize:'11px'}}>
              {(localStorage.getItem('adminName') || 'A').charAt(0).toUpperCase()}
            </div>
            <span style={{fontSize:'12.5px', fontWeight:700, color:'var(--blue)'}}>
              {localStorage.getItem('adminName') || 'Admin'}
            </span>
            <span style={{fontSize:'10px', color:'var(--blue)', marginLeft:'2px'}}>{open ? '▲' : '▼'}</span>
          </div>

          {open && (
            <div style={{
              position: 'absolute', top: 'calc(100% + 6px)', right: 0,
              background: 'white', border: '1px solid #e2e8f0', borderRadius: '12px',
              boxShadow: '0 12px 30px rgba(0,0,0,0.12)', minWidth: '210px',
              padding: '8px', zIndex: 200
            }}>
              <div style={{padding: '10px 12px', borderBottom: '1px solid #f1f5f9', marginBottom: '6px'}}>
                <div style={{fontSize: '13px', fontWeight: 700, color: '#0f172a'}}>{localStorage.getItem('adminName')}</div>
                <div style={{fontSize: '11.5px', color: '#64748b', marginTop:'2px'}}>{localStorage.getItem('adminEmail')}</div>
              </div>
              <button
                onClick={handleLogout}
                style={{
                  width: '100%', display: 'flex', alignItems: 'center', gap: '8px',
                  padding: '10px 12px', background: '#fef2f2', color: '#ef4444',
                  border: 'none', borderRadius: '8px', cursor: 'pointer',
                  fontSize: '13px', fontWeight: 600, textAlign: 'left'
                }}
                onMouseEnter={e => e.currentTarget.style.background = '#fee2e2'}
                onMouseLeave={e => e.currentTarget.style.background = '#fef2f2'}
              >
                <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                  <polyline points="16 17 21 12 16 7"></polyline>
                  <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
                Đăng xuất tài khoản
              </button>
            </div>
          )}
        </div>
      </div>
    </header>
  );
}
