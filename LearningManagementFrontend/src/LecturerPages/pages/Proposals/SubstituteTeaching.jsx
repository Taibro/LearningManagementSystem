import React from 'react';

const SubstituteTeaching = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Đề xuất dạy thay</h1>
        <p className="text-gray-400 text-sm mt-1 font-medium">Ủy quyền và gửi yêu cầu giảng viên khác dạy thay</p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 bg-white rounded-xl p-6 shadow-sm border border-[#E8E0F5]">
          <h3 className="font-bold text-gray-700 text-[11px] uppercase tracking-[2px] mb-6">Thông tin yêu cầu</h3>

          <div className="space-y-5">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Lớp học phần cần thay</label>
                <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-3 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-gray-50/30 font-medium">
                  <option>010110195604 - 14DHTH04</option>
                  <option>010110195605 - 16DHTH10</option>
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Ngày dạy cần thay</label>
                <input type="date" className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-3 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-gray-50/30" defaultValue="2026-04-22" />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Ca học</label>
                <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-3 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-gray-50/30 font-medium">
                  <option>Chiều (Tiết 7-9)</option>
                  <option>Sáng (Tiết 1-3)</option>
                  <option>Tối (Tiết 13-15)</option>
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Giảng viên thay thế</label>
                <select className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-3 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-gray-50/30 font-medium text-purple-700">
                  <option>Trần Thị B - Bộ môn CNTT</option>
                  <option>Lê Văn C - Bộ môn Mạng</option>
                  <option>Nguyễn Văn D - Bộ môn Phần mềm</option>
                </select>
              </div>
            </div>

            <div>
              <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Nội dung bài dạy thay</label>
              <textarea
                className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-3 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-white min-h-[100px]"
                placeholder="Mô tả chi tiết chương, bài học hoặc nội dung cần truyền đạt..."
              ></textarea>
            </div>

            <div>
              <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Lý do đề xuất</label>
              <textarea
                className="border-[1.5px] border-[#E0D8F0] rounded-lg px-3.5 py-3 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-white min-h-[80px]"
                placeholder="Nhập lý do cụ thể để phòng đào tạo phê duyệt..."
              ></textarea>
            </div>

            <div className="flex gap-4 pt-2">
              <button className="flex-1 bg-gradient-to-r from-[#6B4FA0] to-[#8B6BBF] text-white rounded-xl px-6 py-3.5 text-sm font-black shadow-lg shadow-purple-100 hover:translate-y-[-2px] transition-all active:scale-95 uppercase tracking-widest">
                Gửi đề xuất ngay
              </button>
              <button className="px-8 py-3.5 border-[1.5px] border-gray-200 text-gray-400 rounded-xl text-sm font-bold hover:bg-gray-50 transition-all active:scale-95 uppercase tracking-widest">
                Hủy
              </button>
            </div>
          </div>
        </div>

        <div className="space-y-6">
          <div className="bg-white rounded-xl p-6 shadow-sm border border-[#E8E0F5]">
            <h3 className="font-bold text-gray-700 text-[11px] uppercase tracking-widest mb-4">Lưu ý quy trình</h3>
            <ul className="space-y-3">
              <li className="flex gap-3 items-start">
                <span className="w-5 h-5 rounded-full bg-purple-100 text-[#6B4FA0] flex items-center justify-center text-[10px] font-bold shrink-0 mt-0.5">1</span>
                <p className="text-[12px] text-gray-500 leading-relaxed">Đề xuất cần gửi trước buổi dạy ít nhất **24 giờ**.</p>
              </li>
              <li className="flex gap-3 items-start">
                <span className="w-5 h-5 rounded-full bg-purple-100 text-[#6B4FA0] flex items-center justify-center text-[10px] font-bold shrink-0 mt-0.5">2</span>
                <p className="text-[12px] text-gray-500 leading-relaxed">Giảng viên dạy thay phải thuộc cùng bộ môn hoặc có chuyên môn tương đương.</p>
              </li>
              <li className="flex gap-3 items-start">
                <span className="w-5 h-5 rounded-full bg-purple-100 text-[#6B4FA0] flex items-center justify-center text-[10px] font-bold shrink-0 mt-0.5">3</span>
                <p className="text-[12px] text-gray-500 leading-relaxed">Yêu cầu chỉ có hiệu lực sau khi **Trưởng bộ môn** hoặc **Phòng đào tạo** phê duyệt.</p>
              </li>
            </ul>
          </div>

          <div className="bg-gradient-to-br from-orange-50 to-white rounded-xl p-6 shadow-sm border border-orange-100">
            <h3 className="font-bold text-orange-700 text-[11px] uppercase tracking-widest mb-3">Trạng thái gần đây</h3>
            <div className="p-3 bg-white border border-orange-100 rounded-lg shadow-sm">
              <div className="text-[11px] font-bold text-gray-800">14DHTH04 - Ca chiều</div>
              <div className="text-[10px] text-orange-500 font-bold mt-1 uppercase">Đang chờ duyệt</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SubstituteTeaching;