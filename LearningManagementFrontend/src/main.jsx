import React from 'react'
import ReactDOM from 'react-dom/client'
import './index.css'
import AppSaaS from './SaaSAdminSystem/AppSaaS.jsx'
import AppStudent from './StudentPages/AppStudent.jsx'
import AppAdmin from './SchoolAdmin/AppAdmin.jsx'
import AppLecturer from './LecturerPages/AppLecturer.jsx'

const currentPath = window.location.pathname;

let AppToRender;

if (currentPath.startsWith('/saas')) {
  AppToRender = <AppSaaS />;
} else if (currentPath.startsWith('/admin')) {
  AppToRender = <AppAdmin />;
} else if (currentPath.startsWith('/lecturer')) {
  AppToRender = <AppLecturer />;
} else if (currentPath.startsWith('/student')) {
  AppToRender = <AppStudent />;
} else {
  window.location.replace('/student');
}

if (AppToRender) {
  ReactDOM.createRoot(document.getElementById('root')).render(
    <React.StrictMode>
      {AppToRender}
    </React.StrictMode>,
  )
}