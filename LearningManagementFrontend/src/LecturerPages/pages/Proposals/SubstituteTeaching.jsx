import React from 'react';

const SubstituteTeaching = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Đề xuất dạy thay</h1>
        <p className="text-gray-400 text-sm mt-1">Yêu cầu giảng viên khác dạy thay</p>
      </div>
      <div className="card p-5">
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần cần thay</label>
              <select className="input-field">
                <option>010110195604 - 14DHTH04</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ngày dạy cần thay</label>
              <input type="date" className="input-field" defaultValue="2026-04-22" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Ca học</label>
              <select className="input-field">
                <option>Chiều (Tiết 7-9)</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Giảng viên thay thế</label>
              <select className="input-field">
                <option>Trần Thị B - Bộ môn CNTT</option>
                <option>Lê Văn C - Bộ môn Mạng</option>
              </select>
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Nội dung bài cần dạy thay</label>
            <textarea className="input-field" rows="3" placeholder="Mô tả nội dung buổi học cần dạy thay..."></textarea>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Lý do</label>
            <textarea className="input-field" rows="2" placeholder="Lý do cần dạy thay..."></textarea>
          </div>
          <div className="flex gap-3">
            <button className="btn-primary">📤 Gửi đề xuất</button>
            <button className="btn-outline">Hủy</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SubstituteTeaching;