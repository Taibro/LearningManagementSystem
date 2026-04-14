import React from 'react';

const StopTeaching = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Đề xuất tạm ngừng lịch dạy</h1>
        <p className="text-gray-400 text-sm mt-1">Yêu cầu tạm ngừng buổi dạy có lý do</p>
      </div>
      <div className="grid grid-cols-2 gap-5">
        <div className="card p-5">
          <h3 className="font-semibold text-gray-700 mb-4">Tạo đề xuất mới</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
              <select className="input-field">
                <option>010110195604 - 14DHTH04</option>
                <option>010110195603 - 14DHTH03</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ngày xin ngừng</label>
              <input type="date" className="input-field" defaultValue="2026-04-25" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ca học</label>
              <select className="input-field">
                <option>Sáng (Tiết 1-3)</option>
                <option>Chiều (Tiết 7-9)</option>
                <option>Tối (Tiết 13-15)</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Lý do</label>
              <textarea className="input-field" rows="3" placeholder="Nhập lý do xin tạm ngừng..."></textarea>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Đính kèm minh chứng</label>
              <input type="file" className="input-field text-sm" />
            </div>
            <button className="btn-primary w-full">📤 Gửi đề xuất</button>
          </div>
        </div>
        <div className="card p-5">
          <h3 className="font-semibold text-gray-700 mb-4">Lịch sử đề xuất</h3>
          <div className="space-y-3">
            <div className="border border-gray-100 rounded-lg p-3">
              <div className="flex items-center justify-between mb-1">
                <span className="font-medium text-sm">14DHTH04 - 15/03/2026</span>
                <span className="px-2 py-0.5 bg-green-100 text-green-700 text-xs rounded-full font-semibold">Đã duyệt</span>
              </div>
              <p className="text-xs text-gray-500">Lý do: Tham dự hội thảo khoa học quốc tế</p>
              <p className="text-xs text-gray-400 mt-1">Gửi lúc: 10/03/2026 08:30</p>
            </div>
            <div className="border border-gray-100 rounded-lg p-3">
              <div className="flex items-center justify-between mb-1">
                <span className="font-medium text-sm">14DHTH03 - 22/02/2026</span>
                <span className="px-2 py-0.5 bg-yellow-100 text-yellow-700 text-xs rounded-full font-semibold">Chờ duyệt</span>
              </div>
              <p className="text-xs text-gray-500">Lý do: Ốm, có giấy tờ y tế</p>
              <p className="text-xs text-gray-400 mt-1">Gửi lúc: 20/02/2026 14:15</p>
            </div>
            <div className="border border-gray-100 rounded-lg p-3">
              <div className="flex items-center justify-between mb-1">
                <span className="font-medium text-sm">16DHTH10 - 10/01/2026</span>
                <span className="px-2 py-0.5 bg-red-100 text-red-600 text-xs rounded-full font-semibold">Từ chối</span>
              </div>
              <p className="text-xs text-gray-500">Lý do: Việc gia đình</p>
              <p className="text-xs text-gray-400 mt-1">Gửi lúc: 08/01/2026 09:00</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default StopTeaching;