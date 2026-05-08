import React from 'react';
import { Link } from 'react-router-dom';


const notifData = [
  { title: 'PMT-EMS Lịch học thay đổi', date: '25/03/2026' },
  { title: 'PMT-EMS Lịch học thay đổi', date: '18/03/2026' },
  { title: 'Thông báo học phí HK2', date: '01/01/2026' }
];

export default function Dashboard() {
  return (
    <div className="page">
      <div className="ph mb6">
        <div>
          <div className="ph-title">Tổng quan · Trường ĐH Bách Khoa TP.HCM</div>
          <div className="ph-sub">Cập nhật: 23/04/2026 · Học kỳ 2 (2024-2025) đang hoạt động</div>
        </div>
        <button className="btn btn-blue" onClick={() => alert('Đã xuất báo cáo tổng hợp PDF')}>📄 Xuất báo cáo</button>
      </div>

      <div className="grid5 mb4">
        <Link to="/students" className="stat" style={{textDecoration:'none'}}>
          <div className="stat-top" style={{background:'linear-gradient(90deg,#1976d2,#42a5f5)'}}></div>
          <div className="stat-icon">👨‍🎓</div>
          <div className="stat-label">Sinh viên</div>
          <div className="stat-num">3</div>
          <div className="stat-foot up">↑ 2 đăng ký mới</div>
        </Link>
        <Link to="/teachers" className="stat" style={{textDecoration:'none'}}>
          <div className="stat-top" style={{background:'linear-gradient(90deg,#00897b,#4db6ac)'}}></div>
          <div className="stat-icon">👨‍🏫</div>
          <div className="stat-label">Giảng viên</div>
          <div className="stat-num">3</div>
          <div className="stat-foot">100% hoạt động</div>
        </Link>
        <Link to="/classes" className="stat" style={{textDecoration:'none'}}>
          <div className="stat-top" style={{background:'linear-gradient(90deg,#e65100,#ffb74d)'}}></div>
          <div className="stat-icon">🎓</div>
          <div className="stat-label">Lớp học</div>
          <div className="stat-num">3</div>
          <div className="stat-foot">2 đang học · 1 mở</div>
        </Link>
        <Link to="/attendance" className="stat" style={{textDecoration:'none'}}>
          <div className="stat-top" style={{background:'linear-gradient(90deg,#c62828,#ef5350)'}}></div>
          <div className="stat-icon">📋</div>
          <div className="stat-label">Vắng mặt hôm nay</div>
          <div className="stat-num">2</div>
          <div className="stat-foot down">↑ Tăng so với hôm qua</div>
        </Link>
        <Link to="/tuition" className="stat" style={{textDecoration:'none'}}>
          <div className="stat-top" style={{background:'linear-gradient(90deg,#6a1b9a,#ce93d8)'}}></div>
          <div className="stat-icon">💰</div>
          <div className="stat-label">Công nợ học phí</div>
          <div className="stat-num">0đ</div>
          <div className="stat-foot up">✓ Không có công nợ</div>
        </Link>
      </div>

      <div style={{display:'grid', gridTemplateColumns:'1fr 1fr 300px', gap:'16px', marginBottom:'16px'}}>
        <div className="card">
          <div className="card-hd">
            <div>
              <div className="card-title">Lịch học hôm nay</div>
              <div className="card-sub">Thứ 4 · 23/04/2026</div>
            </div>
            <Link to="/schedule" className="btn btn-ghost btn-sm" style={{textDecoration:'none'}}>Xem tuần →</Link>
          </div>
          <div style={{padding:0}}>
            <div style={{display:'flex', alignItems:'stretch', borderBottom:'1px solid #f0f4f8'}}>
              <div style={{width:'58px', background:'#eff6ff', display:'flex', flexDirection:'column', alignItems:'center', justifyContent:'center', padding:'14px 6px', flexShrink:0}}>
                <div style={{fontSize:'11px', fontWeight:700, color:'var(--blue)'}}>07:30</div>
                <div style={{fontSize:'10px', color:'var(--muted2)'}}>–09:30</div>
              </div>
              <div style={{padding:'12px 16px', flex:1}}>
                <div style={{fontWeight:700, fontSize:'13px'}}>Nhập môn Lập trình</div>
                <div style={{fontSize:'11px', color:'var(--muted)', marginTop:'3px'}}>INT101-01 · Phòng A-101 · GV: Nguyễn Văn An</div>
                <div style={{marginTop:'6px', display:'flex', gap:'6px'}}><span className="badge b-blue">REGULAR</span><span className="badge b-gray">Thứ 4</span></div>
              </div>
            </div>
            <div style={{display:'flex', alignItems:'stretch', borderBottom:'1px solid #f0f4f8'}}>
              <div style={{width:'58px', background:'#f0fdf4', display:'flex', flexDirection:'column', alignItems:'center', justifyContent:'center', padding:'14px 6px', flexShrink:0}}>
                <div style={{fontSize:'11px', fontWeight:700, color:'var(--teal)'}}>09:45</div>
                <div style={{fontSize:'10px', color:'var(--muted2)'}}>–11:45</div>
              </div>
              <div style={{padding:'12px 16px', flex:1}}>
                <div style={{fontWeight:700, fontSize:'13px'}}>CTDL &amp; Giải thuật</div>
                <div style={{fontSize:'11px', color:'var(--muted)', marginTop:'3px'}}>INT201-01 · Phòng B-102 (Lab) · GV: Trần Thị Bích</div>
                <div style={{marginTop:'6px', display:'flex', gap:'6px'}}><span className="badge b-teal">LAB</span><span className="badge b-gray">Thứ 4</span></div>
              </div>
            </div>
            <div style={{display:'flex', alignItems:'stretch'}}>
              <div style={{width:'58px', background:'#fefce8', display:'flex', flexDirection:'column', alignItems:'center', justifyContent:'center', padding:'14px 6px', flexShrink:0}}>
                <div style={{fontSize:'11px', fontWeight:700, color:'var(--amber)'}}>13:30</div>
                <div style={{fontSize:'10px', color:'var(--muted2)'}}>–15:30</div>
              </div>
              <div style={{padding:'12px 16px', flex:1}}>
                <div style={{fontWeight:700, fontSize:'13px'}}>Nhập môn Lập trình</div>
                <div style={{fontSize:'11px', color:'var(--muted)', marginTop:'3px'}}>INT101-01 · Phòng A-101 · GV: Nguyễn Văn An</div>
                <div style={{marginTop:'6px', display:'flex', gap:'6px'}}><span className="badge b-amber">MAKEUP</span><span className="badge b-gray">Dạy bù</span></div>
              </div>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="card-hd">
            <div className="card-title">Tình trạng lớp học HK2</div>
            <Link to="/classes" className="btn btn-ghost btn-sm" style={{textDecoration:'none'}}>Chi tiết →</Link>
          </div>
          <div className="card-body">
            <div style={{display:'flex', flexDirection:'column', gap:'14px'}}>
              <div>
                <div style={{display:'flex', justifyContent:'space-between', marginBottom:'5px', fontSize:'12px'}}>
                  <span style={{fontWeight:600}}>INT101-01 · Nhập môn Lập trình</span>
                  <span style={{color:'var(--blue)', fontWeight:700}}>2/40</span>
                </div>
                <div className="prog-track"><div className="prog-fill" style={{width:'5%', background:'var(--blue-lt)'}}></div></div>
                <div style={{fontSize:'10px', color:'var(--muted)', marginTop:'3px'}}>Giảng viên: Nguyễn Văn An · Thứ 2 &amp; 4</div>
              </div>
              <div>
                <div style={{display:'flex', justifyContent:'space-between', marginBottom:'5px', fontSize:'12px'}}>
                  <span style={{fontWeight:600}}>INT201-01 · CTDL &amp; Giải thuật</span>
                  <span style={{color:'var(--teal)', fontWeight:700}}>2/35</span>
                </div>
                <div className="prog-track"><div className="prog-fill" style={{width:'6%', background:'var(--teal)'}}></div></div>
                <div style={{fontSize:'10px', color:'var(--muted)', marginTop:'3px'}}>Giảng viên: Trần Thị Bích · Thứ 3</div>
              </div>
              <div>
                <div style={{display:'flex', justifyContent:'space-between', marginBottom:'5px', fontSize:'12px'}}>
                  <span style={{fontWeight:600}}>IEL101-Q1 · IELTS Foundation</span>
                  <span style={{color:'var(--amber)', fontWeight:700}}>1/20</span>
                </div>
                <div className="prog-track"><div className="prog-fill" style={{width:'5%', background:'var(--amber)'}}></div></div>
                <div style={{fontSize:'10px', color:'var(--muted)', marginTop:'3px'}}>Giảng viên: Lê Minh Cường · Thứ 7</div>
              </div>
            </div>
            <hr className="divider" />
            <div style={{display:'flex', gap:'16px', fontSize:'12px'}}>
              <div style={{textAlign:'center'}}><div style={{fontSize:'20px', fontWeight:800, color:'var(--blue)'}}>5</div><div style={{color:'var(--muted)'}}>Đăng ký</div></div>
              <div style={{textAlign:'center'}}><div style={{fontSize:'20px', fontWeight:800, color:'var(--green)'}}>5</div><div style={{color:'var(--muted)'}}>Enrolled</div></div>
              <div style={{textAlign:'center'}}><div style={{fontSize:'20px', fontWeight:800, color:'var(--amber)'}}>0</div><div style={{color:'var(--muted)'}}>Pending</div></div>
              <div style={{textAlign:'center'}}><div style={{fontSize:'20px', fontWeight:800, color:'var(--red)'}}>0</div><div style={{color:'var(--muted)'}}>Dropped</div></div>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="card-hd"><div className="card-title">Hoạt động gần đây</div></div>
          <div style={{padding:'0 16px', maxHeight:'340px', overflowY:'auto'}}>
            <div className="feed-item">
              <div className="feed-dot" style={{background:'#22c55e'}}></div>
              <div><div style={{fontSize:'12px'}}><strong>Phạm Văn Đức</strong> đăng ký INT101</div><div style={{fontSize:'10px', color:'var(--muted)'}}>09/09/2024 07:00</div></div>
            </div>
            <div className="feed-item">
              <div className="feed-dot" style={{background:'#f59e0b'}}></div>
              <div><div style={{fontSize:'12px'}}>Ngoại lệ <strong>02/09</strong> – Nghỉ Quốc khánh</div><div style={{fontSize:'10px', color:'var(--muted)'}}>01/09/2024</div></div>
            </div>
            <div className="feed-item">
              <div className="feed-dot" style={{background:'var(--blue-lt)'}}></div>
              <div><div style={{fontSize:'12px'}}>Tạo lớp <strong>IEL101-Q1</strong></div><div style={{fontSize:'10px', color:'var(--muted)'}}>28/08/2024</div></div>
            </div>
            <div className="feed-item">
              <div className="feed-dot" style={{background:'#a855f7'}}></div>
              <div><div style={{fontSize:'12px'}}>Thêm phòng <strong>B-301</strong> (80 chỗ)</div><div style={{fontSize:'10px', color:'var(--muted)'}}>26/08/2024</div></div>
            </div>
            <div className="feed-item">
              <div className="feed-dot" style={{background:'#06b6d4'}}></div>
              <div><div style={{fontSize:'12px'}}>SV mới: <strong>Vũ Quốc Hùng</strong></div><div style={{fontSize:'10px', color:'var(--muted)'}}>25/08/2024</div></div>
            </div>
          </div>
        </div>
      </div>

      <div className="grid2">
        <div className="card">
          <div className="card-hd">
            <div className="card-title">Điểm danh gần nhất · Lớp INT101</div>
            <Link to="/attendance" className="btn btn-ghost btn-sm" style={{textDecoration:'none'}}>Xem tất cả →</Link>
          </div>
          <table className="tbl">
            <thead><tr><th>Sinh viên</th><th>Ca học</th><th>Ngày</th><th>Trạng thái</th></tr></thead>
            <tbody>
              <tr><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-blue" style={{width:'26px', height:'26px', fontSize:'10px'}}>PD</div>Phạm Văn Đức</div></td><td>Thứ 2 – 07:30</td><td>09/09/2024</td><td><span className="badge b-green">✓ Có mặt</span></td></tr>
              <tr><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-pink" style={{width:'26px', height:'26px', fontSize:'10px'}}>HL</div>Hoàng Thị Lan</div></td><td>Thứ 2 – 07:30</td><td>09/09/2024</td><td><span className="badge b-green">✓ Có mặt</span></td></tr>
              <tr><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-blue" style={{width:'26px', height:'26px', fontSize:'10px'}}>PD</div>Phạm Văn Đức</div></td><td>Thứ 2 – 07:30</td><td>11/09/2024</td><td><span className="badge b-amber">⏰ Đi trễ</span></td></tr>
              <tr><td><div style={{display:'flex', alignItems:'center', gap:'7px'}}><div className="av av-pink" style={{width:'26px', height:'26px', fontSize:'10px'}}>HL</div>Hoàng Thị Lan</div></td><td>Thứ 2 – 07:30</td><td>11/09/2024</td><td><span className="badge b-red">✗ Vắng mặt</span></td></tr>
            </tbody>
          </table>
        </div>

        <div className="card">
          <div className="card-hd">
            <div className="card-title">Tình trạng phòng học</div>
            <Link to="/branches" className="btn btn-ghost btn-sm" style={{textDecoration:'none'}}>Quản lý →</Link>
          </div>
          <table className="tbl">
            <thead><tr><th>Phòng</th><th>Loại</th><th>Sức chứa</th><th>Cơ sở</th><th>Trạng thái</th></tr></thead>
            <tbody>
              <tr><td style={{fontWeight:700}}>A-101</td><td>Classroom</td><td>50</td><td>CS1</td><td><span className="badge b-green">Đang dùng</span></td></tr>
              <tr><td style={{fontWeight:700}}>B-102</td><td>Lab máy tính</td><td>30</td><td>CS1</td><td><span className="badge b-blue">Rảnh</span></td></tr>
              <tr><td style={{fontWeight:700}}>B-301</td><td>Hội trường</td><td>80</td><td>CS1</td><td><span className="badge b-blue">Rảnh</span></td></tr>
              <tr><td style={{fontWeight:700}}>C-201</td><td>Classroom</td><td>40</td><td>CS2</td><td><span className="badge b-blue">Rảnh</span></td></tr>
              <tr><td style={{fontWeight:700}}>A-001</td><td>Seminar</td><td>20</td><td>Q1</td><td><span className="badge b-amber">Bảo trì</span></td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}