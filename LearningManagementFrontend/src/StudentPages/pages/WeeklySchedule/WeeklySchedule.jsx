import React, { useEffect, useState } from 'react';
import { getWeeklySchedule } from '../../studentApi';

const DAY_NAMES = ['', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];
const DAYS = [2, 3, 4, 5, 6, 7, 1]; // Thứ 2 → Chủ nhật

// Tính ngày đầu tuần (Thứ 2) từ một ngày bất kỳ
function getMondayOf(date) {
  const d = new Date(date);
  const day = d.getDay(); // 0=CN
  const diff = (day === 0) ? -6 : 1 - day;
  d.setDate(d.getDate() + diff);
  return d;
}

function toLocalIso(d) {
  return d.toISOString().split('T')[0];
}

export default function WeeklySchedule() {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(false);
  const [selectedDate, setSelectedDate] = useState(toLocalIso(new Date()));

  const monday = getMondayOf(selectedDate);
  const weekDates = DAYS.map((_, i) => {
    const d = new Date(monday);
    d.setDate(monday.getDate() + i);
    return d;
  });

  const load = (date) => {
    setLoading(true);
    getWeeklySchedule(date)
      .then(data => { setRows(data); setLoading(false); })
      .catch(() => setLoading(false));
  };

  useEffect(() => { load(selectedDate); }, [selectedDate]);

  // Map dayOfWeek → danh sách lịch
  const byDay = {};
  rows.forEach(r => {
    const d = r.dayOfWeek;
    if (!byDay[d]) byDay[d] = [];
    byDay[d].push(r);
  });

  const sessionClass = (type) => {
    if (type === 'REGULAR') return 'sched-green';
    if (type === 'LAB') return 'sched-blue';
    return 'sched-gray';
  };

  const goWeek = (delta) => {
    const d = new Date(selectedDate);
    d.setDate(d.getDate() + delta * 7);
    setSelectedDate(toLocalIso(d));
  };

  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Lịch học, lịch thi theo tuần</div>
        <div style={{display:'flex',alignItems:'center',gap:'8px',flexWrap:'wrap'}}>
          <input type="date" className="form-ctrl" style={{width:'150px'}}
            value={selectedDate}
            onChange={e => setSelectedDate(e.target.value)} />
          <button className="btn btn-blue btn-sm" onClick={() => setSelectedDate(toLocalIso(new Date()))}>Hiện tại</button>
          <button className="btn btn-outline btn-sm" onClick={() => goWeek(-1)}>‹ Trở về</button>
          <button className="btn btn-blue btn-sm" onClick={() => goWeek(1)}>Tiếp ›</button>
        </div>
      </div>

      <div className="card" style={{overflowX:'auto'}}>
        {loading && <div style={{padding:'20px',textAlign:'center',color:'var(--text-light)'}}>Đang tải...</div>}
        {!loading && (
          <table className="week-tbl">
            <tbody>
              <tr>
                <th style={{width:'70px'}}>Ca học</th>
                {DAYS.map((dow, i) => (
                  <th key={dow}>
                    <div style={{fontWeight:700}}>{DAY_NAMES[dow]}</div>
                    <div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>
                      {weekDates[i].toLocaleDateString('vi-VN')}
                    </div>
                  </th>
                ))}
              </tr>
              {['Sáng', 'Chiều', 'Tối'].map((session, si) => (
                <tr key={session}>
                  <td className="ca">{session}</td>
                  {DAYS.map(dow => {
                    const items = (byDay[dow] || []).filter(r => {
                      const p = r.startPeriod || 0;
                      if (si === 0) return p >= 1 && p <= 5;
                      if (si === 1) return p >= 6 && p <= 9;
                      return p >= 10;
                    });
                    return (
                      <td key={dow}>
                        {items.map((r, i) => (
                          <div key={i} className={sessionClass(r.sessionType)} style={{marginBottom: i < items.length - 1 ? '4px' : 0}}>
                            <strong>{r.courseName}</strong><br/>
                            {r.classCode} – {r.courseCode}<br/>
                            Tiết: {r.startPeriod} – {r.endPeriod}<br/>
                            Phòng: {r.roomName || '—'}<br/>
                            GV: {r.teacherName || '—'}
                          </div>
                        ))}
                      </td>
                    );
                  })}
                </tr>
              ))}
            </tbody>
          </table>
        )}
        <div style={{padding:'10px 12px',display:'flex',gap:'16px',fontSize:'11px',borderTop:'1px solid var(--border)'}}>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#d1fae5',borderLeft:'3px solid #22c55e',display:'inline-block'}}></span>Lý thuyết</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#dbeafe',borderLeft:'3px solid #3b82f6',display:'inline-block'}}></span>Thực hành</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#f1f5f9',borderLeft:'3px solid #94a3b8',display:'inline-block'}}></span>Khác</span>
        </div>
      </div>
    </div>
  );
}