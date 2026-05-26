import React from 'react'
import ReactDOM from 'react-dom/client'
import AppLecturer from './LecturerPages/AppLecturer.jsx'
import './index.css'

import AppStudent from './StudentPages/AppStudent.jsx' 
import AppAdmin from './SchoolAdmin/AppAdmin.jsx'
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <AppLecturer />
    {/* <AppStudent/> */}
    {/* <AppAdmin/> */}
  </React.StrictMode>,
)