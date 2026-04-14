import React from 'react';

const Statistics = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Thống kê thực giảng, coi thi</h1>
        <p className="text-gray-400 text-sm mt-1">Báo cáo giờ dạy thực tế và coi thi</p>
      </div>
      <div className="grid grid-cols-4 gap-4 mb-5">
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#6B4FA0,#8B6BBF)' }}>
          <div className="text-white text-xs opacity-75">Tổng số tiết dạy</div>
          <div className="text-white text-3xl font-bold mt-1">186</div>
          <div className="text-purple-200 text-xs mt-1">HK2 - 2025-2026</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#4CAF50,#66BB6A)' }}>
          <div className="text-white text-xs opacity-75">Tiết dạy lý thuyết</div>
          <div className="text-white text-3xl font-bold mt-1">120</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#2196F3,#42A5F5)' }}>
          <div className="text-white text-xs opacity-75">Tiết dạy thực hành</div>
          <div className="text-white text-3xl font-bold mt-1">66</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#F5A623,#FFB74D)' }}>
          <div className="text-white text-xs opacity-75">Ca coi thi</div>
          <div className="text-white text-3xl font-bold mt-1">4</div>
        </div>
      </div>

      {/* Chart */}
      <div className="card p-5 mb-5">
        <h3 className="font-semibold text-gray-700 mb-4">Biểu đồ tiết dạy theo tháng</h3>
        <div className="flex items-end gap-3 h-40">
          <div className="flex flex-col items-center gap-1 flex-1">
            <div className="chart-bar w-full bg-purple-400" style={{ height: '60px' }}></div>
            <span className="text-xs text-gray-400">T1</span>
          </div>
          <div className="flex flex-col items-center gap-1 flex-1">
            <div className="chart-bar w-full bg-purple-400" style={{ height: '90px' }}></div>
            <span className="text-xs text-gray-400">T2</span>
          </div>
          <div className="flex flex-col items-center gap-1 flex-1">
            <div className="chart-bar w-full bg-purple-600" style={{ height: '120px' }}></div>
            <span className="text-xs text-gray-400">T3</span>
          </div>
          <div className="flex flex-col items-center gap-1 flex-1">
            <div className="chart-bar w-full bg-purple-400" style={{ height: '80px' }}></div>
            <span className="text-xs text-gray-400">T4</span>
          </div>
          <div className="flex flex-col items-center gap-1 flex-1">
            <div className="chart-bar w-full bg-gray-200" style={{ height: '40px' }}></div>
            <span className="text-xs text-gray-400">T5</span>
          </div>
          <div className="flex flex-col items-center gap-1 flex-1">
            <div className="chart-bar w-full bg-gray-200" style={{ height: '0px' }}></div>
            <span className="text-xs text-gray-400">T6</span>
          </div>
        </div>
      </div>

      <div className="card overflow-hidden">
        <div className="p-4 border-b border-gray-100 flex justify-between items-center">
          <h3 className="font-semibold text-gray-700">Danh sách môn dạy HK2 - 2025-2026</h3>
          <button className="btn-outline text-sm">📊 Xuất báo cáo</button>
        </div>
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50">
              <th className="px-4 py-3 text-left font-semibold text-gray-600">Môn học</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-600">Lớp</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Tổng tiết</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Đã dạy</th>
              <th className="px-4 py-3 text-center font-semibold text-gray-600">Tiến độ</th>
            </tr>
          </thead>
          <tbody>
            <tr className="table-row border-b border-gray-50">
              <td className="px-4 py-3 font-medium">Kiến trúc máy tính (LT)</td>
              <td className="px-4 py-3 text-gray-500">16DHTH10</td>
              <td className="px-4 py-3 text-center">45</td>
              <td className="px-4 py-3 text-center">29</td>
              <td className="px-4 py-3">
                <div className="progress-bar"><div className="progress-fill" style={{ width: '65%' }}></div></div>
              </td>
            </tr>
            <tr className="table-row border-b border-gray-50">
              <td className="px-4 py-3 font-medium">QTHTM (LT)</td>
              <td className="px-4 py-3 text-gray-500">14DHTH04</td>
              <td className="px-4 py-3 text-center">60</td>
              <td className="px-4 py-3 text-center">24</td>
              <td className="px-4 py-3">
                <div className="progress-bar"><div className="progress-fill" style={{ width: '40%' }}></div></div>
              </td>
            </tr>
            <tr className="table-row">
              <td className="px-4 py-3 font-medium">TH QTHTM</td>
              <td className="px-4 py-3 text-gray-500">14DHTH40</td>
              <td className="px-4 py-3 text-center">30</td>
              <td className="px-4 py-3 text-center">24</td>
              <td className="px-4 py-3">
                <div className="progress-bar"><div className="progress-fill" style={{ width: '80%' }}></div></div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Statistics;