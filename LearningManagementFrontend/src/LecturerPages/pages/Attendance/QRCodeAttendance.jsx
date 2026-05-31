import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { CheckCircle2, AlertTriangle } from 'lucide-react';

const QRCodeAttendance = () => {
  const [isGenerated, setIsGenerated] = useState(false);
  const [timeLeft, setTimeLeft] = useState(0);
  const [isExpired, setIsExpired] = useState(false);
  const [qrToken, setQrToken] = useState('');
  const [loading, setLoading] = useState(false);
  const [duration, setDuration] = useState(15);
  const [toast, setToast] = useState({ show: false, msg: '', type: '' });

  const showToast = (msg, type = 'success') => {
    setToast({ show: true, msg, type });
    setTimeout(() => setToast({ show: false, msg: '', type: '' }), 3000);
  };

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

  const handleGenerateQR = async () => {
    setLoading(true);
    setIsGenerated(false);
    setIsExpired(false);
    
    try {
      const token = localStorage.getItem('lecturerToken');
      const payload = {
        classId: 1, // Tạm fix cứng mã lớp vì chưa có api danh sách lớp
        validDurationMinutes: parseInt(duration)
      };

      const res = await axios.post('http://localhost:8080/api/lecturer/attendance/qr/generate', payload, {
        headers: { Authorization: `Bearer ${token}` }
      });
      
      setQrToken(res.data.qrToken);
      
      // Calculate remaining seconds based on server expiration time
      const remainingSeconds = Math.max(0, Math.floor((res.data.expiresAtMillis - Date.now()) / 1000));
      setTimeLeft(remainingSeconds);
      setIsGenerated(true);
      showToast('Đã tạo mã QR điểm danh!');
    } catch (err) {
      console.error(err);
      showToast('Có lỗi xảy ra khi tạo mã QR', 'error');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="animate-fadeIn relative">
      {toast.show && (
        <div style={{
          position: 'fixed', top: 24, right: 24, zIndex: 10000,
          background: toast.type === 'success' ? '#10b981' : '#ef4444',
          color: 'white', padding: '14px 24px', borderRadius: 8,
          boxShadow: '0 10px 25px rgba(0,0,0,0.2)', fontWeight: 600, fontSize: 14
        }}>
          {toast.type === 'success' ? <><CheckCircle2 className="w-4 h-4 inline-block mr-2" /> </> : <><AlertTriangle className="w-4 h-4 inline-block mr-2" /> </>}{toast.msg}
        </div>
      )}

      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Điểm danh QR Code</h1>
        <p className="text-gray-400 text-sm mt-1">Sinh viên quét mã QR để tự động có mặt</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="card p-6 shadow-sm border border-gray-100 h-fit">
          <h3 className="font-bold text-gray-700 mb-5 uppercase text-[11px] tracking-widest border-b pb-2">Cấu hình mã QR</h3>
          <div className="space-y-5">
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-2 ml-1">Lớp học phần</label>
              <select className="input-field text-sm bg-gray-50">
                <option>010110195604 - 14DHTH04 (Giả lập)</option>
              </select>
            </div>
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-2 ml-1">Thời gian hiệu lực (phút)</label>
              <input 
                type="number" 
                className="input-field text-sm font-bold text-[#6B4FA0]" 
                value={duration}
                onChange={(e) => setDuration(e.target.value)}
                min="1"
                max="120"
              />
            </div>
            <button 
              className="btn-primary w-full font-bold py-3 mt-4 flex items-center justify-center gap-2 shadow-lg shadow-purple-200" 
              onClick={handleGenerateQR}
              disabled={loading}
            >
              {loading ? '⏳ Đang sinh mã...' : '🔲 TẠO MÃ QR NGAY'}
            </button>
          </div>
        </div>

        <div className="card p-6 flex flex-col items-center justify-center min-h-[420px] shadow-sm border border-gray-100">
          <div className="relative mb-6 flex justify-center">
            {/* Lớp nền mờ khi tạo mã */}
            <div className={`w-56 h-56 border-[3px] border-dashed rounded-3xl flex items-center justify-center transition-all duration-500 ${isGenerated && !isExpired ? 'border-[#4CAF50] bg-green-50' : isExpired ? 'border-[#E85D75] bg-red-50' : 'border-[#6B4FA0] bg-[#F9F7FF]'}`}>
              
              {!isGenerated ? (
                <div className="text-center text-gray-400 text-xs font-medium px-6">
                  <div className="text-4xl mb-2">📲</div>
                  Vui lòng bấm nút <b>Tạo mã QR</b> bên trái để bắt đầu điểm danh
                </div>
              ) : isExpired ? (
                <div className="text-center text-[#E85D75] font-black text-xl">
                  🚫 ĐÃ HẾT HẠN
                </div>
              ) : (
                <img 
                  src={`https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${encodeURIComponent(qrToken)}`} 
                  alt="QR Code Điểm danh" 
                  className="w-48 h-48 rounded-xl shadow-md mix-blend-multiply"
                />
              )}
            </div>
          </div>

          {isGenerated && (
            <div className="text-center w-full px-8">
              <div className={`text-5xl font-black tracking-widest ${isExpired ? 'text-red-500' : 'text-[#6B4FA0]'}`}>
                {isExpired ? '00:00' : formatTime(timeLeft)}
              </div>
              <div className="w-full bg-gray-100 h-3 rounded-full mt-5 overflow-hidden border border-gray-200">
                <div 
                  className="h-full transition-all duration-1000 ease-linear rounded-full" 
                  style={{ 
                    width: `${isExpired ? 0 : (timeLeft / (duration * 60)) * 100}%`, 
                    background: isExpired ? '#E85D75' : 'linear-gradient(90deg, #6B4FA0, #8B6BBF)' 
                  }}
                ></div>
              </div>
              <p className="text-xs text-gray-400 mt-3 font-medium uppercase tracking-widest">
                {isExpired ? 'Phiên điểm danh đã đóng' : 'Thời gian quét mã còn lại'}
              </p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default QRCodeAttendance;