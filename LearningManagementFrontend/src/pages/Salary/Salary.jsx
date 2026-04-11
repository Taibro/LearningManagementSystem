import React from 'react';

const Salary = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Thông tin lương</h1>
        <p className="text-gray-400 text-sm mt-1">Tra cứu bảng lương theo tháng</p>
      </div>
      <div className="card p-5 mb-5">
        <div className="grid grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Năm</label>
            <select className="input-field">
              <option>2026</option>
              <option>2025</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Tháng</label>
            <select className="input-field">
              <option>Tháng 3/2026</option>
              <option>Tháng 2/2026</option>
              <option>Tháng 1/2026</option>
            </select>
          </div>
          <div className="flex items-end">
            <button className="btn-primary w-full">🔍 Xem bảng lương</button>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-3 gap-4 mb-5">
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#4CAF50,#66BB6A)' }}>
          <div className="text-white text-xs opacity-75">Lương cơ bản</div>
          <div className="text-white text-2xl font-bold mt-1">12,500,000đ</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#6B4FA0,#8B6BBF)' }}>
          <div className="text-white text-xs opacity-75">Phụ cấp & thưởng</div>
          <div className="text-white text-2xl font-bold mt-1">3,200,000đ</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#E85D75,#EF5350)' }}>
          <div className="text-white text-xs opacity-75">Thực nhận (sau KT)</div>
          <div className="text-white text-2xl font-bold mt-1">14,800,000đ</div>
        </div>
      </div>

      <div className="card overflow-hidden">
        <div className="p-4 border-b border-gray-100">
          <h3 className="font-semibold text-gray-700">Chi tiết bảng lương - Tháng 3/2026</h3>
        </div>
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50">
              <th className="px-4 py-3 text-left font-semibold text-gray-600">Khoản mục</th>
              <th className="px-4 py-3 text-right font-semibold text-gray-600">Số tiền</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-600">Ghi chú</th>
            </tr>
          </thead>
          <tbody>
            <tr className="border-b border-gray-50">
              <td className="px-4 py-3">Lương cơ bản</td>
              <td className="px-4 py-3 text-right font-medium text-green-600">12,500,000đ</td>
              <td className="px-4 py-3 text-gray-400 text-xs">Hệ số 3.0</td>
            </tr>
            <tr className="border-b border-gray-50">
              <td className="px-4 py-3">Phụ cấp chức vụ</td>
              <td className="px-4 py-3 text-right font-medium text-green-600">800,000đ</td>
              <td className="px-4 py-3 text-gray-400 text-xs"></td>
            </tr>
            <tr className="border-b border-gray-50">
              <td className="px-4 py-3">Phụ cấp thâm niên</td>
              <td className="px-4 py-3 text-right font-medium text-green-600">1,200,000đ</td>
              <td className="px-4 py-3 text-gray-400 text-xs">8% lương CB</td>
            </tr>
            <tr className="border-b border-gray-50">
              <td className="px-4 py-3">Thưởng tiết dạy vượt</td>
              <td className="px-4 py-3 text-right font-medium text-green-600">1,200,000đ</td>
              <td className="px-4 py-3 text-gray-400 text-xs">12 tiết × 100,000đ</td>
            </tr>
            <tr className="border-b border-gray-50 bg-red-50">
              <td className="px-4 py-3 text-red-600">Bảo hiểm xã hội (8%)</td>
              <td className="px-4 py-3 text-right font-medium text-red-500">-1,000,000đ</td>
              <td className="px-4 py-3 text-gray-400 text-xs"></td>
            </tr>
            <tr className="border-b border-gray-50 bg-red-50">
              <td className="px-4 py-3 text-red-600">Thuế TNCN</td>
              <td className="px-4 py-3 text-right font-medium text-red-500">-1,100,000đ</td>
              <td className="px-4 py-3 text-gray-400 text-xs"></td>
            </tr>
            <tr className="bg-purple-50">
              <td className="px-4 py-3 font-bold text-purple-800">THỰC NHẬN</td>
              <td className="px-4 py-3 text-right font-bold text-purple-800 text-base">14,800,000đ</td>
              <td className="px-4 py-3"></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Salary;