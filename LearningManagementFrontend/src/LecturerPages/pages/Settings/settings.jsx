import React from 'react';

const Settings = () => {
  return (
    <div className="animate-fadeIn p-4 md:p-6 bg-gray-50/30 min-h-screen font-sans">
      <div className="mb-8">
        <h1 className="text-3xl font-extrabold text-gray-800">Cài đặt tài khoản</h1>
        <p className="text-gray-400 text-sm mt-1">Quản lý thông tin cá nhân và tuỳ chọn hệ thống</p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

        {/* Cột trái: Form thông tin */}
        <div className="lg:col-span-2 space-y-6">

          {/* Card 1: Thông tin cá nhân */}
          <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md">
            <h3 className="font-bold text-gray-800 text-lg mb-6 border-b border-gray-50 pb-3">Thông tin giảng viên</h3>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Họ và tên</label>
                <input
                  type="text"
                  defaultValue="Trần Lập Trình"
                  className="border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm font-medium text-gray-700 bg-gray-50/50"
                />
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Email (Trường cấp)</label>
                <input
                  type="email"
                  defaultValue="trinhtl@huit.edu.vn"
                  disabled
                  className="border-[1.5px] border-gray-100 rounded-lg px-4 py-2.5 w-full outline-none text-sm font-medium text-gray-400 bg-gray-100 cursor-not-allowed"
                />
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Khoa / Bộ môn</label>
                <input
                  type="text"
                  defaultValue="Khoa Công nghệ Thông tin"
                  className="border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm font-medium text-gray-700 bg-gray-50/50"
                />
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Số điện thoại</label>
                <input
                  type="text"
                  placeholder="Nhập số điện thoại liên hệ"
                  className="border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm font-medium text-gray-700 bg-white"
                />
              </div>
            </div>

            <div className="mt-6 flex justify-end">
              <button className="bg-gradient-to-r from-[#6B4FA0] to-[#8B6BBF] text-white rounded-lg px-8 py-2.5 text-sm font-bold shadow-md hover:translate-y-[-1px] transition-all active:scale-95">
                💾 Cập nhật hồ sơ
              </button>
            </div>
          </div>

          {/* Card 2: Đổi mật khẩu */}
          <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md">
            <h3 className="font-bold text-gray-800 text-lg mb-6 border-b border-gray-50 pb-3">Đổi mật khẩu</h3>

            <div className="space-y-4 max-w-md">
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Mật khẩu hiện tại</label>
                <input
                  type="password"
                  placeholder="••••••••"
                  className="border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-white"
                />
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Mật khẩu mới</label>
                <input
                  type="password"
                  placeholder="••••••••"
                  className="border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-white"
                />
              </div>
              <div>
                <label className="block text-[11px] font-black text-gray-400 uppercase mb-2 ml-1 tracking-widest">Xác nhận mật khẩu mới</label>
                <input
                  type="password"
                  placeholder="••••••••"
                  className="border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 w-full outline-none focus:border-[#6B4FA0] transition-all text-sm bg-white"
                />
              </div>
              <button className="mt-2 bg-white text-[#6B4FA0] border-[1.5px] border-[#6B4FA0] rounded-lg px-6 py-2.5 text-sm font-bold hover:bg-purple-50 transition-all active:scale-95">
                Đổi mật khẩu
              </button>
            </div>
          </div>

        </div>

        {/* Cột phải: Avatar & Tùy chọn */}
        <div className="space-y-6">

          {/* Card 3: Ảnh đại diện */}
          <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md flex flex-col items-center">
            <div className="w-32 h-32 rounded-full p-1 bg-gradient-to-r from-[#6B4FA0] to-[#E85D75] mb-4">
               <div className="w-full h-full bg-white rounded-full flex items-center justify-center overflow-hidden border-2 border-white">
                  {/* Tạm dùng icon thay cho ảnh thực tế */}
                  <span className="text-4xl font-black text-[#6B4FA0]">TL</span>
               </div>
            </div>
            <h4 className="font-bold text-gray-800 text-lg">Giảng viên</h4>
            <span className="px-4 py-1 mt-2 bg-purple-50 text-[#6B4FA0] rounded-full text-[10px] font-bold uppercase tracking-widest border border-purple-100">
              Instructor
            </span>
            <button className="mt-6 w-full text-[11px] font-black text-gray-400 uppercase tracking-widest border-[1.5px] border-gray-200 rounded-lg px-4 py-2.5 hover:border-[#6B4FA0] hover:text-[#6B4FA0] transition-all">
              Đổi ảnh đại diện
            </button>
          </div>

          {/* Card 4: Tùy chọn thông báo */}
          <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 transition-all hover:shadow-md">
            <h3 className="font-bold text-gray-800 text-lg mb-4 border-b border-gray-50 pb-3">Thông báo</h3>

            <div className="space-y-4">
              <label className="flex items-center justify-between cursor-pointer group">
                <span className="text-sm font-medium text-gray-600 group-hover:text-[#6B4FA0] transition-colors">Thông báo nộp bài từ sinh viên</span>
                <input type="checkbox" defaultChecked className="w-4 h-4 accent-[#6B4FA0]" />
              </label>
              <label className="flex items-center justify-between cursor-pointer group">
                <span className="text-sm font-medium text-gray-600 group-hover:text-[#6B4FA0] transition-colors">Tin nhắn nội bộ trường</span>
                <input type="checkbox" defaultChecked className="w-4 h-4 accent-[#6B4FA0]" />
              </label>
              <label className="flex items-center justify-between cursor-pointer group">
                <span className="text-sm font-medium text-gray-600 group-hover:text-[#6B4FA0] transition-colors">Nhắc nhở lịch chấm thi</span>
                <input type="checkbox" defaultChecked className="w-4 h-4 accent-[#6B4FA0]" />
              </label>
            </div>
          </div>

        </div>
      </div>
    </div>
  );
};

export default Settings;