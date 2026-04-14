import React from 'react';

const Documents = () => {
  return (
    <div className="animate-fadeIn">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Quản lý tài liệu bài giảng</h1>
          <p className="text-gray-400 text-sm mt-1">Upload và quản lý slide, tài liệu giảng dạy</p>
        </div>
        <button className="btn-primary text-sm">+ Thêm tài liệu</button>
      </div>
      <div className="card p-5 mb-5">
        <div className="grid grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
            <select className="input-field">
              <option>Tất cả lớp</option>
              <option>014DHTH04</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Loại tài liệu</label>
            <select className="input-field">
              <option>Tất cả</option>
              <option>Slide bài giảng</option>
              <option>Bài tập</option>
              <option>Đề thi</option>
            </select>
          </div>
          <div className="flex items-end">
            <button className="btn-primary w-full">🔍 Tìm kiếm</button>
          </div>
        </div>
      </div>
      <div className="grid grid-cols-3 gap-4">
        <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center text-red-500 text-lg flex-shrink-0">📊</div>
            <div className="flex-1 min-w-0">
              <h4 className="font-semibold text-gray-800 text-sm truncate">Slide Chương 1 - Giới thiệu</h4>
              <p className="text-xs text-gray-400 mt-0.5">Kiến trúc máy tính</p>
              <div className="flex items-center gap-2 mt-2">
                <span className="text-xs text-gray-400">2.3 MB</span>
                <span className="text-xs text-gray-300">|</span>
                <span className="text-xs text-gray-400">15/01/2026</span>
              </div>
            </div>
          </div>
          <div className="flex gap-1 mt-3">
            <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded hover:bg-purple-100">👁 Xem</button>
            <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded hover:bg-blue-100">📥 Tải</button>
            <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded hover:bg-red-100">🗑 Xóa</button>
          </div>
        </div>
        <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center text-blue-500 text-lg flex-shrink-0">📝</div>
            <div className="flex-1 min-w-0">
              <h4 className="font-semibold text-gray-800 text-sm truncate">Bài tập Chương 2</h4>
              <p className="text-xs text-gray-400 mt-0.5">QTHTM - 14DHTH04</p>
              <div className="flex items-center gap-2 mt-2">
                <span className="text-xs text-gray-400">450 KB</span>
                <span className="text-xs text-gray-300">|</span>
                <span className="text-xs text-gray-400">20/01/2026</span>
              </div>
            </div>
          </div>
          <div className="flex gap-1 mt-3">
            <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">👁 Xem</button>
            <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded">📥 Tải</button>
            <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded">🗑 Xóa</button>
          </div>
        </div>
        <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center text-green-500 text-lg flex-shrink-0">📋</div>
            <div className="flex-1 min-w-0">
              <h4 className="font-semibold text-gray-800 text-sm truncate">Đề cương môn học</h4>
              <p className="text-xs text-gray-400 mt-0.5">Kiến trúc máy tính</p>
              <div className="flex items-center gap-2 mt-2">
                <span className="text-xs text-gray-400">128 KB</span>
                <span className="text-xs text-gray-300">|</span>
                <span className="text-xs text-gray-400">01/01/2026</span>
              </div>
            </div>
          </div>
          <div className="flex gap-1 mt-3">
            <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">👁 Xem</button>
            <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded">📥 Tải</button>
            <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded">🗑 Xóa</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Documents;