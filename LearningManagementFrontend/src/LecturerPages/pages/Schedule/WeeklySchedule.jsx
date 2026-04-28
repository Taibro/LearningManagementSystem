import React from 'react';

const WeeklySchedule = () => {
  return (
    <div className="animate-fadeIn">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Lịch theo tuần</h1>
          <p className="text-gray-400 text-sm mt-1 font-medium">Tuần 20/04/2026 – 26/04/2026</p>
        </div>
        <div className="flex gap-2">
          <button className="flex items-center gap-1.5 px-4 py-2 border-[1.5px] border-[#6B4FA0] text-[#6B4FA0] rounded-lg text-sm font-semibold hover:bg-[#6B4FA0] hover:text-white transition-all active:scale-95">
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 19l-7-7 7-7"/></svg>
            Tuần trước
          </button>
          <button className="px-6 py-2 bg-gradient-to-r from-[#6B4FA0] to-[#8B6BBF] text-white rounded-lg text-sm font-bold shadow-md shadow-purple-200 hover:translate-y-[-1px] transition-all active:scale-95">
            Hôm nay
          </button>
          <button className="flex items-center gap-1.5 px-4 py-2 border-[1.5px] border-[#6B4FA0] text-[#6B4FA0] rounded-lg text-sm font-semibold hover:bg-[#6B4FA0] hover:text-white transition-all active:scale-95">
            Tuần sau
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"/></svg>
          </button>
        </div>
      </div>

      <div className="flex flex-wrap gap-4 mb-5 text-[12px]">
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-[#4CAF50]"></div><span className="text-gray-600 font-medium">Lịch dạy lý thuyết</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-[#5C6BC0]"></div><span className="text-gray-600 font-medium">Lịch dạy thực hành</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-[#FFC107]"></div><span className="text-gray-600 font-medium">Lịch trực tuyến</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-[#E85D75]"></div><span className="text-gray-600 font-medium">Lịch tạm ngừng</span></div>
      </div>

      <div className="bg-white rounded-xl shadow-lg shadow-purple-100 border border-[#E8E0F5] overflow-hidden">
        <div className="grid grid-cols-[80px_repeat(7,1fr)] items-stretch">
          {/* Header */}
          <div className="bg-[#6B4FA0] text-white py-3 text-center font-bold text-[11px] uppercase tracking-wider border-r border-white/10">Ca học</div>
          {['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'].map((day, idx) => (
            <div key={idx} className="bg-[#6B4FA0] text-white py-3 text-center border-r border-white/10 last:border-0">
              <div className="font-bold text-[13px]">{day}</div>
              <div className="text-purple-200 text-[10px] font-normal">{20 + idx}/04/2026</div>
            </div>
          ))}

          {/* SÁNG */}
          <div className="bg-[#F4F1F8] border-b border-r border-[#E8E0F5] flex items-center justify-center font-bold text-purple-600 text-[11px] tracking-widest min-h-[140px]">
            <span className="vertical-text uppercase">Sáng</span>
          </div>

          <div className="border-b border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]">
            <div className="bg-gradient-to-br from-[#E8F5E9] to-[#C8E6C9] border-l-4 border-[#4CAF50] rounded-lg p-3 shadow-sm hover:translate-y-[-2px] transition-all cursor-pointer h-full">
              <div className="font-bold text-[#1B5E20] text-[12px]">Kiến trúc máy tính (LT)</div>
              <div className="text-[#4CAF50] text-[10px] mt-1 font-semibold">010100228915 - 16DHTH10</div>
              <div className="text-[#4CAF50] text-[10px] font-medium">Tiết 1–3</div>
              <div className="text-[#2E7D32] text-[11px] font-bold mt-2 flex items-center gap-1">📍 A401</div>
            </div>
          </div>

          <div className="border-b border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]">
            <div className="bg-gradient-to-br from-[#E8F5E9] to-[#C8E6C9] border-l-4 border-[#4CAF50] rounded-lg p-3 shadow-sm hover:translate-y-[-2px] transition-all cursor-pointer h-full">
              <div className="font-bold text-[#1B5E20] text-[12px]">Quản trị HT mạng (LT)</div>
              <div className="text-[#4CAF50] text-[10px] mt-1 font-semibold">010100228913 - 16DHTH08</div>
              <div className="text-[#4CAF50] text-[10px] font-medium">Tiết 1–3</div>
              <div className="text-[#2E7D32] text-[11px] font-bold mt-2 flex items-center gap-1">📍 A402</div>
            </div>
          </div>

          {[...Array(5)].map((_, i) => (
             <div key={i} className="border-b border-r last:border-r-0 border-[#E8E0F5] p-2 bg-white"></div>
          ))}

          {/* CHIỀU */}
          <div className="bg-[#F4F1F8] border-b border-r border-[#E8E0F5] flex items-center justify-center font-bold text-purple-600 text-[11px] tracking-widest min-h-[140px]">
            <span className="vertical-text uppercase">Chiều</span>
          </div>
          {[...Array(7)].map((_, i) => (
            <div key={i} className="border-b border-r last:border-r-0 border-[#E8E0F5] p-2 bg-white min-h-[140px]"></div>
          ))}

          {/* TỐI */}
          <div className="bg-[#F4F1F8] border-r border-[#E8E0F5] flex items-center justify-center font-bold text-purple-600 text-[11px] tracking-widest min-h-[140px]">
            <span className="vertical-text uppercase">Tối</span>
          </div>

          <div className="border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]">
            <div className="bg-gradient-to-br from-[#E8EAF6] to-[#C5CAE9] border-l-4 border-[#5C6BC0] rounded-lg p-3 shadow-sm hover:translate-y-[-2px] transition-all cursor-pointer h-full">
              <div className="font-bold text-[#283593] text-[11px]">TH KT Máy tính (TH)</div>
              <div className="text-[#5C6BC0] text-[10px] mt-1 font-semibold">16DHTH10</div>
              <div className="text-[#3F51B5] text-[11px] font-bold mt-2">📍 C103</div>
            </div>
          </div>

          <div className="border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]">
            <div className="bg-gradient-to-br from-[#E8EAF6] to-[#C5CAE9] border-l-4 border-[#5C6BC0] rounded-lg p-3 shadow-sm hover:translate-y-[-2px] transition-all cursor-pointer h-full">
              <div className="font-bold text-[#283593] text-[11px]">TH KT Máy tính (TH)</div>
              <div className="text-[#5C6BC0] text-[10px] mt-1 font-semibold">16DHTH08</div>
              <div className="text-[#3F51B5] text-[11px] font-bold mt-2">📍 C103</div>
            </div>
          </div>

          <div className="border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]"></div>

          <div className="border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]">
            <div className="bg-gradient-to-br from-[#E8F5E9] to-[#C8E6C9] border-l-4 border-[#4CAF50] rounded-lg p-3 shadow-sm hover:translate-y-[-2px] transition-all cursor-pointer h-full">
              <div className="font-bold text-[#1B5E20] text-[12px]">Kiến trúc máy tính (LT)</div>
              <div className="text-[#4CAF50] text-[10px] mt-1 font-semibold">16DHTH11</div>
              <div className="text-[#2E7D32] text-[11px] font-bold mt-2">📍 B407</div>
            </div>
          </div>

          <div className="border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]">
            <div className="bg-gradient-to-br from-[#E8EAF6] to-[#C5CAE9] border-l-4 border-[#5C6BC0] rounded-lg p-3 shadow-sm hover:translate-y-[-2px] transition-all cursor-pointer h-full">
              <div className="font-bold text-[#283593] text-[11px]">TH Quản trị HTM (TH)</div>
              <div className="text-[#5C6BC0] text-[10px] mt-1 font-semibold">14DHTH40</div>
              <div className="text-[#3F51B5] text-[11px] font-bold mt-2">📍 A107</div>
            </div>
          </div>

          <div className="border-r border-[#E8E0F5] p-2 bg-white min-h-[140px]"></div>
          <div className="p-2 bg-white min-h-[140px]"></div>
        </div>
      </div>
    </div>
  );
};

export default WeeklySchedule;