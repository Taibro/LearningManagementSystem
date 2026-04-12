import React, { useState } from 'react';

export default function Sidebar({ activePage, setPage }) {
  const [open, setOpen] = useState({'ttc': true, 'hoctap': true, 'dkhp': false, 'hocphi': false, 'khac': false});
  const toggle = (id) => setOpen(prev => ({...prev, [id]: !prev[id]}));
  const cls = (p) => `sidebar-item ${activePage === p ? 'active' : ''}`;

  return (
    <aside className="sidebar">
      <div className="sidebar-section">
        <div className="sidebar-header"><span className="icon">🏠</span> TRANG CHỦ</div>
        <div className={cls('trang-chu')} onClick={() => setPage('trang-chu')}>Trang chủ</div>
      </div>
      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.ttc ? 'open' : ''}`} onClick={() => toggle('ttc')}>
          <span>🖥 THÔNG TIN CHUNG</span><span className={`caret ${open.ttc ? 'open' : ''}`}>▾</span>
        </div>
        <div className={`sub-menu ${open.ttc ? 'open' : ''}`}>
          <div className={cls('thong-tin-sv')} onClick={() => setPage('thong-tin-sv')}>Thông tin sinh viên</div>
          <div className={cls('ke-khai')} onClick={() => setPage('ke-khai')}>Kê khai thông tin sinh viên</div>
          <div className={cls('dich-vu')} onClick={() => setPage('dich-vu')}>Dịch vụ trực tuyến</div>
          <div className={cls('nhac-nho')} onClick={() => setPage('nhac-nho')}>Ghi chú nhắc nhở</div>
          <div className={cls('chung-chi')} onClick={() => setPage('chung-chi')}>Đề xuất chứng chỉ</div>
          <div className={cls('ho-so-sv')} onClick={() => setPage('ho-so-sv')}>Hồ sơ sinh viên</div>
          <div className={cls('xet-chung-chi')} onClick={() => setPage('xet-chung-chi')}>Đề xuất xét cấp chứng chỉ SV</div>
          <div className={cls('khao-sat')} onClick={() => setPage('khao-sat')}>Khảo sát sự kiện</div>
          <div className={cls('xet-tn')} onClick={() => setPage('xet-tn')}>Đề xuất xét tốt nghiệp</div>
          <div className={cls('cu-nhan')} onClick={() => setPage('cu-nhan')}>Đăng ký CT Cử nhân/Kỹ sư</div>
        </div>
      </div>
      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.hoctap ? 'open' : ''}`} onClick={() => toggle('hoctap')}>
          <span>🎓 HỌC TẬP</span><span className={`caret ${open.hoctap ? 'open' : ''}`}>▾</span>
        </div>
        <div className={`sub-menu ${open.hoctap ? 'open' : ''}`}>
          <div className={cls('ket-qua-ht')} onClick={() => setPage('ket-qua-ht')}>Kết quả học tập</div>
          <div className={cls('lich-tuan')} onClick={() => setPage('lich-tuan')}>Lịch theo tuần</div>
          <div className={cls('lich-tien-do')} onClick={() => setPage('lich-tien-do')}>Lịch theo tiến độ</div>
          <div className={cls('diem-danh')} onClick={() => setPage('diem-danh')}>Thông tin điểm danh</div>
          <div className={cls('ren-luyen')} onClick={() => setPage('ren-luyen')}>Kết quả rèn luyện</div>
          <div className={cls('hoc-bong')} onClick={() => setPage('hoc-bong')}>Mức học bổng được xét</div>
        </div>
      </div>
      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.dkhp ? 'open' : ''}`} onClick={() => toggle('dkhp')}>
          <span>✅ ĐĂNG KÝ HỌC PHẦN</span><span className={`caret ${open.dkhp ? 'open' : ''}`}>▾</span>
        </div>
        <div className={`sub-menu ${open.dkhp ? 'open' : ''}`}>
          <div className={cls('ct-khung')} onClick={() => setPage('ct-khung')}>Chương trình khung</div>
          <div className={cls('dk-hp')} onClick={() => setPage('dk-hp')}>Đăng ký học phần</div>
          <div className={cls('dk-mon-dk')} onClick={() => setPage('dk-mon-dk')}>Đăng ký môn học điều kiện</div>
        </div>
      </div>
      <div className="sidebar-section">
        <div className={`sidebar-parent ${open.hocphi ? 'open' : ''}`} onClick={() => toggle('hocphi')}>
          <span>💳 HỌC PHÍ</span><span className={`caret ${open.hocphi ? 'open' : ''}`}>▾</span>
        </div>
        <div className={`sub-menu ${open.hocphi ? 'open' : ''}`}>
          <div className={cls('cong-no')} onClick={() => setPage('cong-no')}>Tra cứu công nợ</div>
          <div className={cls('tt-truc-tuyen')} onClick={() => setPage('tt-truc-tuyen')}>Thanh toán trực tuyến</div>
          <div className={cls('tt-noi-tru')} onClick={() => setPage('tt-noi-tru')}>Thanh toán nội trú</div>
          <div className={cls('phieu-thu-th')} onClick={() => setPage('phieu-thu-th')}>Phiếu thu tổng hợp</div>
          <div className={cls('phieu-thu-tt')} onClick={() => setPage('phieu-thu-tt')}>Phiếu thu trực tuyến</div>
        </div>
      </div>
    </aside>
  );
}