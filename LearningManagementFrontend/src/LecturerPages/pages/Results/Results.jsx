import React from 'react';

const Results = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Quản lý kết quả học tập</h1>
        <p className="text-gray-400 text-sm mt-1">Nhập và quản lý điểm số sinh viên</p>
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
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
            <select className="input-field">
              <option>010110195604 - 14DHTH04</option>
            </select>
          </div>
          <div className="flex items-end gap-2">
            <button className="btn-primary flex-1">🔍 Tìm</button>
            <button className="btn-outline">📊 Xuất Excel</button>
          </div>
        </div>
      </div>

      {/* Score summary cards */}
      <div className="grid grid-cols-4 gap-4 mb-5">
        <div className="card p-4 text-center">
          <div className="text-2xl font-bold text-purple-700">7.8</div>
          <div className="text-xs text-gray-400 mt-1">Điểm TB lớp</div>
        </div>
        <div className="card p-4 text-center">
          <div className="text-2xl font-bold text-green-600">42</div>
          <div className="text-xs text-gray-400 mt-1">Đạt (≥5.0)</div>
        </div>
        <div className="card p-4 text-center">
          <div className="text-2xl font-bold text-red-500">3</div>
          <div className="text-xs text-gray-400 mt-1">Không đạt</div>
        </div>
        <div className="card p-4 text-center">
          <div className="text-2xl font-bold text-yellow-600">15</div>
          <div className="text-xs text-gray-400 mt-1">Xuất sắc (≥9.0)</div>
        </div>
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50 border-b">
                <th className="px-4 py-3 text-left font-semibold text-gray-600">STT</th>
                <th className="px-4 py-3 text-left font-semibold text-gray-600">Họ tên</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">MSSV</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">CC (10%)</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">GK (30%)</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">CK (60%)</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">Tổng</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">Xếp loại</th>
              </tr>
            </thead>
            <tbody>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">1</td>
                <td className="px-4 py-3 font-medium">Kiều Tấn Phát</td>
                <td className="px-4 py-3 text-center text-gray-500">14DHTH13001</td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="9" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="8.5" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="9.2" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center font-bold text-green-600">9.1</td>
                <td className="px-4 py-3 text-center"><span className="badge-present">Xuất sắc</span></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">2</td>
                <td className="px-4 py-3 font-medium">Cao Đức Mạnh</td>
                <td className="px-4 py-3 text-center text-gray-500">14DHTH12007</td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="7" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="6.5" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="7.8" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center font-bold text-blue-600">7.3</td>
                <td className="px-4 py-3 text-center"><span className="px-2 py-0.5 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">Khá</span></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">3</td>
                <td className="px-4 py-3 font-medium">Phan Trọng Nghiêm</td>
                <td className="px-4 py-3 text-center text-gray-500">12DHBM05001</td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="4" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="3.5" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center"><input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="4.2" min="0" max="10" /></td>
                <td className="px-4 py-3 text-center font-bold text-red-500">3.9</td>
                <td className="px-4 py-3 text-center"><span className="badge-absent">Không đạt</span></td>
              </tr>
            </tbody>
          </table>
        </div>
        <div className="p-4 border-t border-gray-100 flex gap-2">
          <button className="btn-primary text-sm">💾 Lưu điểm</button>
          <button className="btn-outline text-sm">🔄 Khóa điểm</button>
        </div>
      </div>
    </div>
  );
};

export default Results;