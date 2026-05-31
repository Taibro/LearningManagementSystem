import React from 'react';
import { Link } from 'react-router-dom';
import { Bell } from 'lucide-react';
import { FaHome } from "react-icons/fa";

export default function Topbar() {
  const rawSchoolName = localStorage.getItem('schoolName') || 'Ho Chi Minh City University of Industry and Trade';
  const schoolName = rawSchoolName.replace(/\n/g, ' ');
  const schoolShort = schoolName.split(' ').map(w => w[0]).join('').substring(0, 4).toUpperCase() || 'HUIT';

  return (
    <div className="topbar">
      <div className="logo-wrap">
        <div style={{width:'42px',height:'42px',background:'linear-gradient(135deg,#1a6fb5,#2e87d4)',borderRadius:'8px',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontWeight:800,fontSize:'14px',textAlign:'center',flexShrink:0}}>
          {schoolShort}
        </div>
        <div className="logo-text" style={{ color: '#0f172a', textTransform: 'uppercase', fontSize: '12px', maxWidth: '180px', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
          {schoolName}
        </div>
      </div>
      <div className="search-box">
        <svg width="14" height="14" fill="none" stroke="#94a3b8" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
        <input placeholder="Tìm kiếm..." />
      </div>
      <div className="topbar-right">
        <Link className="topbar-link" to="/dashboard"><FaHome />
 Trang chủ</Link>
        <Link className="topbar-link" to="/notifications">
          <Bell className="w-4 h-4 inline-block mr-2" /> Tin tức <span className="notif-badge">812</span>
        </Link>
        <Link className="user-chip" to="/student-info" style={{textDecoration: 'none', color: 'inherit'}}>
          <div style={{width:'32px',height:'32px',borderRadius:'50%',background:'linear-gradient(135deg,#1a6fb5,#60a5fa)',display:'flex',alignItems:'center',justifyContent:'center',color:'white',fontSize:'13px',fontWeight:700}}>NT</div>
          <span style={{fontSize:'13px',fontWeight:500}}>Nguyễn Thành Tài ▾</span>
        </Link>
      </div>
    </div>
  );
}