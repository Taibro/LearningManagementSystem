import React from 'react';

const WeeklySchedule = () => {
  return (
    <div className="animate-fadeIn">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Lịch theo tuần</h1>
          <p className="text-gray-400 text-sm mt-1">Tuần 20/04/2026 – 26/04/2026</p>
        </div>
        <div className="flex gap-2">
          <button className="btn-outline text-sm flex items-center gap-1">Tuần trước</button>
          <button className="btn-primary text-sm">Hôm nay</button>
          <button className="btn-outline text-sm flex items-center gap-1">Tuần sau</button>
        </div>
      </div>

      {/* Legend */}
      <div className="flex gap-4 mb-4 text-sm">
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-green-400"></div><span className="text-gray-600">Lịch dạy lý thuyết</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-indigo-400"></div><span className="text-gray-600">Lịch dạy thực hành</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-yellow-400"></div><span className="text-gray-600">Lịch trực tuyến</span></div>
        <div className="flex items-center gap-2"><div className="w-3 h-3 rounded bg-red-400"></div><span className="text-gray-600">Lịch tạm ngừng</span></div>
      </div>

      <div className="card overflow-hidden">
        <div className="week-grid">
          {/* Header */}
          <div className="week-header text-xs">Ca học</div>
          <div className="week-header"><div>Thứ 2</div><div className="text-purple-200 font-normal text-xs">20/04/2026</div></div>
          <div className="week-header"><div>Thứ 3</div><div className="text-purple-200 font-normal text-xs">21/04/2026</div></div>
          <div className="week-header"><div>Thứ 4</div><div className="text-purple-200 font-normal text-xs">22/04/2026</div></div>
          <div className="week-header"><div>Thứ 5</div><div className="text-purple-200 font-normal text-xs">23/04/2026</div></div>
          <div className="week-header"><div>Thứ 6</div><div className="text-purple-200 font-normal text-xs">24/04/2026</div></div>
          <div className="week-header"><div>Thứ 7</div><div className="text-purple-200 font-normal text-xs">25/04/2026</div></div>
          <div className="week-header"><div>CN</div><div className="text-purple-200 font-normal text-xs">26/04/2026</div></div>

          {/* Sáng */}
          <div className="week-cell session-label text-xs font-semibold text-purple-600">SÁNG</div>
          <div className="week-cell">
            <div className="schedule-card schedule-theory">
              <div className="font-semibold text-green-800 text-xs">Kiến trúc máy tính (LT)</div>
              <div className="text-green-600 text-xs mt-1">010100228915 - 16DHTH10</div>
              <div className="text-green-600 text-xs">Tiết 1–3</div>
              <div className="text-green-700 text-xs font-medium mt-1">📍 A401 - 140 Lê Trọng Tấn</div>
            </div>
          </div>
          <div className="week-cell">
            <div className="schedule-card schedule-theory">
              <div className="font-semibold text-green-800 text-xs">Kiến trúc máy tính (LT)</div>
              <div className="text-green-600 text-xs mt-1">010100228913 - 16DHTH08</div>
              <div className="text-green-600 text-xs">Tiết 7–9</div>
              <div className="text-green-700 text-xs font-medium mt-1">📍 B407 - 140 Lê Trọng Tấn</div>
            </div>
          </div>
          <div className="week-cell"></div>
          <div className="week-cell">
            <div className="schedule-card schedule-theory mb-2">
              <div className="font-semibold text-green-800 text-xs">Quản trị hệ thống mạng (LT)</div>
              <div className="text-green-600 text-xs mt-1">010110197304 - 14DHTH04</div>
              <div className="text-green-600 text-xs">Tiết 7–9</div>
              <div className="text-green-700 text-xs font-medium mt-1">📍 A202 - 140 Lê Trọng Tấn</div>
            </div>
            <div className="schedule-card schedule-theory">
              <div className="font-semibold text-green-800 text-xs">Quản trị hệ thống mạng (LT)</div>
              <div className="text-green-600 text-xs mt-1">010110197303 - 14DHTH03</div>
              <div className="text-green-600 text-xs">Tiết 10–12</div>
              <div className="text-green-700 text-xs font-medium mt-1">📍 A301 - 140 Lê Trọng Tấn</div>
            </div>
          </div>
          <div className="week-cell"></div>
          <div className="week-cell">
            <div className="schedule-card schedule-online">
              <div className="font-semibold text-yellow-800 text-xs">Các vấn đề biên đại trong ATTT (LT)</div>
              <div className="text-yellow-600 text-xs mt-1">932210293002 - 09CUICMITUE02</div>
              <div className="text-yellow-600 text-xs">Tiết 2–6</div>
              <div className="text-yellow-700 text-xs font-medium mt-1">📍 DP01 - Công ty Đại phát</div>
            </div>
          </div>
          <div className="week-cell"></div>

          {/* Chiều */}
          <div className="week-cell session-label text-xs font-semibold text-purple-600">CHIỀU</div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>

          {/* Tối */}
          <div className="week-cell session-label text-xs font-semibold text-purple-600">TỐI</div>
          <div className="week-cell">
            <div className="schedule-card schedule-practice">
              <div className="font-semibold text-indigo-800 text-xs">Thực hành QTHTM (TH)</div>
              <div className="text-indigo-600 text-xs mt-1">010110192400 - 14DHTH40</div>
              <div className="text-indigo-600 text-xs">Tiết 13–15</div>
              <div className="text-indigo-700 text-xs font-medium mt-1">📍 A107 - Phòng máy BM</div>
            </div>
          </div>
          <div className="week-cell">
            <div className="schedule-card schedule-practice">
              <div className="font-semibold text-indigo-800 text-xs">Thực hành QTHTM (TH)</div>
              <div className="text-indigo-600 text-xs mt-1">010110192401 - 14DHTH41</div>
              <div className="text-indigo-600 text-xs">Tiết 13–15</div>
              <div className="text-indigo-700 text-xs font-medium mt-1">📍 A107 - Phòng máy BM</div>
            </div>
          </div>
          <div className="week-cell"></div>
          <div className="week-cell">
            <div className="schedule-card schedule-practice">
              <div className="font-semibold text-indigo-800 text-xs">Thực hành QTHTM (TH)</div>
              <div className="text-indigo-600 text-xs mt-1">010110192402 - 14DHTH42</div>
              <div className="text-indigo-600 text-xs">Tiết 13–15</div>
              <div className="text-indigo-700 text-xs font-medium mt-1">📍 A108 - Phòng máy</div>
            </div>
          </div>
          <div className="week-cell">
            <div className="schedule-card schedule-practice">
              <div className="font-semibold text-indigo-800 text-xs">Thực hành QTHTM (TH)</div>
              <div className="text-indigo-600 text-xs mt-1">010110192403 - 14DHTH43</div>
              <div className="text-indigo-600 text-xs">Tiết 13–15</div>
              <div className="text-indigo-700 text-xs font-medium mt-1">📍 A108 - Phòng máy</div>
            </div>
          </div>
          <div className="week-cell"></div>
          <div className="week-cell"></div>
        </div>
      </div>
    </div>
  );
};

export default WeeklySchedule;