import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import './saas.css';

// Core Layout
import MainLayout from './components/Layout/MainLayout';

// Sub Pages
import Dashboard from './pages/Dashboard/Dashboard';
import Schools from './pages/Schools/Schools';
import BranchesRooms from './pages/Branches/BranchesRooms';
import Users from './pages/Users/Users';
import Teachers from './pages/Teachers/Teachers';
import Students from './pages/Students/Students';
import Schedules from './pages/Schedules/Schedules';
import Attendance from './pages/Attendance/Attendance';
import Enrollments from './pages/Enrollments/Enrollments';
import Rooms from './pages/Rooms/Rooms';
import Courses from './pages/Courses/Courses';
import Classes from './pages/Classes/Classes';
import Notifications from './pages/Notifications/Notifications';
import Exceptions from './pages/Exceptions/Exceptions';
import Settings from './pages/Settings/Settings';

// Các trang vừa được tách riêng
import Departments from './pages/Departments/Departments';
import AcademicYears from './pages/AcademicYears/AcademicYears';
import Semesters from './pages/Semesters/Semesters';
import Roles from './pages/Roles/Roles';
import Grades from './pages/Grades/Grades';
import Conduct from './pages/Conduct/Conduct';
import Invoices from './pages/Invoices/Invoices';
import Payments from './pages/Payments/Payments';

import SaaSAdminLogin from './pages/Login/SaaSAdminLogin';

export default function AppSaaS() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Navigate to="/saas/login" replace />} />
        
        
        <Route path="/saas/login" element={<SaaSAdminLogin />} />

        <Route path="/saas" element={<MainLayout />}>
          <Route index element={<Navigate to="dashboard" />} />
          
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="schools" element={<Schools />} />
          <Route path="branches" element={<BranchesRooms />} />
          <Route path="departments" element={<Departments />} />
          <Route path="rooms" element={<Rooms />} />
          
          {/* BO PHAN NAY */}
          {/* <Route path="academic_years" element={<AcademicYears />} />
          <Route path="semesters" element={<Semesters />} />
          <Route path="courses" element={<Courses />} />
          <Route path="classes" element={<Classes />} />
          <Route path="schedules" element={<Schedules />} /> */}
          
          {/* BO PHAN NAY */}
          <Route path="users" element={<Users />} />
          {/* <Route path="teachers" element={<Teachers />} />
          <Route path="students" element={<Students />} /> */}
          <Route path="roles" element={<Roles />} />
          
          {/* <Route path="enrollments" element={<Enrollments />} />
          <Route path="attendance" element={<Attendance />} />
          <Route path="grades" element={<Grades />} />
          <Route path="conduct" element={<Conduct />} /> */}
          
          {/* <Route path="invoices" element={<Invoices />} />
          <Route path="payments" element={<Payments />} /> */}
          
          {/* <Route path="notifications" element={<Notifications />} />
          <Route path="exceptions" element={<Exceptions />} />
          <Route path="settings" element={<Settings />} /> */}
        </Route>
        <Route path="*" element={<Navigate to="/saas/dashboard" replace />} />
      </Routes>
    </Router>
  );
}