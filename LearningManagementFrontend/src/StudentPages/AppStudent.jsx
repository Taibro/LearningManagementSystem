import React, { useState } from 'react';
// Import CSS riêng của sinh viên, KHÔNG dùng chung App.css hay index.css bên ngoài
import './student.css'; 

import Topbar from './components/Topbar';
import Sidebar from './components/Sidebar';
import * as Pages from './pages/Pages'; // Đã sửa đường dẫn trỏ vào thư mục pages

export default function AppStudent() {
  const [currentPage, setCurrentPage] = useState('trang-chu');
  
  const renderPage = () => {
    switch (currentPage) {
      case 'trang-chu': return <Pages.TrangChu setPage={setCurrentPage} />;
      case 'thong-tin-sv': return <Pages.ThongTinSV />;
      case 'nhac-nho': return <Pages.NhacNho />;
      case 'khao-sat': return <Pages.KhaoSat />;
      case 'ket-qua-ht': return <Pages.KetQuaHT />;
      case 'lich-tuan': return <Pages.LichTuan />;
      case 'lich-tien-do': return <Pages.LichTienDo />;
      case 'diem-danh': return <Pages.DiemDanh />;
      case 'ren-luyen': return <Pages.RenLuyen />;
      case 'hoc-bong': return <Pages.HocBong />;
      case 'ct-khung': return <Pages.CTKhung />;
      case 'cong-no': return <Pages.CongNo />;
      case 'tt-truc-tuyen': return <Pages.TTTrucTuyen />;
      case 'phieu-thu-th': return <Pages.PhieuThuTH />;
      case 'phieu-thu-tt': return <Pages.PhieuThuTT />;
      // Mapping các trang dự phòng
      case 'ke-khai': return <Pages.DefaultPage title="Kê khai thông tin sinh viên" />;
      case 'dich-vu': return <Pages.DefaultPage title="Dịch vụ trực tuyến" />;
      case 'chung-chi': return <Pages.DefaultPage title="Đề xuất chứng chỉ" />;
      case 'ho-so-sv': return <Pages.DefaultPage title="Hồ sơ sinh viên" />;
      case 'xet-chung-chi': return <Pages.DefaultPage title="Đề xuất xét cấp chứng chỉ SV" />;
      case 'xet-tn': return <Pages.DefaultPage title="Đề xuất xét tốt nghiệp" />;
      case 'cu-nhan': return <Pages.DefaultPage title="Đăng ký CT Cử nhân/Kỹ sư" />;
      case 'dk-hp': return <Pages.DefaultPage title="Đăng ký học phần" />;
      case 'dk-mon-dk': return <Pages.DefaultPage title="Đăng ký môn học điều kiện" />;
      case 'tt-noi-tru': return <Pages.DefaultPage title="Thanh toán nội trú" />;
      default: return <Pages.TrangChu setPage={setCurrentPage} />;
    }
  };

  return (
    // Bọc toàn bộ trong 1 div có class chuyên biệt (tùy chọn) để bọc CSS
    <div className="student-portal-wrapper">
      <Topbar setPage={setCurrentPage} />
      <div className="layout">
        <Sidebar activePage={currentPage} setPage={setCurrentPage} />
        <main className="main">
          {renderPage()}
        </main>
      </div>
    </div>
  );
}