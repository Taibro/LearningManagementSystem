import React from 'react';

const Dashboard = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Tổng quan hệ thống</h1>
        <p className="text-gray-400 text-sm mt-1">Chào mừng bạn trở lại HUIT E-Office</p>
      </div>

      <div className="grid grid-cols-4 gap-4 mb-5">
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#6B4FA0,#8B6BBF)' }}>
          <div className="text-white text-xs opacity-75">TỔNG SỐ LỚP</div>
          <div className="text-white text-3xl font-bold mt-1">5</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#4CAF50,#66BB6A)' }}>
          <div className="text-white text-xs opacity-75">SỐ TIẾT ĐÃ DẠY</div>
          <div className="text-white text-3xl font-bold mt-1">120</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#2196F3,#42A5F5)' }}>
          <div className="text-white text-xs opacity-75">LỊCH TRONG TUẦN</div>
          <div className="text-white text-3xl font-bold mt-1">8</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#F5A623,#FFB74D)' }}>
          <div className="text-white text-xs opacity-75">THÔNG BÁO MỚI</div>
          <div className="text-white text-3xl font-bold mt-1">2</div>
        </div>
      </div>

      <div className="card p-5">
        <h3 className="font-semibold text-gray-700 mb-4">Hướng dẫn sử dụng</h3>
        <p className="text-sm text-gray-600">Vui lòng sử dụng thanh menu bên trái để truy cập các chức năng quản lý giảng dạy, điểm danh sinh viên và các đề xuất.</p>
      </div>
    </div>
  );
};

export default Dashboard;