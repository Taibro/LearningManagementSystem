import React from 'react';

const StudentAttendance = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6 flex justify-between items-end">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Điểm danh sinh viên</h1>
          <p className="text-gray-400 text-sm mt-1">Quản lý chuyên cần buổi học</p>
        </div>
        <div className="bg-white border-[1.5px] border-[#6B4FA0] text-[#6B4FA0] px-4 py-2 rounded-xl text-xs font-black shadow-sm tracking-wide">
          📅 29/04/2026
        </div>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
        <div className="card p-5 border-l-4 border-[#6B4FA0] flex flex-col items-center">
          <div className="text-gray-400 text-[10px] font-black uppercase tracking-tighter">Sĩ số</div>
          <div className="text-3xl font-black text-gray-800 mt-1">60</div>
        </div>
        <div className="card p-5 border-l-4 border-[#4CAF50] flex flex-col items-center">
          <div className="text-[#4CAF50] text-[10px] font-black uppercase tracking-tighter">Có mặt</div>
          <div className="text-3xl font-black text-[#2E7D32] mt-1">58</div>
        </div>
        <div className="card p-5 border-l-4 border-[#E85D75] flex flex-col items-center">
          <div className="text-[#E85D75] text-[10px] font-black uppercase tracking-tighter">Vắng</div>
          <div className="text-3xl font-black text-[#C62828] mt-1">02</div>
        </div>
        <div className="card p-5 border-l-4 border-[#F5A623] flex flex-col items-center">
          <div className="text-[#F5A623] text-[10px] font-black uppercase tracking-tighter">Tỷ lệ</div>
          <div className="text-3xl font-black text-[#F5A623] mt-1">96%</div>
        </div>
      </div>

      <div className="card overflow-hidden shadow-sm border border-gray-100">
        <div className="p-4 border-b border-gray-100 flex justify-between items-center bg-gray-50/30">
          <h3 className="font-bold text-gray-700 uppercase text-[10px] tracking-widest ml-2">Danh sách lớp 14DHTH04</h3>
          <div className="flex gap-2">
             <button className="btn-outline text-[10px] py-1.5 px-4 font-bold">📊 Excel</button>
             <button className="bg-[#E85D75] text-white rounded-lg text-[10px] py-1.5 px-4 font-bold hover:opacity-90">🔄 Đồng bộ</button>
          </div>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50 text-gray-500 border-b">
                <th className="px-6 py-4 text-left font-bold uppercase text-[10px]">STT</th>
                <th className="px-6 py-4 text-left font-bold uppercase text-[10px]">Sinh viên</th>
                <th className="px-6 py-4 text-center font-bold uppercase text-[10px]">Có mặt</th>
                <th className="px-6 py-4 text-center font-bold uppercase text-[10px]">Phép</th>
                <th className="px-6 py-4 text-center font-bold uppercase text-[10px]">KP</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {[1, 2, 3].map((i) => (
                <tr key={i} className="hover:bg-[#F9F7FF] transition-all">
                  <td className="px-6 py-4 text-gray-400 font-bold">{i}</td>
                  <td className="px-6 py-4">
                    <div className="font-bold text-gray-700">Nguyễn Văn {i === 1 ? 'Phát' : 'Phú'}</div>
                    <div className="text-[10px] font-bold text-gray-400 uppercase">MSSV: 14DHTH00{i}</div>
                  </td>
                  <td className="px-6 py-4 text-center"><input type="radio" name={`at-${i}`} className="w-5 h-5 accent-[#4CAF50]" defaultChecked /></td>
                  <td className="px-6 py-4 text-center"><input type="radio" name={`at-${i}`} className="w-5 h-5 accent-[#F5A623]" /></td>
                  <td className="px-6 py-4 text-center"><input type="radio" name={`at-${i}`} className="w-5 h-5 accent-[#E85D75]" /></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <div className="p-5 bg-gray-50/50 border-t border-gray-100 flex justify-end">
           <button className="btn-primary px-10 py-3 font-bold uppercase text-xs tracking-widest shadow-xl shadow-purple-200">
              💾 Lưu dữ liệu điểm danh
           </button>
        </div>
      </div>
    </div>
  );
};

export default StudentAttendance;