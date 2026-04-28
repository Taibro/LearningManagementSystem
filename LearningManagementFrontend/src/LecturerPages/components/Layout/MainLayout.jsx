import React from 'react';
import { Outlet } from 'react-router-dom';
import Sidebar from './Sidebar';

const MainLayout = () => {
  return (
    <div className="flex h-screen overflow-hidden bg-gray-100">
      <Sidebar />
      <div className="flex-1 flex flex-col overflow-hidden relative">
        <div className="topbar bg-white px-6 py-3 flex items-center justify-between border-b border-gray-200">
          <div className="flex items-center gap-2 text-sm">
             <span className="text-gray-500 font-bold">Dashboard</span>
             <span className="text-gray-400">/</span>
             <span className="text-gray-700">HUIT E-Office</span>
          </div>
          <div className="flex items-center gap-3">
             <div className="text-right">
                <div className="text-sm font-bold text-gray-800">Nguyễn Văn A</div>
                <div className="text-xs text-gray-400">Giảng viên</div>
             </div>
             <div className="w-10 h-10 rounded-full bg-gradient-to-br from-purple-500 to-pink-500 flex items-center justify-center text-white font-bold text-sm">GV</div>
          </div>
        </div>
        <main className="flex-1 overflow-y-auto p-6 bg-[#F4F1F8]">
          <Outlet />
        </main>
      </div>
    </div>
  );
};
export default MainLayout;