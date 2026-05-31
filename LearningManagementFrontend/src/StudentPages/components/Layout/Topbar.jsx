import React, { useState, useRef, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';

export default function Topbar() {
  const [showDropdown, setShowDropdown] = useState(false);
  const dropdownRef = useRef(null);
  const navigate = useNavigate();

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setShowDropdown(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleLogout = () => {
    // Clear local storage or session
    // localStorage.removeItem('token');
    navigate('/login');
  };
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
        <Link className="topbar-link" to="/dashboard">🏠 Trang chủ</Link>
        <Link className="topbar-link" to="/notifications">
          🔔 Tin tức <span className="notif-badge">812</span>
        </Link>
        
        <div className="user-chip-container" ref={dropdownRef} style={{position: 'relative'}}>
          <div 
            className="user-chip" 
            style={{textDecoration: 'none', color: 'inherit', cursor: 'pointer'}}
            onClick={() => setShowDropdown(!showDropdown)}
          >
            <div style={{width:'32px',height:'32px',borderRadius:'50%',background:'linear-gradient(135deg,#1a6fb5,#60a5fa)',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontSize:'13px',fontWeight:700}}>
              PT
            </div>
            <span style={{fontSize:'13px',fontWeight:500}}>Phan Sĩ Thịnh ▾</span>
          </div>

          {showDropdown && (
            <div style={{
              position: 'absolute',
              top: '100%',
              right: 0,
              marginTop: '8px',
              width: '200px',
              background: 'white',
              boxShadow: '0 10px 25px rgba(0,0,0,0.1)',
              borderRadius: '8px',
              border: '1px solid #e2e8f0',
              overflow: 'hidden',
              zIndex: 1000
            }}>
              <Link to="/student-info" style={{display: 'block', padding: '12px 16px', color: '#475569', textDecoration: 'none', borderBottom: '1px solid #f1f5f9', fontSize: '13px'}} onClick={() => setShowDropdown(false)}>
                Thông tin cá nhân
              </Link>
              <Link to="/student-info" style={{display: 'block', padding: '12px 16px', color: '#475569', textDecoration: 'none', borderBottom: '1px solid #f1f5f9', fontSize: '13px'}} onClick={() => setShowDropdown(false)}>
                Đổi mật khẩu
              </Link>
              <div 
                onClick={handleLogout} 
                style={{display: 'block', padding: '12px 16px', color: '#ef4444', textDecoration: 'none', cursor: 'pointer', fontSize: '13px', fontWeight: '500'}}
              >
                Đăng xuất
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}