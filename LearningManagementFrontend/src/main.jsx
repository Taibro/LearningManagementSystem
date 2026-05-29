import React from 'react'
import ReactDOM from 'react-dom/client'
import AppLecturer from './LecturerPages/AppLecturer.jsx'
import './index.css'
import AppSaaS from './SaaSAdminSystem/AppSaaS.jsx'
import AppStudent from './StudentPages/AppStudent.jsx'
import AppAdmin from './SchoolAdmin/AppAdmin.jsx'

const currentPath = window.location.pathname;
const isSaaS = currentPath.startsWith('/saas');
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    {/* <AppLecturer /> */}
    <AppStudent />
    {/* <AppAdmin/> */}
    {/* <AppSaaS/>  */}
    {isSaaS ? <AppSaaS /> : <AppAdmin />}
  </React.StrictMode>,
)