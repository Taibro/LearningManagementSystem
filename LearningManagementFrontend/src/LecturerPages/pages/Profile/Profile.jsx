import React from 'react';

const Profile = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Hồ sơ cá nhân</h1>
        <p className="text-gray-400 text-sm mt-1">Thông tin cá nhân giảng viên</p>
      </div>
      <div className="grid grid-cols-3 gap-5">
        <div className="card p-6 flex flex-col items-center">
          <div className="w-24 h-24 rounded-full bg-gradient-to-br from-purple-500 to-pink-500 flex items-center justify-center text-white text-3xl font-bold mb-4">GV</div>
          <h3 className="font-bold text-gray-800 text-lg">Nguyễn Văn A</h3>
          <p className="text-gray-400 text-sm">Giảng viên chính</p>
          <p className="text-purple-600 text-sm font-medium mt-1">Bộ môn Mạng máy tính</p>
          <button className="btn-outline mt-4 text-sm w-full">📷 Đổi ảnh đại diện</button>
        </div>
        <div className="card p-5 col-span-2">
          <h3 className="font-semibold text-gray-700 mb-4">Thông tin cơ bản</h3>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Họ và tên</label>
              <input className="input-field text-sm" defaultValue="Nguyễn Văn A" />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Ngày sinh</label>
              <input type="date" className="input-field text-sm" defaultValue="1985-05-15" />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Giới tính</label>
              <select className="input-field text-sm">
                <option>Nam</option>
                <option>Nữ</option>
              </select>
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Số CMND/CCCD</label>
              <input className="input-field text-sm" defaultValue="079085012345" />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Email</label>
              <input className="input-field text-sm" defaultValue="nguyenvana@huit.edu.vn" />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Số điện thoại</label>
              <input className="input-field text-sm" defaultValue="0901234567" />
            </div>
            <div className="col-span-2">
              <label className="block text-xs font-medium text-gray-500 mb-1">Địa chỉ</label>
              <input className="input-field text-sm" defaultValue="140 Lê Trọng Tấn, Tân Phú, TP.HCM" />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Trình độ học vấn</label>
              <select className="input-field text-sm">
                <option>Thạc sĩ</option>
                <option>Tiến sĩ</option>
              </select>
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Chuyên ngành</label>
              <input className="input-field text-sm" defaultValue="Khoa học máy tính" />
            </div>
          </div>
          <button className="btn-primary mt-4 text-sm">💾 Cập nhật thông tin</button>
        </div>
      </div>
    </div>
  );
};

export default Profile;