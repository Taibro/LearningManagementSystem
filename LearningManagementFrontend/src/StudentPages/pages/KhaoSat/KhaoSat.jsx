import React, { useState } from 'react';
import { surveyData } from '../../data';

export default function KhaoSat() {
  const [tab, setTab] = useState('da');
  return (
    <div className="page active">
      <div className="page-title">Khảo sát sự kiện</div>
      <div className="tabs">
        <div className={`tab-btn ${tab==='chua'?'active':''}`} onClick={()=>setTab('chua')}>Danh sách phiếu chưa khảo sát</div>
        <div className={`tab-btn ${tab==='da'?'active':''}`} onClick={()=>setTab('da')}>Danh sách phiếu đã khảo sát</div>
      </div>
      {tab === 'da' ? surveyData.map((s,i) => (
        <div key={i} style={{padding:'14px 20px',borderBottom:'1px solid #f0f2f5', background:'white'}}>
          <a className="link" style={{fontWeight:600,fontSize:'13px',cursor:'pointer'}}>{i+1}. {s.code} {s.title} <span style={{color:'var(--red)'}}>({s.tag}) ({s.required})</span></a>
          <div style={{fontSize:'12px',color:'var(--text-light)',marginTop:'4px'}}>Giảng viên: <strong>{s.gv}</strong></div>
        </div>
      )) : (
        <div className="card"><div className="card-body" style={{textAlign:'center',color:'var(--text-light)',padding:'40px'}}>Không có phiếu chưa khảo sát</div></div>
      )}
    </div>
  );
}