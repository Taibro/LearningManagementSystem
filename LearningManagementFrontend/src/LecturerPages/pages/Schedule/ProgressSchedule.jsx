import React from 'react';

const ProgressSchedule = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Lịch theo tiến độ</h1>
        <p className="text-gray-400 text-sm mt-1">Xem tiến độ giảng dạy theo từng môn học</p>
      </div>

      <div className="bg-white rounded-xl p-5 mb-5 shadow-sm border border-gray-100">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Học kỳ</label>
            <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-gray-50/50">
              <option>HK2 - 2025-2026</option>
            </select>
          </div>
          <div>
            <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Môn học</label>
            <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-gray-50/50">
              <option>Tất cả môn học</option>
              <option>Kiến trúc máy tính</option>
              <option>Quản trị hệ thống mạng</option>
            </select>
          </div>
          <div className="flex items-end">
            <button className="bg-gradient-to-r from-[#6B4FA0] to-[#8B6BBF] text-white rounded-lg px-8 py-2.5 text-sm font-bold shadow-md hover:translate-y-[-1px] transition-all active:scale-95 w-full">
              🔍 Xem tiến độ ngay
            </button>
          </div>
        </div>
      </div>

      <div className="space-y-4">
        <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="font-bold text-gray-800 text-lg">Kiến trúc máy tính (LT)</h3>
              <div className="text-xs font-bold text-gray-400 mt-0.5 tracking-wider uppercase">010100228915 - 16DHTH10 | 45 tiết</div>
            </div>
            <span className="px-4 py-1 bg-green-50 text-green-600 rounded-full text-[10px] font-bold uppercase tracking-widest border border-green-100">Đang dạy</span>
          </div>

          <div className="flex items-center gap-4 mb-3">
            <div className="h-2.5 flex-1 bg-gray-100 rounded-full overflow-hidden border border-gray-50">
              <div
                className="h-full rounded-full transition-all duration-1000 ease-out"
                style={{ width: '65%', background: 'linear-gradient(90deg, #6B4FA0, #E85D75)' }}
              ></div>
            </div>
            <span className="text-sm font-black text-[#6B4FA0]">65%</span>
          </div>

          <div className="text-[11px] font-bold text-gray-400 flex gap-4">
            <span>Đã dạy: <span className="text-purple-600">29/45</span> tiết</span>
            <span>Còn lại: <span className="text-[#E85D75]">16</span> tiết</span>
          </div>

          <div className="mt-4 flex gap-2 flex-wrap">
            <div className="text-[10px] font-bold px-3 py-1 bg-purple-50 text-[#6B4FA0] rounded-lg border border-purple-100">Chương 1: ✓</div>
            <div className="text-[10px] font-bold px-3 py-1 bg-purple-50 text-[#6B4FA0] rounded-lg border border-purple-100">Chương 2: ✓</div>
            <div className="text-[10px] font-bold px-3 py-1 bg-purple-50 text-[#6B4FA0] rounded-lg border border-purple-100">Chương 3: ✓</div>
            <div className="text-[10px] font-bold px-3 py-1 bg-yellow-50 text-yellow-600 rounded-lg border border-yellow-100">Chương 4: 60%</div>
            <div className="text-[10px] font-bold px-3 py-1 bg-gray-50 text-gray-400 rounded-lg border border-gray-100">Chương 5: Chưa</div>
          </div>
        </div>

        <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="font-bold text-gray-800 text-lg">Quản trị hệ thống mạng (LT)</h3>
              <div className="text-xs font-bold text-gray-400 mt-0.5 tracking-wider uppercase">010110197304 - 14DHTH04 | 60 tiết</div>
            </div>
            <span className="px-4 py-1 bg-blue-50 text-blue-600 rounded-full text-[10px] font-bold uppercase tracking-widest border border-blue-100">Đang dạy</span>
          </div>

          <div className="flex items-center gap-4 mb-3">
            <div className="h-2.5 flex-1 bg-gray-100 rounded-full overflow-hidden border border-gray-50">
              <div
                className="h-full rounded-full transition-all duration-1000 ease-out"
                style={{ width: '40%', background: 'linear-gradient(90deg, #6B4FA0, #E85D75)' }}
              ></div>
            </div>
            <span className="text-sm font-black text-[#6B4FA0]">40%</span>
          </div>

          <div className="text-[11px] font-bold text-gray-400 flex gap-4">
            <span>Đã dạy: <span className="text-purple-600">24/60</span> tiết</span>
            <span>Còn lại: <span className="text-[#E85D75]">36</span> tiết</span>
          </div>
        </div>

        <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="font-bold text-gray-800 text-lg">TH Quản trị hệ thống mạng (TH)</h3>
              <div className="text-xs font-bold text-gray-400 mt-0.5 tracking-wider uppercase">010110192400 - 14DHTH40 | 30 tiết</div>
            </div>
            <span className="px-4 py-1 bg-green-50 text-green-600 rounded-full text-[10px] font-bold uppercase tracking-widest border border-green-100">Đang dạy</span>
          </div>

          <div className="flex items-center gap-4 mb-3">
            <div className="h-2.5 flex-1 bg-gray-100 rounded-full overflow-hidden border border-gray-50">
              <div
                className="h-full rounded-full transition-all duration-1000 ease-out"
                style={{ width: '80%', background: 'linear-gradient(90deg, #6B4FA0, #E85D75)' }}
              ></div>
            </div>
            <span className="text-sm font-black text-[#6B4FA0]">80%</span>
          </div>

          <div className="text-[11px] font-bold text-gray-400 flex gap-4">
            <span>Đã dạy: <span className="text-purple-600">24/30</span> tiết</span>
            <span>Còn lại: <span className="text-[#E85D75]">6</span> tiết</span>
          </div>
        </div>
      </div>
    </div>
  );
};
export default ProgressSchedule;