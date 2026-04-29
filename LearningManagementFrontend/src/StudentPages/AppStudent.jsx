import React, { useState } from 'react';
import './student.css'; 
import Topbar from './components/Topbar';
import Sidebar from './components/Sidebar';


import TrangChu from './pages/TrangChu/TrangChu';
import ThongTinSV from './pages/ThongTinSV/ThongTinSV';
import NhacNho from './pages/NhacNho/NhacNho';
import KhaoSat from './pages/KhaoSat/KhaoSat';
import KetQuaHT from './pages/KetQuaHT/KetQuaHT';
import LichTuan from './pages/LichTuan/LichTuan';
import LichTienDo from './pages/LichTienDo/LichTienDo';
import DiemDanh from './pages/DiemDanh/DiemDanh';
import RenLuyen from './pages/RenLuyen/RenLuyen';
import HocBong from './pages/HocBong/HocBong';
import CTKhung from './pages/CTKhung/CTKhung';
import CongNo from './pages/CongNo/CongNo';
import TTTrucTuyen from './pages/TTTrucTuyen/TTTrucTuyen';
import PhieuThuTH from './pages/PhieuThuTH/PhieuThuTH';
import PhieuThuTT from './pages/PhieuThuTT/PhieuThuTT';
import DefaultPage from './pages/DefaultPage/DefaultPage';

export default function AppStudent() {
  const [currentPage, setCurrentPage] = useState('trang-chu');
  
  const renderPage = () => {
    switch (currentPage) {
      case 'trang-chu': return <TrangChu setPage={setCurrentPage} />;
      case 'thong-tin-sv': return <ThongTinSV />;
      case 'nhac-nho': return <NhacNho />;
      case 'khao-sat': return <KhaoSat />;
      case 'ket-qua-ht': return <KetQuaHT />;
      case 'lich-tuan': return <LichTuan />;
      case 'lich-tien-do': return <LichTienDo />;
      case 'diem-danh': return <DiemDanh />;
      case 'ren-luyen': return <RenLuyen />;
      case 'hoc-bong': return <HocBong />;
      case 'ct-khung': return <CTKhung />;
      case 'cong-no': return <CongNo />;
      case 'tt-truc-tuyen': return <TTTrucTuyen />;
      case 'phieu-thu-th': return <PhieuThuTH />;
      case 'phieu-thu-tt': return <PhieuThuTT />;
      
      // Các trang phụ dùng DefaultPage
      case 'ke-khai': return <DefaultPage title="Kê khai thông tin sinh viên" />;
      case 'dich-vu': return <DefaultPage title="Dịch vụ trực tuyến" />;
      case 'chung-chi': return <DefaultPage title="Đề xuất chứng chỉ" />;
      case 'ho-so-sv': return <DefaultPage title="Hồ sơ sinh viên" />;
      case 'xet-chung-chi': return <DefaultPage title="Đề xuất xét cấp chứng chỉ SV" />;
      case 'xet-tn': return <DefaultPage title="Đề xuất xét tốt nghiệp" />;
      case 'cu-nhan': return <DefaultPage title="Đăng ký CT Cử nhân/Kỹ sư" />;
      case 'dk-hp': return <DefaultPage title="Đăng ký học phần" />;
      case 'dk-mon-dk': return <DefaultPage title="Đăng ký môn học điều kiện" />;
      case 'tt-noi-tru': return <DefaultPage title="Thanh toán nội trú" />;
      default: return <TrangChu setPage={setCurrentPage} />;
    }
  };

  return (
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