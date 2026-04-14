import React from 'react';

const ProgressSchedule = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Lịch theo tiến độ</h1>
        <p className="text-gray-400 text-sm mt-1">Xem tiến độ giảng dạy theo từng môn học</p>
      </div>
      <div className="card p-5 mb-5">
        <div className="grid grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Học kỳ</label>
            <select className="input-field">
              <option>HK2 - 2025-2026</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Môn học</label>
            <select className="input-field">
              <option>Tất cả môn học</option>
              <option>Kiến trúc máy tính</option>
              <option>Quản trị hệ thống mạng</option>
            </select>
          </div>
          <div className="flex items-end">
            <button className="btn-primary w-full">🔍 Xem tiến độ</button>
          </div>
        </div>
      </div>

      <div className="space-y-4">
        <div className="card p-5">
          <div className="flex items-center justify-between mb-3">
            <div>
              <h3 className="font-semibold text-gray-800">Kiến trúc máy tính (LT)</h3>
              <div className="text-sm text-gray-400">010100228915 - 16DHTH10 | 45 tiết</div>
            </div>
            <span className="px-3 py-1 bg-green-100 text-green-700 rounded-full text-xs font-semibold">Đang dạy</span>
          </div>
          <div className="flex items-center gap-3 mb-2">
            <div className="progress-bar flex-1">
              <div className="progress-fill" style={{ width: '65%' }}></div>
            </div>
            <span className="text-sm font-semibold text-purple-700">65%</span>
          </div>
          <div className="text-xs text-gray-400">Đã dạy: 29/45 tiết | Còn lại: 16 tiết</div>
          <div className="mt-3 flex gap-2 flex-wrap">
            <div className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">Chương 1: ✓</div>
            <div className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">Chương 2: ✓</div>
            <div className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">Chương 3: ✓</div>
            <div className="text-xs px-2 py-1 bg-yellow-50 text-yellow-600 rounded">Chương 4: 60%</div>
            <div className="text-xs px-2 py-1 bg-gray-50 text-gray-400 rounded">Chương 5: Chưa</div>
          </div>
        </div>

        <div className="card p-5">
          <div className="flex items-center justify-between mb-3">
            <div>
              <h3 className="font-semibold text-gray-800">Quản trị hệ thống mạng (LT)</h3>
              <div className="text-sm text-gray-400">010110197304 - 14DHTH04 | 60 tiết</div>
            </div>
            <span className="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">Đang dạy</span>
          </div>
          <div className="flex items-center gap-3 mb-2">
            <div className="progress-bar flex-1">
              <div className="progress-fill" style={{ width: '40%' }}></div>
            </div>
            <span className="text-sm font-semibold text-purple-700">40%</span>
          </div>
          <div className="text-xs text-gray-400">Đã dạy: 24/60 tiết | Còn lại: 36 tiết</div>
        </div>

        <div className="card p-5">
          <div className="flex items-center justify-between mb-3">
            <div>
              <h3 className="font-semibold text-gray-800">TH Quản trị hệ thống mạng (TH)</h3>
              <div className="text-sm text-gray-400">010110192400 - 14DHTH40 | 30 tiết</div>
            </div>
            <span className="px-3 py-1 bg-green-100 text-green-700 rounded-full text-xs font-semibold">Đang dạy</span>
          </div>
          <div className="flex items-center gap-3 mb-2">
            <div className="progress-bar flex-1">
              <div className="progress-fill" style={{ width: '80%' }}></div>
            </div>
            <span className="text-sm font-semibold text-purple-700">80%</span>
          </div>
          <div className="text-xs text-gray-400">Đã dạy: 24/30 tiết | Còn lại: 6 tiết</div>
        </div>
      </div>
    </div>
  );
};

export default ProgressSchedule;