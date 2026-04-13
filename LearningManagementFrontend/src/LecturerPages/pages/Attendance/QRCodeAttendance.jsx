import React, { useState, useEffect } from 'react';

const QRCodeAttendance = () => {
  const [isGenerated, setIsGenerated] = useState(false);
  const [timeLeft, setTimeLeft] = useState(15 * 60); // 15 minutes in seconds
  const [isExpired, setIsExpired] = useState(false);

  useEffect(() => {
    let timer;
    if (isGenerated && timeLeft > 0) {
      timer = setInterval(() => {
        setTimeLeft((prev) => prev - 1);
      }, 1000);
    } else if (timeLeft === 0 && isGenerated) {
      setIsExpired(true);
      alert('Mã QR đã hết hiệu lực. Vui lòng tạo lại.');
    }
    return () => clearInterval(timer);
  }, [isGenerated, timeLeft]);

  const handleGenerateQR = () => {
    setIsGenerated(true);
    setTimeLeft(15 * 60);
    setIsExpired(false);
  };

  const formatTime = (seconds) => {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
  };

  const progressWidth = (timeLeft / (15 * 60)) * 100;

  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Điểm danh QR Code</h1>
        <p className="text-gray-400 text-sm mt-1">Sinh viên quét mã QR để điểm danh</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="card p-6">
          <h3 className="font-semibold text-gray-700 mb-4">Tạo mã QR điểm danh</h3>
          <div>
            <label className="block text-sm font-medium text-gray-600 mb-1.5">Lớp học phần</label>
            <select className="input-field mb-3">
              <option>010110195604 - 14DHTH04</option>
              <option>010110195603 - 14DHTH03</option>
            </select>

            <label className="block text-sm font-medium text-gray-600 mb-1.5">Thời gian hiệu lực (phút)</label>
            <input type="number" className="input-field mb-3" defaultValue="15" min="5" max="60" />

            <label className="block text-sm font-medium text-gray-600 mb-1.5">Buổi học</label>
            <select className="input-field mb-4">
              <option>Buổi sáng - 03/02/2026</option>
              <option>Buổi chiều - 03/02/2026</option>
            </select>

            <button className="btn-primary w-full" onClick={handleGenerateQR}>🔲 Tạo mã QR</button>
          </div>
        </div>

        <div className="card p-6 flex flex-col items-center justify-center">
          <div className="qr-box mb-4">
            {!isGenerated ? (
              <div className="text-center text-gray-400">
                <div className="text-5xl mb-2">🔲</div>
                <div className="text-sm">Nhấn "Tạo mã QR" để hiển thị</div>
              </div>
            ) : (
              <svg viewBox="0 0 100 100" width="160" height="160" xmlns="http://www.w3.org/2000/svg">
                <rect x="5" y="5" width="35" height="35" rx="3" fill="none" stroke="#6B4FA0" strokeWidth="4"/>
                <rect x="15" y="15" width="15" height="15" rx="1" fill="#6B4FA0"/>
                <rect x="60" y="5" width="35" height="35" rx="3" fill="none" stroke="#6B4FA0" strokeWidth="4"/>
                <rect x="70" y="15" width="15" height="15" rx="1" fill="#6B4FA0"/>
                <rect x="5" y="60" width="35" height="35" rx="3" fill="none" stroke="#6B4FA0" strokeWidth="4"/>
                <rect x="15" y="70" width="15" height="15" rx="1" fill="#6B4FA0"/>
                <rect x="50" y="50" width="8" height="8" fill="#6B4FA0"/>
                <rect x="62" y="50" width="8" height="8" fill="#6B4FA0"/>
                <rect x="74" y="50" width="8" height="8" fill="#6B4FA0"/>
                <rect x="86" y="50" width="8" height="8" fill="#6B4FA0"/>
                <rect x="50" y="62" width="8" height="8" fill="#6B4FA0"/>
                <rect x="74" y="62" width="8" height="8" fill="#6B4FA0"/>
                <rect x="50" y="74" width="8" height="8" fill="#6B4FA0"/>
                <rect x="62" y="74" width="8" height="8" fill="#6B4FA0"/>
                <rect x="86" y="74" width="8" height="8" fill="#6B4FA0"/>
                <rect x="62" y="86" width="8" height="8" fill="#6B4FA0"/>
                <rect x="86" y="86" width="8" height="8" fill="#6B4FA0"/>
              </svg>
            )}
          </div>

          {isGenerated && (
            <div className="text-center w-full">
              <div className="text-4xl font-bold text-purple-700">
                {isExpired ? 'Hết hạn' : formatTime(timeLeft)}
              </div>
              <div className="text-sm text-gray-500 mt-1">Thời gian còn lại</div>
              <div className="progress-bar w-48 mx-auto mt-3">
                <div
                  className="progress-fill"
                  style={{ width: `${progressWidth}%`, background: isExpired ? '#E85D75' : '' }}
                ></div>
              </div>
              <button className="btn-outline mt-4 text-sm" onClick={handleGenerateQR}>🔄 Làm mới QR</button>
            </div>
          )}
        </div>
      </div>

      <div className="card p-5 mt-5">
        <h3 className="font-semibold text-gray-700 mb-3">Sinh viên đã điểm danh QR hôm nay</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50">
                <th className="px-4 py-2.5 text-left font-semibold text-gray-600">Họ tên</th>
                <th className="px-4 py-2.5 text-left font-semibold text-gray-600">MSSV</th>
                <th className="px-4 py-2.5 text-left font-semibold text-gray-600">Thời gian quét</th>
                <th className="px-4 py-2.5 text-left font-semibold text-gray-600">Trạng thái</th>
              </tr>
            </thead>
            <tbody>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-2.5 font-medium">Kiều Tấn Phát</td>
                <td className="px-4 py-2.5 text-gray-500">14DHTH13001</td>
                <td className="px-4 py-2.5 text-gray-500">07:32:15</td>
                <td className="px-4 py-2.5"><span className="badge-present">✓ Đúng giờ</span></td>
              </tr>
              <tr className="table-row border-b border-gray-50">
                <td className="px-4 py-2.5 font-medium">Âu Gia Quốc</td>
                <td className="px-4 py-2.5 text-gray-500">14DHTH12005</td>
                <td className="px-4 py-2.5 text-gray-500">07:35:42</td>
                <td className="px-4 py-2.5"><span className="badge-present">✓ Đúng giờ</span></td>
              </tr>
              <tr className="table-row">
                <td className="px-4 py-2.5 font-medium">Cao Đức Mạnh</td>
                <td className="px-4 py-2.5 text-gray-500">14DHTH12007</td>
                <td className="px-4 py-2.5 text-gray-500">07:42:01</td>
                <td className="px-4 py-2.5"><span className="badge-absent">! Trễ</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default QRCodeAttendance;