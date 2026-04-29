import React from 'react';

export default function LichTienDo() { 
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Lịch học, lịch thi theo tiến độ</div>
        <div style={{display:'flex',alignItems:'center',gap:'8px'}}>
          <div style={{display:'flex',gap:'12px',fontSize:'12px'}}>
            <label><input type="radio" name="ltd" defaultChecked /> Tất cả</label>
            <label><input type="radio" name="ltd" /> Lịch học</label>
            <label><input type="radio" name="ltd" /> Lịch thi</label>
          </div>
          <select className="form-ctrl" style={{width:'160px'}}><option>HK2 (2025 - 2026)</option></select>
          <button className="btn btn-blue btn-sm">Xem lịch</button>
          <button className="btn btn-outline btn-sm">🖨 In lịch</button>
        </div>
      </div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl" style={{minWidth:'900px'}}>
          <tbody>
            <tr><th>STT</th><th>Mã học phần</th><th>Tên môn học/học phần</th><th>Số TC</th><th>Thứ</th><th>Tiết</th><th>Loại lịch</th><th>Phòng</th><th>Nhóm</th><th>Giờ</th><th>Bắt đầu</th><th>Kết thúc</th><th>Mã giảng viên</th><th>Giảng viên</th></tr>
            <tr><td>1</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td></td><td></td><td>Lý thuyết</td><td></td><td></td><td></td><td>12/01/2026</td><td>05/07/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>2</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td>3</td><td>2 - 6</td><td>Lý thuyết</td><td>A202 - Phòng máy tính - 140 Lê Trọng Tấn</td><td></td><td></td><td>13/01/2026</td><td>27/01/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>3</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td>3</td><td>2 - 6</td><td>Thực hành</td><td>A202 - Phòng máy tính - 140 Lê Trọng Tấn</td><td></td><td></td><td>03/02/2026</td><td>02/06/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>4</td><td>0101000002</td><td>Công Nghệ Java</td><td>3</td><td>5</td><td>2 - 6</td><td>Thực hành</td><td>A202 - Phòng máy tính - 140 Lê Trọng Tấn</td><td></td><td></td><td>07/05/2026</td><td>07/05/2026</td><td>TG00000279</td><td>ThS. Nguyễn Thị Thu Hồng</td></tr>
            <tr><td>5</td><td>0101101956</td><td>Deep learning</td><td>3</td><td></td><td></td><td>Lý thuyết</td><td></td><td></td><td></td><td>12/01/2026</td><td>05/07/2026</td><td>01001048</td><td>TS. Phùng Thế Bảo</td></tr>
            <tr><td>6</td><td>0101101956</td><td>Deep learning</td><td>3</td><td>3</td><td>10 - 12</td><td>Lý thuyết</td><td>A303 - 140 Lê Trọng Tấn</td><td></td><td></td><td>13/01/2026</td><td>09/06/2026</td><td>01001048</td><td>ThS. Hồ Hải Quân, TS. Phùng Thế Bảo</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}