import React from 'react';

const Assesment = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Phiếu đánh giá</h1>
        <p className="text-gray-400 text-sm mt-1">Đánh giá chuyên cần và rèn luyện sinh viên</p>
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
          <div className="flex items-end">
            <button className="btn-primary w-full">🔍 Tải danh sách</button>
          </div>
        </div>
      </div>

      <div className="card overflow-hidden">
        <div className="p-4 border-b border-gray-100">
          <h3 className="font-semibold text-gray-700">Đánh giá rèn luyện - HK2 2025-2026</h3>
        </div>
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50">
              <th className="px-4 py-3 text-left font-semibold text-gray-600">Họ tên</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Thái độ</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Chuyên cần</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Kết quả HT</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Tổng điểm</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Xếp loại</th>
            </tr>
          </thead>
          <tbody>
            <tr className="table-row border-b border-gray-50">
              <td className="px-4 py-3 font-medium">Kiều Tấn Phát</td>
              <td className="px-4 py-3 text-center">
                <input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="25" max="25" />
              </td>
              <td className="px-4 py-3 text-center">
                <input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="30" max="30" />
              </td>
              <td className="px-4 py-3 text-center">
                <input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="40" max="40" />
              </td>
              <td className="px-4 py-3 text-center font-bold text-green-600">95</td>
              <td className="px-4 py-3 text-center">
                <span className="badge-present">Xuất sắc</span>
              </td>
            </tr>
            <tr className="table-row border-b border-gray-50">
              <td className="px-4 py-3 font-medium">Cao Đức Mạnh</td>
              <td className="px-4 py-3 text-center">
                <input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="20" max="25" />
              </td>
              <td className="px-4 py-3 text-center">
                <input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="25" max="30" />
              </td>
              <td className="px-4 py-3 text-center">
                <input type="number" className="w-14 text-center border rounded p-1 text-xs" defaultValue="30" max="40" />
              </td>
              <td className="px-4 py-3 text-center font-bold text-blue-600">75</td>
              <td className="px-4 py-3 text-center">
                <span className="px-2 py-0.5 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">Khá</span>
              </td>
            </tr>
          </tbody>
        </table>
        <div className="p-4 border-t border-gray-100 flex gap-2">
          <button className="btn-primary text-sm">💾 Lưu đánh giá</button>
        </div>
      </div>
    </div>
  );
};

export default Assesment;