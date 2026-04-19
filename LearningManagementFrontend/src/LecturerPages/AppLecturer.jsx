import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import MainLayout from './components/Layout/MainLayout';

// Import toàn bộ 15 trang từ các thư mục
import Dashboard from './pages/Dashboard/Dashboard';
import Profile from './pages/Profile/Profile';
import Salary from './pages/Salary/Salary';
import Declaration from './pages/Declaration/Declaration';
import Documents from './pages/Documents/Documents';

import StudentAttendance from './pages/Attendance/StudentAttendance';
import QRCodeAttendance from './pages/Attendance/QRCodeAttendance';
import Assesment from './pages/Attendance/Assesment';

import Results from './pages/Results/Results';
import ProgressSchedule from './pages/Schedule/ProgressSchedule';
import WeeklySchedule from './pages/Schedule/WeeklySchedule';

import StopTeaching from './pages/Proposals/StopTeaching';
import MakeupTeaching from './pages/Proposals/MakeupTeaching';
import SubstituteTeaching from './pages/Proposals/SubstituteTeaching';

import Statistics from './pages/Statistics/Statistics';
import Survey from './pages/Survey/Survey';

// ĐÃ SỬA: Đổi tên function App thành AppLecturer
function AppLecturer() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          {/* Mặc định vào app sẽ nhảy tới trang Lịch tuần */}
          <Route index element={<Navigate to="/lich-tuan" />} />

          <Route path="dashboard" element={<Dashboard />} />
          <Route path="ho-so" element={<Profile />} />
          <Route path="luong" element={<Salary />} />
          <Route path="khai-bao" element={<Declaration />} />
          <Route path="tai-lieu" element={<Documents />} />

          <Route path="diem-danh" element={<StudentAttendance />} />
          <Route path="qr-code" element={<QRCodeAttendance />} />
          <Route path="phieu-danh-gia" element={<Assesment />} />

          <Route path="ket-qua" element={<Results />} />
          <Route path="lich-tien-do" element={<ProgressSchedule />} />
          <Route path="lich-tuan" element={<WeeklySchedule />} />

          <Route path="de-xuat-ngung" element={<StopTeaching />} />
          <Route path="day-bu" element={<MakeupTeaching />} />
          <Route path="day-thay" element={<SubstituteTeaching />} />

          <Route path="thong-ke" element={<Statistics />} />
          <Route path="khao-sat" element={<Survey />} />
        </Route>
      </Routes>
    </Router>
  );
}

// ĐÃ SỬA: Đổi tên export thành AppLecturer
export default AppLecturer;