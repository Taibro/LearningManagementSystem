// import React from 'react';
//
// const Documents = () => {
//   return (
//     <div className="animate-fadeIn">
//       <div className="flex items-center justify-between mb-6">
//         <div>
//           <h1 className="text-2xl font-bold text-gray-800">Quản lý tài liệu bài giảng</h1>
//           <p className="text-gray-400 text-sm mt-1">Upload và quản lý slide, tài liệu giảng dạy</p>
//         </div>
//         <button className="btn-primary text-sm">+ Thêm tài liệu</button>
//       </div>
//       <div className="card p-5 mb-5">
//         <div className="grid grid-cols-3 gap-4">
//           <div>
//             <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
//             <select className="input-field">
//               <option>Tất cả lớp</option>
//               <option>014DHTH04</option>
//             </select>
//           </div>
//           <div>
//             <label className="block text-sm font-medium text-gray-600 mb-1.5">Loại tài liệu</label>
//             <select className="input-field">
//               <option>Tất cả</option>
//               <option>Slide bài giảng</option>
//               <option>Bài tập</option>
//               <option>Đề thi</option>
//             </select>
//           </div>
//           <div className="flex items-end">
//             <button className="btn-primary w-full">🔍 Tìm kiếm</button>
//           </div>
//         </div>
//       </div>
//       <div className="grid grid-cols-3 gap-4">
//         <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
//           <div className="flex items-start gap-3">
//             <div className="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center text-red-500 text-lg flex-shrink-0">📊</div>
//             <div className="flex-1 min-w-0">
//               <h4 className="font-semibold text-gray-800 text-sm truncate">Slide Chương 1 - Giới thiệu</h4>
//               <p className="text-xs text-gray-400 mt-0.5">Kiến trúc máy tính</p>
//               <div className="flex items-center gap-2 mt-2">
//                 <span className="text-xs text-gray-400">2.3 MB</span>
//                 <span className="text-xs text-gray-300">|</span>
//                 <span className="text-xs text-gray-400">15/01/2026</span>
//               </div>
//             </div>
//           </div>
//           <div className="flex gap-1 mt-3">
//             <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded hover:bg-purple-100">👁 Xem</button>
//             <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded hover:bg-blue-100">📥 Tải</button>
//             <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded hover:bg-red-100">🗑 Xóa</button>
//           </div>
//         </div>
//         <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
//           <div className="flex items-start gap-3">
//             <div className="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center text-blue-500 text-lg flex-shrink-0">📝</div>
//             <div className="flex-1 min-w-0">
//               <h4 className="font-semibold text-gray-800 text-sm truncate">Bài tập Chương 2</h4>
//               <p className="text-xs text-gray-400 mt-0.5">QTHTM - 14DHTH04</p>
//               <div className="flex items-center gap-2 mt-2">
//                 <span className="text-xs text-gray-400">450 KB</span>
//                 <span className="text-xs text-gray-300">|</span>
//                 <span className="text-xs text-gray-400">20/01/2026</span>
//               </div>
//             </div>
//           </div>
//           <div className="flex gap-1 mt-3">
//             <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">👁 Xem</button>
//             <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded">📥 Tải</button>
//             <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded">🗑 Xóa</button>
//           </div>
//         </div>
//         <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
//           <div className="flex items-start gap-3">
//             <div className="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center text-green-500 text-lg flex-shrink-0">📋</div>
//             <div className="flex-1 min-w-0">
//               <h4 className="font-semibold text-gray-800 text-sm truncate">Đề cương môn học</h4>
//               <p className="text-xs text-gray-400 mt-0.5">Kiến trúc máy tính</p>
//               <div className="flex items-center gap-2 mt-2">
//                 <span className="text-xs text-gray-400">128 KB</span>
//                 <span className="text-xs text-gray-300">|</span>
//                 <span className="text-xs text-gray-400">01/01/2026</span>
//               </div>
//             </div>
//           </div>
//           <div className="flex gap-1 mt-3">
//             <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">👁 Xem</button>
//             <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded">📥 Tải</button>
//             <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded">🗑 Xóa</button>
//           </div>
//         </div>
//       </div>
//     </div>
//   );
// };
//
// export default Documents;
import React, { useState } from 'react';
import { X, UploadCloud } from 'lucide-react';

