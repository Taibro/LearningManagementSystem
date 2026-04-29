import React, { useState } from 'react';
import './student.css'; 
import Topbar from './components/Topbar';
import Sidebar from './components/Sidebar';

import Dashboard from './pages/Dashboard/Dashboard';
import StudentInfo from './pages/StudentInfo/StudentInfo';
import Notifications from './pages/Notifications/Notifications';
import Surveys from './pages/Surveys/Surveys';
import Grades from './pages/Grades/Grades';
import WeeklySchedule from './pages/WeeklySchedule/WeeklySchedule';
import ProgressSchedule from './pages/ProgressSchedule/ProgressSchedule';
import Attendance from './pages/Attendance/Attendance';
import ConductScore from './pages/ConductScore/ConductScore';
import Scholarships from './pages/Scholarships/Scholarships';
import Curriculum from './pages/Curriculum/Curriculum';
import TuitionFee from './pages/TuitionFee/TuitionFee';
import OnlinePayment from './pages/OnlinePayment/OnlinePayment';
import GeneralReceipts from './pages/GeneralReceipts/GeneralReceipts';
import OnlineReceipts from './pages/OnlineReceipts/OnlineReceipts';
import DefaultPage from './pages/DefaultPage/DefaultPage';

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