import React from 'react';

const Survey = () => {
  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Khảo sát</h1>
        <p className="text-gray-400 text-sm mt-1">Kết quả khảo sát giảng dạy từ sinh viên</p>
      </div>
      <div className="grid grid-cols-4 gap-4 mb-5">
        <div className="card p-4 text-center">
          <div className="text-3xl font-bold text-purple-700">4.6</div>
          <div className="text-yellow-400 text-lg">★★★★★</div>
          <div className="text-xs text-gray-400 mt-1">Điểm TB giảng dạy</div>
        </div>
        <div className="card p-4 text-center">
          <div className="text-3xl font-bold text-green-600">95%</div>
          <div className="text-xs text-gray-400 mt-1">Sinh viên hài lòng</div>
        </div>
        <div className="card p-4 text-center">
          <div className="text-3xl font-bold text-blue-600">3</div>
          <div className="text-xs text-gray-400 mt-1">Lớp đã khảo sát</div>
        </div>
        <div className="card p-4 text-center">
          <div className="text-3xl font-bold text-orange-500">128</div>
          <div className="text-xs text-gray-400 mt-1">Lượt phản hồi</div>
        </div>
      </div>
      <div className="card p-5 mb-5">
        <h3 className="font-semibold text-gray-700 mb-4">Kết quả theo tiêu chí</h3>
        <div className="space-y-4">
          <div>
            <div className="flex justify-between text-sm mb-1.5">
              <span className="text-gray-600">Kiến thức chuyên môn</span>
              <span className="font-semibold text-purple-700">4.8/5</span>
            </div>
            <div className="progress-bar"><div className="progress-fill" style={{ width: '96%' }}></div></div>
          </div>
          <div>
            <div className="flex justify-between text-sm mb-1.5">
              <span className="text-gray-600">Phương pháp giảng dạy</span>
              <span className="font-semibold text-purple-700">4.5/5</span>
            </div>
            <div className="progress-bar"><div className="progress-fill" style={{ width: '90%' }}></div></div>
          </div>
          <div>
            <div className="flex justify-between text-sm mb-1.5">
              <span className="text-gray-600">Tương tác với sinh viên</span>
              <span className="font-semibold text-purple-700">4.7/5</span>
            </div>
            <div className="progress-bar"><div className="progress-fill" style={{ width: '94%' }}></div></div>
          </div>
          <div>
            <div className="flex justify-between text-sm mb-1.5">
              <span className="text-gray-600">Tài liệu giảng dạy</span>
              <span className="font-semibold text-purple-700">4.4/5</span>
            </div>
            <div className="progress-bar"><div className="progress-fill" style={{ width: '88%' }}></div></div>
          </div>
          <div>
            <div className="flex justify-between text-sm mb-1.5">
              <span className="text-gray-600">Đúng giờ, kỷ luật</span>
              <span className="font-semibold text-purple-700">4.9/5</span>
            </div>
            <div className="progress-bar"><div className="progress-fill" style={{ width: '98%' }}></div></div>
          </div>
        </div>
      </div>
      <div className="card p-5">
        <h3 className="font-semibold text-gray-700 mb-3">Nhận xét từ sinh viên</h3>
        <div className="space-y-3">
          <div className="p-3 bg-purple-50 rounded-lg">
            <p className="text-sm text-gray-700">"Thầy giảng rất rõ ràng và dễ hiểu. Có nhiều ví dụ thực tế."</p>
            <p className="text-xs text-gray-400 mt-1">14DHTH04 • ẩn danh</p>
          </div>
          <div className="p-3 bg-purple-50 rounded-lg">
            <p className="text-sm text-gray-700">"Bài giảng được chuẩn bị kỹ lưỡng. Thầy nhiệt tình hỗ trợ sinh viên."</p>
            <p className="text-xs text-gray-400 mt-1">16DHTH10 • ẩn danh</p>
          </div>
          <div className="p-3 bg-yellow-50 rounded-lg">
            <p className="text-sm text-gray-700">"Mong thầy cho thêm bài tập thực hành để củng cố kiến thức."</p>
            <p className="text-xs text-gray-400 mt-1">14DHTH03 • ẩn danh</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Survey;