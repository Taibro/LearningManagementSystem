import React, { useState } from 'react';
import './student.css'; 
import Topbar from './components/Topbar';
import Sidebar from './components/Sidebar';
import * as Pages from './pages/Pages'; // Đã sửa đường dẫn trỏ vào thư mục pages

export default function AppStudent() {
  const [currentPage, setCurrentPage] = useState('dashboard');
  
  const renderPage = () => {
    
    switch (currentPage) {
      case 'dashboard': return <Dashboard setPage={setCurrentPage} />;
      case 'student-info': return <StudentInfo />;
      case 'notifications': return <Notifications />;
      case 'surveys': return <Surveys />;
      case 'grades': return <Grades />;
      case 'weekly-schedule': return <WeeklySchedule />;
      case 'progress-schedule': return <ProgressSchedule />;
      case 'attendance': return <Attendance />;
      case 'conduct-score': return <ConductScore />;
      case 'scholarships': return <Scholarships />;
      case 'curriculum': return <Curriculum />;
      case 'tuition-fee': return <TuitionFee />;
      case 'online-payment': return <OnlinePayment />;
      case 'general-receipts': return <GeneralReceipts />;
      case 'online-receipts': return <OnlineReceipts />;
      
      
      case 'declaration': return <DefaultPage title="Kê khai thông tin sinh viên" />;
      case 'services': return <DefaultPage title="Dịch vụ trực tuyến" />;
      case 'certificates': return <DefaultPage title="Đề xuất chứng chỉ" />;
      case 'student-profile': return <DefaultPage title="Hồ sơ sinh viên" />;
      case 'certificate-approval': return <DefaultPage title="Đề xuất xét cấp chứng chỉ SV" />;
      case 'graduation-approval': return <DefaultPage title="Đề xuất xét tốt nghiệp" />;
      case 'bachelor-registration': return <DefaultPage title="Đăng ký CT Cử nhân/Kỹ sư" />;
      case 'course-registration': return <DefaultPage title="Đăng ký học phần" />;
      case 'prerequisite-registration': return <DefaultPage title="Đăng ký môn học điều kiện" />;
      case 'dormitory-payment': return <DefaultPage title="Thanh toán nội trú" />;
      case 'change-password': return <DefaultPage title="Đổi mật khẩu" />;
      case 'student-mailbox': return <DefaultPage title="Hộp thư sinh viên" />;
      default: return <Dashboard setPage={setCurrentPage} />;
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