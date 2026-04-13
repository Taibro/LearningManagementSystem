import React from 'react';

const MakeupTeaching = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Đề xuất dạy bù</h1>
        <p className="text-gray-400 text-sm mt-1">Lên lịch bù cho các buổi đã nghỉ</p>
      </div>
      <div className="grid grid-cols-2 gap-5">
        <div className="card p-5">
          <h3 className="font-semibold text-gray-700 mb-4">Tạo lịch dạy bù</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
              <select className="input-field">
                <option>010110195604 - 14DHTH04</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Buổi nghỉ gốc</label>
              <select className="input-field">
                <option>22/02/2026 - Ca sáng</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ngày dạy bù</label>
              <input type="date" className="input-field" defaultValue="2026-04-26" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ca học bù</label>
              <select className="input-field">
                <option>Sáng (Tiết 1-3)</option>
                <option>Chiều</option>
                <option>Tối</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Phòng học đề xuất</label>
              <input className="input-field" placeholder="VD: A401" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ghi chú</label>
              <textarea className="input-field" rows="2" placeholder="Ghi chú thêm..."></textarea>
            </div>
            <button className="btn-primary w-full">📤 Gửi đề xuất dạy bù</button>
          </div>
        </div>
        <div className="card p-5">
          <h3 className="font-semibold text-gray-700 mb-4">Trạng thái dạy bù</h3>
          <div className="space-y-3">
            <div className="p-3 border border-green-200 bg-green-50 rounded-lg">
              <div className="flex justify-between items-center">
                <span className="font-medium text-sm text-green-800">14DHTH04 - Bù 15/03</span>
                <span className="text-xs bg-green-200 text-green-700 px-2 py-0.5 rounded-full font-semibold">✓ Đã dạy bù</span>
              </div>
              <p className="text-xs text-green-600 mt-1">Ca sáng, Phòng A401, 15/03/2026</p>
            </div>
            <div className="p-3 border border-yellow-200 bg-yellow-50 rounded-lg">
              <div className="flex justify-between items-center">
                <span className="font-medium text-sm text-yellow-800">14DHTH03 - Bù 26/04</span>
                <span className="text-xs bg-yellow-200 text-yellow-700 px-2 py-0.5 rounded-full font-semibold">⏳ Chờ duyệt</span>
              </div>
              <p className="text-xs text-yellow-600 mt-1">Ca sáng, Phòng đề xuất A202</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default MakeupTeaching;