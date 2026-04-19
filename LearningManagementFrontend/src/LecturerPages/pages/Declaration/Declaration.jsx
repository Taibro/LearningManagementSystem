import React from 'react';

const Declaration = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Khai báo thông tin</h1>
        <p className="text-gray-400 text-sm mt-1">Cập nhật thông tin giảng dạy học kỳ</p>
      </div>
      <div className="card p-6">
        <div className="grid grid-cols-2 gap-5">
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Họ và tên giảng viên</label>
            <input className="input-field" defaultValue="Nguyễn Văn A" readOnly />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Mã giảng viên</label>
            <input className="input-field" defaultValue="GV001" readOnly />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Khoa / Bộ môn</label>
            <input className="input-field" defaultValue="Công nghệ thông tin" readOnly />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Học kỳ khai báo</label>
            <select className="input-field">
              <option>HK2 - 2025-2026</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Số tiết dạy dự kiến</label>
            <input type="number" className="input-field" defaultValue="120" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Số lớp phụ trách</label>
            <input type="number" className="input-field" defaultValue="5" />
          </div>
          <div className="col-span-2">
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Ghi chú</label>
            <textarea className="input-field" rows="3" placeholder="Nhập ghi chú (nếu có)..."></textarea>
          </div>
        </div>
        <div className="flex gap-3 mt-5">
          <button className="btn-primary">💾 Lưu khai báo</button>
          <button className="btn-outline">🔄 Đặt lại</button>
        </div>
      </div>
    </div>
  );
};

export default Declaration;