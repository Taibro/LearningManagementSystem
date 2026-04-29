import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import './student.css'; 

import MainLayout from './components/Layout/MainLayout';
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
  return (
    <Router>
      <Routes>
        
        <Route path="/" element={<MainLayout />}>
          
          
          <Route index element={<Navigate to="/dashboard" />} />

          <Route path="dashboard" element={<Dashboard />} />
          <Route path="student-info" element={<StudentInfo />} />
          <Route path="notifications" element={<Notifications />} />
          <Route path="surveys" element={<Surveys />} />
          <Route path="grades" element={<Grades />} />
          <Route path="weekly-schedule" element={<WeeklySchedule />} />
          <Route path="progress-schedule" element={<ProgressSchedule />} />
          <Route path="attendance" element={<Attendance />} />
          <Route path="conduct-score" element={<ConductScore />} />
          <Route path="scholarships" element={<Scholarships />} />
          <Route path="curriculum" element={<Curriculum />} />
          <Route path="tuition-fee" element={<TuitionFee />} />
          <Route path="online-payment" element={<OnlinePayment />} />
          <Route path="general-receipts" element={<GeneralReceipts />} />
          <Route path="online-receipts" element={<OnlineReceipts />} />

          
          <Route path="declaration" element={<DefaultPage title="Kê khai thông tin sinh viên" />} />
          <Route path="services" element={<DefaultPage title="Dịch vụ trực tuyến" />} />
          <Route path="certificates" element={<DefaultPage title="Đề xuất chứng chỉ" />} />
          <Route path="student-profile" element={<DefaultPage title="Hồ sơ sinh viên" />} />
          <Route path="certificate-approval" element={<DefaultPage title="Đề xuất xét cấp chứng chỉ SV" />} />
          <Route path="graduation-approval" element={<DefaultPage title="Đề xuất xét tốt nghiệp" />} />
          <Route path="bachelor-registration" element={<DefaultPage title="Đăng ký CT Cử nhân/Kỹ sư" />} />
          <Route path="course-registration" element={<DefaultPage title="Đăng ký học phần" />} />
          <Route path="prerequisite-registration" element={<DefaultPage title="Đăng ký môn học điều kiện" />} />
          <Route path="dormitory-payment" element={<DefaultPage title="Thanh toán nội trú" />} />
        </Route>
      </Routes>
    </Router>
  );
}