import React from 'react';

const Salary = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Thông tin lương</h1>
        <p className="text-gray-400 text-sm mt-1">Tra cứu bảng lương theo tháng</p>
      </div>

      <div className="bg-white rounded-xl p-5 mb-5 shadow-sm border border-gray-100">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Năm</label>
            <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-2 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm">
              <option>2026</option>
              <option>2025</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Tháng</label>
            <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-2 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm">
              <option>Tháng 3/2026</option>
              <option>Tháng 2/2026</option>
              <option>Tháng 1/2026</option>
            </select>
          </div>
          <div className="flex items-end">
            <button className="w-full bg-gradient-to-r from-[#6B4FA0] to-[#8B6BBF] text-white rounded-lg px-5 py-2.5 font-medium transition-all hover:translate-y-[-1px] hover:shadow-lg hover:shadow-purple-200 active:scale-95">
              🔍 Xem bảng lương
            </button>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-5 text-white">
        <div className="rounded-xl p-5 relative overflow-hidden shadow-md" style={{ background: 'linear-gradient(135deg,#4CAF50,#66BB6A)' }}>
          <div className="text-xs opacity-80 font-medium uppercase tracking-wider">Lương cơ bản</div>
          <div className="text-2xl font-bold mt-1">12,500,000đ</div>
          <div className="absolute -top-4 -right-4 w-16 h-16 bg-white/10 rounded-full"></div>
        </div>
        <div className="rounded-xl p-5 relative overflow-hidden shadow-md" style={{ background: 'linear-gradient(135deg,#6B4FA0,#8B6BBF)' }}>
          <div className="text-xs opacity-80 font-medium uppercase tracking-wider">Phụ cấp & thưởng</div>
          <div className="text-2xl font-bold mt-1">3,200,000đ</div>
          <div className="absolute -top-4 -right-4 w-16 h-16 bg-white/10 rounded-full"></div>
        </div>
        <div className="rounded-xl p-5 relative overflow-hidden shadow-md" style={{ background: 'linear-gradient(135deg,#E85D75,#EF5350)' }}>
          <div className="text-xs opacity-80 font-medium uppercase tracking-wider">Thực nhận (sau KT)</div>
          <div className="text-2xl font-bold mt-1">14,800,000đ</div>
          <div className="absolute -top-4 -right-4 w-16 h-16 bg-white/10 rounded-full"></div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-4 border-b border-gray-100 bg-gray-50/50">
          <h3 className="font-semibold text-gray-700">Chi tiết bảng lương - Tháng 3/2026</h3>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50/80 text-gray-600 border-b">
                <th className="px-6 py-3 text-left font-bold uppercase text-[11px] tracking-wider">Khoản mục</th>
                <th className="px-6 py-3 text-right font-bold uppercase text-[11px] tracking-wider">Số tiền</th>
                <th className="px-6 py-3 text-left font-bold uppercase text-[11px] tracking-wider">Ghi chú</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              <tr className="hover:bg-purple-50/30 transition-colors">
                <td className="px-6 py-4">Lương cơ bản</td>
                <td className="px-6 py-4 text-right font-bold text-green-600">12,500,000đ</td>
                <td className="px-6 py-4 text-gray-400 text-xs italic">Hệ số 3.0</td>
              </tr>
              <tr className="hover:bg-purple-50/30 transition-colors">
                <td className="px-6 py-4">Phụ cấp chức vụ</td>
                <td className="px-6 py-4 text-right font-bold text-green-600">800,000đ</td>
                <td className="px-6 py-4 text-gray-400 text-xs"></td>
              </tr>
              <tr className="hover:bg-purple-50/30 transition-colors text-red-600 bg-red-50/30">
                <td className="px-6 py-4 font-medium">Bảo hiểm xã hội (8%)</td>
                <td className="px-6 py-4 text-right font-bold">-1,000,000đ</td>
                <td className="px-6 py-4 text-gray-400 text-xs"></td>
              </tr>
              <tr className="bg-purple-50/80">
                <td className="px-6 py-4 font-bold text-purple-800">THỰC NHẬN</td>
                <td className="px-6 py-4 text-right font-black text-purple-900 text-lg">14,800,000đ</td>
                <td className="px-6 py-4"></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Salary;