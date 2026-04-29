import React from 'react';

export default function LichTuan() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Lịch học, lịch thi theo tuần</div>
        <div style={{display:'flex',alignItems:'center',gap:'8px',flexWrap:'wrap'}}>
          <div style={{display:'flex',gap:'12px',fontSize:'12px'}}>
            <label><input type="radio" name="lt" defaultChecked /> Tất cả</label>
            <label><input type="radio" name="lt" /> Lịch học</label>
            <label><input type="radio" name="lt" /> Lịch thi</label>
          </div>
          <input type="date" className="form-ctrl" style={{width:'150px'}} defaultValue="2026-03-28" />
          <button className="btn btn-blue btn-sm">Hiện tại</button>
          <button className="btn btn-outline btn-sm">In lịch</button>
          <button className="btn btn-outline btn-sm">‹ Trở về</button>
          <button className="btn btn-blue btn-sm">Tiếp ›</button>
        </div>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="week-tbl">
          <tbody>
            <tr>
              <th style={{width:'70px'}}>Ca học</th>
              <th><div style={{fontWeight:700}}>Thứ 2</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>23/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 3</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>24/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 4</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>25/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 5</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>26/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 6</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>27/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Thứ 7</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>28/03/2026</div></th>
              <th><div style={{fontWeight:700}}>Chủ nhật</div><div style={{fontSize:'11px',fontWeight:400,color:'#bfdbfe'}}>29/03/2026</div></th>
            </tr>
            <tr>
              <td className="ca">Sáng</td>
              <td>
                <div className="sched-gray">
                  <strong>Sinh hoạt giữa khóa năm 3</strong><br/>
                  SINHHOATGIUAKHOA - 010109728801<br/>Tiết: 2 - 3<br/>
                  Phòng: HT.C (Hội trường C - Tầng 4 dãy nhà C) - 140 Lê Trọng Tấn<br/>
                  GV: Hồ Thanh Trí
                </div>
                <div className="sched-gray" style={{marginTop:'4px'}}>
                  <strong>Sinh hoạt giữa khóa năm 3</strong><br/>
                  Tiết: 4 - 6 | GV: Vũ Đức Thịnh
                </div>
              </td>
              <td>
                <div className="sched-green">
                  <strong>Công Nghệ Java</strong><br/>
                  14DHTH12 - 010100000204<br/>Tiết: 2 – 6<br/>
                  Phòng: A202 - Phòng máy tính - 140 Lê Trọng Tấn<br/>
                  GV: Nguyễn Thị Thu Hồng
                </div>
              </td>
              <td></td><td></td>
              <td>
                <div className="sched-blue">
                  <strong>Khai phá dữ liệu</strong><br/>
                  14DHTH14 - 0110110197014<br/>Tiết: 1 – 3<br/>
                  Phòng: A301 - 140 Lê Trọng Tấn<br/>
                  GV: Phùng Thế Bảo
                </div>
              </td>
              <td></td><td></td>
            </tr>
            <tr>
              <td className="ca">Chiều</td>
              <td></td>
              <td>
                <div className="sched-green">
                  <strong>Lập trình di động</strong><br/>
                  14DHTH10 - 0110110196910<br/>Tiết: 7 – 11<br/>GV: ...
                </div>
              </td>
              <td>
                <div className="sched-blue">
                  <strong>Deep learning</strong><br/>
                  14DHTH04 - 0110110195604<br/>Tiết: 10 – 12<br/>GV: TS. Phùng Thế Bảo
                </div>
              </td>
              <td>
                <div className="sched-green">
                  <strong>Thực hành phân tích thiết kế hệ thống</strong><br/>
                  14DHTH10 - ...<br/>Tiết: 7 – 9
                </div>
              </td>
              <td>
                <div className="sched-blue">
                  <strong>Quản trị hệ thống mạng</strong><br/>
                  14DHTH04 - 0110110197304<br/>Tiết: 7 – 9
                </div>
              </td>
              <td></td><td></td>
            </tr>
            <tr>
              <td className="ca">Tối</td>
              <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>
          </tbody>
        </table>
        <div style={{padding:'10px 12px',display:'flex',gap:'16px',fontSize:'11px',borderTop:'1px solid var(--border)'}}>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#d1fae5',borderLeft:'3px solid #22c55e',display:'inline-block'}}></span>Lịch dạy lý thuyết</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#dbeafe',borderLeft:'3px solid #3b82f6',display:'inline-block'}}></span>Lịch dạy thực hành</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#fff7ed',borderLeft:'3px solid #f97316',display:'inline-block'}}></span>Lịch trực tuyến</span>
          <span style={{display:'flex',alignItems:'center',gap:'4px'}}><span style={{width:'12px',height:'12px',background:'#f1f5f9',borderLeft:'3px solid #94a3b8',display:'inline-block'}}></span>Lịch coi thi</span>
        </div>
      </div>
    </div>
  ); 
}