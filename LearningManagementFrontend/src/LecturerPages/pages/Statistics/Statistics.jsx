import React from 'react';

const Statistics = () => {
  return (
    <div className="animate-fadeIn pb-10">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Thống kê thực giảng, coi thi</h1>
        <p className="text-gray-400 text-sm mt-1 font-medium">Chi tiết khối lượng giảng dạy học kỳ này</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        {[
          { label: 'Tổng số tiết dạy', val: '186', color: 'from-[#6B4FA0] to-[#8B6BBF]', shadow: 'shadow-purple-100', sub: 'HK2 - 2025-2026' },
          { label: 'Tiết lý thuyết', val: '120', color: 'from-[#4CAF50] to-[#66BB6A]', shadow: 'shadow-green-50', sub: '~ 65% khối lượng' },
          { label: 'Tiết thực hành', val: '66', color: 'from-[#5C6BC0] to-[#7986CB]', shadow: 'shadow-indigo-50', sub: '~ 35% khối lượng' },
          { label: 'Ca coi thi', val: '04', color: 'from-[#F5A623] to-[#FFB74D]', shadow: 'shadow-orange-50', sub: 'Sắp tới: 2 ca' }
        ].map((s, i) => (
          <div key={i} className={`p-5 bg-gradient-to-br ${s.color} rounded-xl shadow-lg ${s.shadow} hover:translate-y-[-4px] transition-all duration-300 group`}>
            <div className="text-white/80 text-[10px] font-black uppercase tracking-widest">{s.label}</div>
            <div className="text-white text-3xl font-black mt-2 group-hover:scale-105 transition-transform origin-left">{s.val}</div>
            <div className="text-white/60 text-[11px] mt-2 font-medium bg-black/10 px-2 py-1 rounded w-fit">{s.sub}</div>
          </div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
        <div className="lg:col-span-2 bg-white rounded-xl p-6 shadow-sm border border-purple-50">
          <h3 className="font-bold text-gray-700 text-sm uppercase mb-8">Biểu đồ tiết dạy theo tháng</h3>
          <div className="flex items-end justify-between gap-4 h-48 px-2">
            {[60, 85, 100, 75, 40, 10].map((h, i) => (
              <div key={i} className="flex flex-col items-center gap-3 flex-1 group">
                <div className="relative w-full flex justify-center items-end h-full">
                  <div
                    className={`w-full max-w-[40px] rounded-t-lg transition-all duration-300 cursor-pointer ${i === 2 ? 'bg-[#6B4FA0]' : h < 20 ? 'bg-gray-100' : 'bg-[#8B6BBF] opacity-50 hover:opacity-100'}`}
                    style={{ height: `${h}%` }}
                  >
                    <div className="opacity-0 group-hover:opacity-100 absolute -top-8 left-1/2 -translate-x-1/2 bg-gray-800 text-white text-[10px] px-2 py-1 rounded">T{i+1}</div>
                  </div>
                </div>
                <span className="text-[11px] font-bold text-gray-400">T{i+1}</span>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl p-6 shadow-sm border border-purple-50 space-y-4">
          <h3 className="font-bold text-gray-700 text-sm uppercase mb-2">Nhắc nhở</h3>
          <div className="p-4 bg-purple-50 rounded-xl border-l-4 border-[#6B4FA0] hover:bg-purple-100 transition-colors">
            <div className="text-[#6B4FA0] text-xs font-bold uppercase">Tiến độ</div>
            <p className="text-gray-600 text-[11px] mt-2 font-medium">Đã hoàn thành 72% kế hoạch học kỳ.</p>
          </div>
          <div className="p-4 bg-orange-50 rounded-xl border-l-4 border-[#F5A623] hover:bg-orange-100 transition-colors">
            <div className="text-[#F5A623] text-xs font-bold uppercase">Coi thi</div>
            <p className="text-gray-600 text-[11px] mt-2 font-medium">Có 2 ca coi thi vào tuần sau ngày 04/05.</p>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-purple-50 overflow-hidden">
        <div className="p-5 border-b border-purple-50 flex justify-between items-center bg-gray-50/50">
          <h3 className="font-bold text-gray-700 text-sm uppercase">Chi tiết môn dạy</h3>
          <button className="px-4 py-2 border-[1.5px] border-[#6B4FA0] text-[#6B4FA0] rounded-lg text-xs font-black hover:bg-[#6B4FA0] hover:text-white transition-all">Xuất báo cáo</button>
        </div>
        <table className="w-full text-[13px]">
          <thead>
            <tr className="bg-gray-50/50 text-gray-400 border-b border-purple-50 uppercase text-[11px] font-black">
              <th className="px-6 py-4 text-left">Môn học</th>
              <th className="px-6 py-4 text-left">Lớp HP</th>
              <th className="px-6 py-4 text-center">Tiết</th>
              <th className="px-6 py-4 text-center w-48">Tiến độ</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-purple-50">
            {[
              { n: 'Kiến trúc máy tính (LT)', c: '16DHTH10', t: 45, d: 29, p: '65%' },
              { n: 'Quản trị hệ thống mạng (LT)', c: '14DHTH04', t: 60, d: 24, p: '40%' },
              { n: 'Thực hành Quản trị HTM (TH)', c: '14DHTH40', t: 30, d: 24, p: '80%' }
            ].map((row, i) => (
              <tr key={i} className="hover:bg-purple-50/50 transition-colors group cursor-pointer">
                <td className="px-6 py-4 font-bold text-gray-700 group-hover:text-[#6B4FA0]">{row.n}</td>
                <td className="px-6 py-4 text-gray-500 font-medium">{row.c}</td>
                <td className="px-6 py-4 text-center font-bold text-gray-400">{row.d}/{row.t}</td>
                <td className="px-6 py-4">
                  <div className="flex items-center gap-3">
                    <div className="h-1.5 flex-1 bg-gray-100 rounded-full overflow-hidden">
                      <div className="h-full bg-gradient-to-r from-[#6B4FA0] to-[#E85D75]" style={{ width: row.p }}></div>
                    </div>
                    <span className="text-[11px] font-black text-gray-600">{row.p}</span>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Statistics;