const Documents = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  return (
    <>
      {/* 1. NỘI DUNG CHÍNH (Vẫn giữ hiệu ứng mượt mà) */}
      <div className="animate-fadeIn">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-800">Quản lý tài liệu bài giảng</h1>
            <p className="text-gray-400 text-sm mt-1">Upload và quản lý slide, tài liệu giảng dạy</p>
          </div>
          <button
            onClick={() => setIsModalOpen(true)}
            className="btn-primary text-sm"
          >
            + Thêm tài liệu
          </button>
        </div>

        <div className="card p-5 mb-5">
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
              <select className="input-field">
                <option>Tất cả lớp</option>
                <option>014DHTH04</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-600 mb-1.5">Loại tài liệu</label>
              <select className="input-field">
                <option>Tất cả</option>
                <option>Slide bài giảng</option>
                <option>Bài tập</option>
                <option>Đề thi</option>
              </select>
            </div>
            <div className="flex items-end">
              <button className="btn-primary w-full">🔍 Tìm kiếm</button>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-3 gap-4">
          <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
            <div className="flex items-start gap-3">
              <div className="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center text-red-500 text-lg flex-shrink-0">📊</div>
              <div className="flex-1 min-w-0">
                <h4 className="font-semibold text-gray-800 text-sm truncate">Slide Chương 1 - Giới thiệu</h4>
                <p className="text-xs text-gray-400 mt-0.5">Kiến trúc máy tính</p>
                <div className="flex items-center gap-2 mt-2">
                  <span className="text-xs text-gray-400">2.3 MB</span>
                  <span className="text-xs text-gray-300">|</span>
                  <span className="text-xs text-gray-400">15/01/2026</span>
                </div>
              </div>
            </div>
            <div className="flex gap-1 mt-3">
              <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded hover:bg-purple-100">👁 Xem</button>
              <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded hover:bg-blue-100">📥 Tải</button>
              <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded hover:bg-red-100">🗑 Xóa</button>
            </div>
          </div>

          <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
            <div className="flex items-start gap-3">
              <div className="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center text-blue-500 text-lg flex-shrink-0">📝</div>
              <div className="flex-1 min-w-0">
                <h4 className="font-semibold text-gray-800 text-sm truncate">Bài tập Chương 2</h4>
                <p className="text-xs text-gray-400 mt-0.5">QTHTM - 14DHTH04</p>
                <div className="flex items-center gap-2 mt-2">
                  <span className="text-xs text-gray-400">450 KB</span>
                  <span className="text-xs text-gray-300">|</span>
                  <span className="text-xs text-gray-400">20/01/2026</span>
                </div>
              </div>
            </div>
            <div className="flex gap-1 mt-3">
              <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">👁 Xem</button>
              <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded">📥 Tải</button>
              <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded">🗑 Xóa</button>
            </div>
          </div>

          <div className="card p-4 hover:shadow-md transition-shadow cursor-pointer">
            <div className="flex items-start gap-3">
              <div className="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center text-green-500 text-lg flex-shrink-0">📋</div>
              <div className="flex-1 min-w-0">
                <h4 className="font-semibold text-gray-800 text-sm truncate">Đề cương môn học</h4>
                <p className="text-xs text-gray-400 mt-0.5">Kiến trúc máy tính</p>
                <div className="flex items-center gap-2 mt-2">
                  <span className="text-xs text-gray-400">128 KB</span>
                  <span className="text-xs text-gray-300">|</span>
                  <span className="text-xs text-gray-400">01/01/2026</span>
                </div>
              </div>
            </div>
            <div className="flex gap-1 mt-3">
              <button className="text-xs px-2 py-1 bg-purple-50 text-purple-600 rounded">👁 Xem</button>
              <button className="text-xs px-2 py-1 bg-blue-50 text-blue-600 rounded">📥 Tải</button>
              <button className="text-xs px-2 py-1 bg-red-50 text-red-500 rounded">🗑 Xóa</button>
            </div>
          </div>
        </div>
      </div>

      {/* 2. POPUP FORM NẰM BÊN NGOÀI ĐỂ KHÔNG BỊ NHỐT */}
      {isModalOpen && (
        <div className="fixed inset-0 z-[9999] flex justify-center items-center bg-transparent pointer-events-auto">

          <div className="relative bg-white w-full max-w-xl rounded-2xl shadow-[0_20px_60px_-15px_rgba(0,0,0,0.3)] border border-gray-200 overflow-hidden transform transition-all animate-fadeIn">

            <div className="flex justify-between items-center px-6 py-4 border-b border-gray-100 bg-gray-50/50">
              <h3 className="font-extrabold text-lg text-gray-800">Thêm tài liệu mới</h3>
              <button
                onClick={() => setIsModalOpen(false)}
                className="text-gray-400 hover:text-red-500 bg-white hover:bg-red-50 p-1.5 rounded-lg transition-colors"
                title="Đóng"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="p-6 space-y-5">
              <div>
                <label className="block text-[12px] font-black text-gray-500 uppercase tracking-widest mb-2 ml-1">Tên tài liệu</label>
                <input
                  type="text"
                  className="w-full border-[1.5px] border-[#E0D8F0] rounded-lg px-4 py-2.5 focus:outline-none focus:border-[#8B6BBF] bg-gray-50/50 text-sm font-medium transition-colors"
                  placeholder="Nhập tên bài giảng, slide..."
                />
              </div>

              <div>
                <label className="block text-[12px] font-black text-gray-500 uppercase tracking-widest mb-2 ml-1">File đính kèm</label>
                <div className="border-2 border-dashed border-[#E0D8F0] rounded-xl p-8 flex flex-col items-center justify-center text-gray-400 hover:bg-purple-50 hover:border-[#8B6BBF] transition-all cursor-pointer group">
                    <UploadCloud className="w-10 h-10 mb-3 text-gray-300 group-hover:text-[#8B6BBF] transition-colors" />
                    <span className="text-sm font-bold text-gray-500">Kéo thả file vào đây</span>
                    <span className="text-xs mt-1">hoặc nhấn để duyệt file trên máy</span>
                </div>
              </div>
            </div>

            <div className="px-6 py-5 bg-gray-50 border-t border-gray-100 flex justify-end gap-3">
              <button
                onClick={() => setIsModalOpen(false)}
                className="px-6 py-2.5 text-sm font-bold text-gray-600 bg-white border-[1.5px] border-gray-200 rounded-lg hover:bg-gray-100 active:scale-95 transition-all"
              >
                Hủy bỏ
              </button>
              <button className="px-6 py-2.5 text-sm font-bold text-white bg-gradient-to-r from-[#6B4FA0] to-[#8B6BBF] rounded-lg hover:shadow-md active:scale-95 transition-all">
                Lưu tài liệu
              </button>
            </div>
          </div>

        </div>
      )}
    </>
  );
};

export default Documents;