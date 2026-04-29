import React, { useState, useEffect } from 'react';

const QRCodeAttendance = () => {
  const [isGenerated, setIsGenerated] = useState(false);
  const [timeLeft, setTimeLeft] = useState(15 * 60);
  const [isExpired, setIsExpired] = useState(false);

  useEffect(() => {
    let timer;
    if (isGenerated && timeLeft > 0) {
      timer = setInterval(() => setTimeLeft((prev) => prev - 1), 1000);
    } else if (timeLeft === 0 && isGenerated) {
      setIsExpired(true);
    }
    return () => clearInterval(timer);
  }, [isGenerated, timeLeft]);

  const formatTime = (seconds) => {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
  };

  return (
    <div className="animate-fadeIn">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Điểm danh QR Code</h1>
        <p className="text-gray-400 text-sm mt-1">Sinh viên quét mã QR để điểm danh</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="card p-6 shadow-sm border border-gray-100">
          <h3 className="font-bold text-gray-700 mb-5 uppercase text-[11px] tracking-widest">Cấu hình mã QR</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-1.5 ml-1">Lớp học phần</label>
              <select className="input-field text-sm"><option>010110195604 - 14DHTH04</option></select>
            </div>
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-1.5 ml-1">Thời gian hiệu lực (phút)</label>
              <input type="number" className="input-field text-sm" defaultValue="15" />
            </div>
            <button className="btn-primary w-full font-bold py-3 mt-2" onClick={() => {setIsGenerated(true); setTimeLeft(15*60); setIsExpired(false);}}>🔲 Tạo mã QR ngay</button>
          </div>
        </div>

        <div className="card p-6 flex flex-col items-center justify-center min-h-[380px] shadow-sm border border-gray-100">
          <div className="w-48 h-48 border-2 border-dashed border-[#6B4FA0] rounded-2xl flex items-center justify-center bg-[#F9F7FF] mb-5">
            {!isGenerated ? (
              <div className="text-center text-gray-400 text-xs font-medium">Chờ tạo mã...</div>
            ) : (
              <svg viewBox="0 0 100 100" width="150" height="150" fill="#6B4FA0">
                <path d="M5 5h35v35H5zm5 5v25h25V10zm50 0h35v35H60zm5 5v25h25V15zM5 60h35v35H5zm5 5v25h25V65zm50 0h10v10H55zm15 0h10v10H70zm15 0h10v10H85zm-30 15h10v10H55zm15 0h10v10H70zm15 0h10v10H85z" />
              </svg>
            )}
          </div>
          {isGenerated && (
            <div className="text-center">
              <div className={`text-4xl font-black ${isExpired ? 'text-red-500' : 'text-[#6B4FA0]'}`}>{isExpired ? 'HẾT HẠN' : formatTime(timeLeft)}</div>
              <div className="progress-bar w-48 mt-3 mx-auto"><div className="progress-fill" style={{ width: `${(timeLeft/(15*60))*100}%`, background: isExpired ? '#E85D75' : '' }}></div></div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default QRCodeAttendance;