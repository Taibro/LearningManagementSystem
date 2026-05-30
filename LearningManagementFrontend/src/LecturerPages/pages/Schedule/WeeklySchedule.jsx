import React, { useState, useEffect } from 'react';
import Input from '../../components/Layout/Input';
import axios from 'axios';

const WeeklySchedule = () => {
  const [selectedDate, setSelectedDate] = useState('2026-04-20');
  const [schedules, setSchedules] = useState([]);
  const [loading, setLoading] = useState(false);

  // Fetch dữ liệu từ API của Tài
  useEffect(() => {
    const fetchSchedule = async () => {
      setLoading(true);
      try {
        const token = localStorage.getItem('lecturerToken');
        // Gọi API của Backend, tự động hiểu GV001 thông qua Token
        const response = await axios.get(`http://localhost:8080/api/lecturer/schedules/weekly-schedule?date=${selectedDate}`, {
          headers: { Authorization: `Bearer ${token}` }
        });
        setSchedules(response.data);
      } catch (error) {
        console.error("Lỗi khi tải lịch học:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchSchedule();
  }, [selectedDate]);

  const handleDateChange = (e) => {
    setSelectedDate(e.target.value);
  };

  // Hàm nhóm lịch theo Buổi (Sáng/Chiều/Tối) và Thứ (2 -> CN)
  const getSchedulesForSlot = (timeSlot, dayOfWeek) => {
    return schedules.filter(sch => {
      // timeSlot: 'SANG' (Tiết 1-6), 'CHIEU' (Tiết 7-12), 'TOI' (Tiết 13-16)
      const isMorning = sch.startPeriod <= 6;
      const isAfternoon = sch.startPeriod >= 7 && sch.startPeriod <= 12;
      const isEvening = sch.startPeriod >= 13;

      const matchSlot = 
        (timeSlot === 'SANG' && isMorning) ||
        (timeSlot === 'CHIEU' && isAfternoon) ||
        (timeSlot === 'TOI' && isEvening);
      
      // dayOfWeek trong Java thường 1=Thứ 2, 2=Thứ 3... 7=Chủ nhật
      return matchSlot && sch.dayOfWeek === dayOfWeek;
    });
  };

  const renderScheduleCard = (sch, idx) => {
    // Phân loại màu sắc dựa theo SessionType (LT/TH)
    const isTheory = sch.sessionType === 'Lý thuyết' || sch.sessionType === 'LT';
    const cardClass = isTheory ? 'schedule-theory' : 'schedule-practice';
    const textColor = isTheory ? 'text-green-800' : 'text-indigo-800';
    const subColor = isTheory ? 'text-green-600' : 'text-indigo-600';
    const iconColor = isTheory ? 'text-green-700' : 'text-indigo-700';

    return (
      <div key={idx} className={`schedule-card ${cardClass} mb-2`}>
        <div className={`font-semibold ${textColor} text-xs`}>{sch.courseName}</div>
        <div className={`${subColor} text-xs mt-1`}>{sch.classCode}</div>
        <div className={`${subColor} text-xs`}>Tiết {sch.startPeriod}–{sch.endPeriod}</div>
        <div className={`${iconColor} text-xs font-medium mt-1`}>📍 {sch.roomName}</div>
      </div>
    );
  };

  return (
    <div className="animate-fadeIn">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Lịch theo tuần</h1>
          <p className="text-gray-400 text-sm mt-1">Ngày đang chọn: {selectedDate}</p>
        </div>
        
        <div className="flex items-center gap-4">
          <Input 
            type="date" 
            value={selectedDate} 
            onChange={handleDateChange}
            className="w-40" 
          />
          <div className="flex gap-2">
            <button className="btn-primary text-sm">Tải lại lịch</button>
          </div>
        </div>
      </div>

      <div className="flex gap-4 mb-4 text-sm">
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-green-400"></div><span className="text-gray-600">Lý thuyết</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-indigo-400"></div><span className="text-gray-600">Thực hành</span></div>
      </div>

      <div className="card overflow-hidden">
        {loading ? (
          <div className="p-10 text-center text-gray-500">Đang tải dữ liệu lịch học từ máy chủ...</div>
        ) : (
          <div className="week-grid">
            {/* Header */}
            <div className="week-header text-xs">Ca học</div>
            <div className="week-header">Thứ 2</div>
            <div className="week-header">Thứ 3</div>
            <div className="week-header">Thứ 4</div>
            <div className="week-header">Thứ 5</div>
            <div className="week-header">Thứ 6</div>
            <div className="week-header">Thứ 7</div>
            <div className="week-header">CN</div>

            {/* Buổi Sáng */}
            <div className="week-cell session-label text-xs font-semibold text-purple-600">SÁNG</div>
            {[1, 2, 3, 4, 5, 6, 7].map(day => (
              <div key={`sang-${day}`} className="week-cell">
                {getSchedulesForSlot('SANG', day).map((sch, i) => renderScheduleCard(sch, i))}
              </div>
            ))}

            {/* Buổi Chiều */}
            <div className="week-cell session-label text-xs font-semibold text-purple-600">CHIỀU</div>
            {[1, 2, 3, 4, 5, 6, 7].map(day => (
              <div key={`chieu-${day}`} className="week-cell">
                {getSchedulesForSlot('CHIEU', day).map((sch, i) => renderScheduleCard(sch, i))}
              </div>
            ))}

            {/* Buổi Tối */}
            <div className="week-cell session-label text-xs font-semibold text-purple-600">TỐI</div>
            {[1, 2, 3, 4, 5, 6, 7].map(day => (
              <div key={`toi-${day}`} className="week-cell">
                {getSchedulesForSlot('TOI', day).map((sch, i) => renderScheduleCard(sch, i))}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default WeeklySchedule;