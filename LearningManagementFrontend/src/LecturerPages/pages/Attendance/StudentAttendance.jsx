import React from 'react';

const StudentAttendance = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Điểm danh sinh viên</h1>
        <p className="text-gray-400 text-sm mt-1">Quản lý điểm danh theo buổi học</p>
      </div>

      {/* Filter card */}
      <div className="card p-5 mb-5">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Học kỳ</label>
            <select className="input-field">
              <option>HK2 - 2025-2026</option>
              <option>HK1 - 2025-2026</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Ngày điểm danh (*)</label>
            <input type="date" className="input-field" defaultValue="2026-02-03" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Chọn lớp học phần (*)</label>
            <select className="input-field">
              <option>010110195604 - 14DHTH04</option>
              <option>010110195603 - 14DHTH03</option>
              <option>010110195602 - 14DHTH02</option>
            </select>
          </div>
        </div>
        <div className="flex gap-3">
          <button className="btn-primary text-sm">🔍 Tìm lịch</button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-4 gap-4 mb-5">
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#6B4FA0,#8B6BBF)' }}>
          <div className="text-white text-xs opacity-75 font-medium">SĨ SỐ</div>
          <div className="text-white text-3xl font-bold mt-1">60</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#4CAF50,#66BB6A)' }}>
          <div className="text-white text-xs opacity-75 font-medium">CÓ MẶT</div>
          <div className="text-white text-3xl font-bold mt-1">58</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#E85D75,#EF5350)' }}>
          <div className="text-white text-xs opacity-75 font-medium">VẮNG KHÔNG PHÉP</div>
          <div className="text-white text-3xl font-bold mt-1">1</div>
        </div>
        <div className="stat-card" style={{ background: 'linear-gradient(135deg,#F5A623,#FFB74D)' }}>
          <div className="text-white text-xs opacity-75 font-medium">VẮNG CÓ PHÉP</div>
          <div className="text-white text-3xl font-bold mt-1">1</div>
        </div>
      </div>

      {/* Comment + Actions */}
      <div className="card p-5 mb-5">
        <label className="block text-sm font-medium text-gray-600 mb-2">Nhận xét lớp</label>
        <textarea className="input-field" rows="2" placeholder="Nhập nhận xét về buổi học..." defaultValue="Lớp học nghiêm túc, đúng giờ."></textarea>
        <div className="flex flex-wrap gap-2 mt-4">
          <button className="btn-primary text-sm">💾 Lưu điểm danh</button>
          <button className="btn-outline text-sm">📊 Xuất Excel</button>
          <button className="btn-outline text-sm">📄 Xuất file tổng hợp</button>
          <button className="btn-danger text-sm">🔄 Đồng bộ điểm danh</button>
        </div>
      </div>

      {/* Student Table */}
      <div className="card overflow-hidden">
        <div className="p-4 border-b border-gray-100 flex items-center justify-between">
          <h3 className="font-semibold text-gray-700">Danh sách sinh viên</h3>
          <input type="text" placeholder="Tìm kiếm sinh viên..." className="input-field w-56" />
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50 border-b border-gray-100">
                <th className="px-4 py-3 text-left font-semibold text-gray-600">STT</th>
                <th className="px-4 py-3 text-left font-semibold text-gray-600">Họ đệm</th>
                <th className="px-4 py-3 text-left font-semibold text-gray-600">Tên</th>
                <th className="px-4 py-3 text-left font-semibold text-gray-600">Ngày sinh</th>
                <th className="px-4 py-3 text-left font-semibold text-gray-600">Lớp học</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">Có phép</th>
                <th className="px-4 py-3 text-center font-semibold text-gray-600">Không phép</th>
              </tr>
            </thead>
            <tbody>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">1</td>
                <td className="px-4 py-3">Giếng Phát</td>
                <td className="px-4 py-3 font-medium">Ninh</td>
                <td className="px-4 py-3 text-gray-500">25/04/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH04</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">2</td>
                <td className="px-4 py-3">Kiều Tấn</td>
                <td className="px-4 py-3 font-medium">Phát</td>
                <td className="px-4 py-3 text-gray-500">10/09/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH13</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">3</td>
                <td className="px-4 py-3">Lê Trần</td>
                <td className="px-4 py-3 font-medium">Phú</td>
                <td className="px-4 py-3 text-gray-500">20/03/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH08</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" defaultChecked className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">4</td>
                <td className="px-4 py-3">Nguyễn Lê Quang</td>
                <td className="px-4 py-3 font-medium">Phú</td>
                <td className="px-4 py-3 text-gray-500">05/04/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH16</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">5</td>
                <td className="px-4 py-3">Lê Trần Hoàng</td>
                <td className="px-4 py-3 font-medium">Phúc</td>
                <td className="px-4 py-3 text-gray-500">05/04/2004</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH07</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">6</td>
                <td className="px-4 py-3">Nguyễn Hoài</td>
                <td className="px-4 py-3 font-medium">Phúc</td>
                <td className="px-4 py-3 text-gray-500">09/11/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH12</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">7</td>
                <td className="px-4 py-3">Đinh Tấn</td>
                <td className="px-4 py-3 font-medium">Phương</td>
                <td className="px-4 py-3 text-gray-500">29/11/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH13</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">8</td>
                <td className="px-4 py-3">Âu Gia</td>
                <td className="px-4 py-3 font-medium">Quốc</td>
                <td className="px-4 py-3 text-gray-500">17/08/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH12</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">9</td>
                <td className="px-4 py-3">Đoàn Anh</td>
                <td className="px-4 py-3 font-medium">Khôi</td>
                <td className="px-4 py-3 text-gray-500">14/09/2004</td>
                <td className="px-4 py-3"><span className="badge-present">13DHTH06</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">10</td>
                <td className="px-4 py-3">Nguyễn Duy</td>
                <td className="px-4 py-3 font-medium">Linh</td>
                <td className="px-4 py-3 text-gray-500">02/12/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH04</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">11</td>
                <td className="px-4 py-3">Cao Đức</td>
                <td className="px-4 py-3 font-medium">Mạnh</td>
                <td className="px-4 py-3 text-gray-500">16/11/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH12</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" defaultChecked className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">12</td>
                <td className="px-4 py-3">Phan Trọng</td>
                <td className="px-4 py-3 font-medium">Nghiêm</td>
                <td className="px-4 py-3 text-gray-500">12/10/2003</td>
                <td className="px-4 py-3"><span className="badge-present">12DHBM05</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" defaultChecked className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-3 text-gray-500">13</td>
                <td className="px-4 py-3">Võ Hồ Trọng</td>
                <td className="px-4 py-3 font-medium">Nhật</td>
                <td className="px-4 py-3 text-gray-500">02/08/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH16</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
              <tr className="table-row">
                <td className="px-4 py-3 text-gray-500">14</td>
                <td className="px-4 py-3">Đặng Đình</td>
                <td className="px-4 py-3 font-medium">Sang</td>
                <td className="px-4 py-3 text-gray-500">20/04/2005</td>
                <td className="px-4 py-3"><span className="badge-present">14DHTH09</span></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-purple-600" /></td>
                <td className="px-4 py-3 text-center"><input type="checkbox" className="w-4 h-4 accent-red-500" /></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default StudentAttendance;