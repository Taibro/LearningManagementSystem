import { Outlet } from 'react-router-dom';
import Sidebar from './Sidebar';

const MainLayout = () => {
  return (
    <div className="flex h-screen overflow-hidden bg-gray-100">
      <Sidebar />
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Topbar mẫu */}
        <header className="h-16 bg-white border-b flex items-center justify-between px-6 shrink-0">
          <div className="flex items-center gap-2">
             <span className="text-gray-500">Dashboard /</span>
             <span className="text-purple-700 font-medium">HUIT E-Office</span>
          </div>
          <div className="flex items-center gap-3">
            <div className="text-right">
              <div className="text-sm font-bold">Nguyễn Văn A</div>
              <div className="text-xs text-gray-400">Giảng viên</div>
            </div>
            <div className="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center text-white">GV</div>
          </div>
        </header>


        <main className="flex-1 overflow-y-auto bg-[#F4F1F8]">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default MainLayout;