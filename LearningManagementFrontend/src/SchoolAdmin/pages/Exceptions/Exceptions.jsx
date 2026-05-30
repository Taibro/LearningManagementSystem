import React, { useState, useEffect } from 'react';

export default function Exceptions() {
  const [exceptions, setExceptions] = useState([]);
  const [schedules, setSchedules] = useState([]);
  const [toast, setToast] = useState(null);

  // Form state
  const [eModal, setEModal] = useState(false);
  const [currentEx, setCurrentEx] = useState({ 
    id: null, scheduleId: '', exceptionDate: '', reason: '', exceptionType: 'CANCELLED', 
    replacementDate: '', replacementRoomId: '', approvalStatus: 'PENDING' 
  });

  useEffect(() => {
    fetchExceptions();
    fetchSchedules(); // Để load vào danh sách chọn Ca học
  }, []);

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3000);
  };

  const fetchExceptions = async () => {
    try {
      const res = await fetch(`http://localhost:8080/api/auth/school-admin/schedule-exceptions`);
      if (res.ok) {
        const data = await res.json();
        setExceptions(data);
      }
    } catch (error) {
      showToast('Lỗi tải ngoại lệ!', 'error');
    }
  };

  const fetchSchedules = async () => {
    try {
      // Tạm load tất cả schedule của lớp ID=1 (Giả định)
      const res = await fetch(`http://localhost:8080/api/auth/school-admin/schedules/class/1`);
      if (res.ok) {
        const data = await res.json();
        setSchedules(data);
      }
    } catch (error) {
      console.error(error);
    }
  };

  const handleSaveEx = async () => {
    const payload = { ...currentEx };
    // Loại bỏ các trường rỗng để tránh lỗi SQL
    if (!payload.replacementDate) payload.replacementDate = null;
    if (!payload.replacementRoomId) payload.replacementRoomId = null;

    const method = currentEx.id ? 'PUT' : 'POST';
    const url = currentEx.id 
      ? `http://localhost:8080/api/auth/school-admin/schedule-exceptions/${currentEx.id}`
      : 'http://localhost:8080/api/auth/school-admin/schedule-exceptions';

    try {
      const res = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      if (res.ok) {
        showToast(currentEx.id ? 'Cập nhật ngoại lệ thành công!' : 'Thêm ngoại lệ thành công!');
        setEModal(false);
        fetchExceptions();
      } else {
        showToast('Lỗi khi lưu!', 'error');
      }
    } catch (err) {
      showToast('Lỗi kết nối mạng!', 'error');
    }
  };

  const handleDeleteEx = async (id) => {
    if(!window.confirm("Bạn có chắc muốn xóa ngoại lệ này?")) return;
    try {
      const res = await fetch(`http://localhost:8080/api/auth/school-admin/schedule-exceptions/${id}`, { method: 'DELETE' });
      if (res.ok) {
        showToast('Đã xóa ngoại lệ!');
        fetchExceptions();
      }
    } catch (err) {
      showToast('Lỗi khi xóa!', 'error');
    }
  };

  const openExModal = (ex = null) => {
    setCurrentEx(ex ? { ...ex } : { 
      id: null, scheduleId: schedules[0]?.id || '', exceptionDate: '', reason: '', 
      exceptionType: 'CANCELLED', replacementDate: '', replacementRoomId: '', approvalStatus: 'PENDING' 
    });
    setEModal(true);
  };

  // Hàm helper để render Badge loại ngoại lệ y như thiết kế gốc
  const renderBadge = (type) => {
    if (type === 'CANCELLED') return <span className="badge b-gray">CANCELLED</span>;
    if (type === 'RESCHEDULED') return <span className="badge b-amber">RESCHEDULED</span>;
    if (type === 'ROOM_CHANGE') return <span className="badge b-blue">ROOM_CHANGE</span>;
    if (type === 'SUBSTITUTED') return <span className="badge b-purple">SUBSTITUTED</span>;
    return <span className="badge b-gray">{type}</span>;
  };

  return (
    <div className="page" style={{ position: 'relative' }}>
      
      {/* TOAST NOTIFICATION */}
      {toast && (
        <div style={{
          position: 'fixed', top: '20px', right: '20px', zIndex: 9999,
          padding: '12px 20px', borderRadius: '4px', color: '#fff',
          boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
          background: toast.type === 'success' ? '#4caf50' : '#f44336'
        }}>
          {toast.msg}
        </div>
      )}

      <div className="ph">
        <div>
          <div className="ph-title">Ngoại lệ lịch học</div>
          <div className="ph-sub">Nghỉ lễ · Dời lịch · Đổi phòng</div>
        </div>
        <button className="btn btn-blue" onClick={() => openExModal()}>+ Thêm ngoại lệ</button>
      </div>

      <div className="card">
        <table className="tbl">
          <thead>
            <tr>
              <th>#</th>
              <th>Ca học</th>
              <th>Ngày NL</th>
              <th>Lý do</th>
              <th>Loại</th>
              <th>Ngày thay thế</th>
              <th>Phòng thay thế</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {exceptions.map((ex, index) => (
              <tr key={ex.id}>
                <td style={{color:'var(--muted)'}}>{index + 1}</td>
                <td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)'}}>
                  Sch#{ex.scheduleId} · {ex.scheduleDetails}
                </td>
                <td style={{fontWeight:700}}>{ex.exceptionDate}</td>
                <td>{ex.reason}</td>
                <td>{renderBadge(ex.exceptionType)}</td>
                <td>{ex.replacementDate || '—'}</td>
                <td>{ex.replacementRoomNumber || '—'}</td>
                <td>
                  <div style={{display:'flex', gap:'4px'}}>
                    <button className="btn btn-ghost btn-xs" onClick={() => openExModal(ex)}>Sửa</button>
                    <button className="btn btn-danger btn-xs" onClick={() => handleDeleteEx(ex.id)}>Xóa</button>
                  </div>
                </td>
              </tr>
            ))}
            {exceptions.length === 0 && <tr><td colSpan="8" style={{textAlign:'center'}}>Chưa có ngoại lệ nào</td></tr>}
          </tbody>
        </table>
      </div>

      {eModal && (
        <div className="ov open">
          <div className="modal" style={{width:'500px'}}>
            <div className="modal-hd">
              <span className="modal-title">{currentEx.id ? '⚠️ Sửa Ngoại lệ' : '⚠️ Thêm Ngoại lệ Lịch học'}</span>
              <button className="close-btn" onClick={() => setEModal(false)}>×</button>
            </div>
            <div className="modal-body">
              <div className="fg">
                <label className="fl">Ca học</label>
                <select className="fc" value={currentEx.scheduleId} onChange={e => setCurrentEx({...currentEx, scheduleId: e.target.value})}>
                  <option value="">-- Chọn lịch học --</option>
                  {schedules.map(sc => (
                    <option key={sc.id} value={sc.id}>Sch#{sc.id} – {sc.classCode} (Thứ {sc.dayOfWeek} · {sc.startTime})</option>
                  ))}
                </select>
              </div>
              <div className="fg">
                <label className="fl">Ngày ngoại lệ</label>
                <input type="date" className="fc" value={currentEx.exceptionDate} onChange={e => setCurrentEx({...currentEx, exceptionDate: e.target.value})} />
              </div>
              <div className="fg">
                <label className="fl">Lý do</label>
                <input className="fc" value={currentEx.reason} onChange={e => setCurrentEx({...currentEx, reason: e.target.value})} placeholder="Nghỉ Quốc khánh, GV ốm, Sự kiện..." />
              </div>
              <div className="fg">
                <label className="fl">Loại ngoại lệ</label>
                <select className="fc" value={currentEx.exceptionType} onChange={e => setCurrentEx({...currentEx, exceptionType: e.target.value})}>
                  <option value="CANCELLED">cancelled – Hủy buổi học</option>
                  <option value="RESCHEDULED">rescheduled – Dời sang ngày khác</option>
                  <option value="ROOM_CHANGE">room_change – Đổi phòng học</option>
                  <option value="SUBSTITUTED">substituted – Giáo viên dạy thay</option>
                </select>
              </div>
              <div className="grid2">
                <div className="fg">
                  <label className="fl">Ngày dạy bù (nếu có)</label>
                  <input type="date" className="fc" value={currentEx.replacementDate || ''} onChange={e => setCurrentEx({...currentEx, replacementDate: e.target.value})} />
                </div>
                <div className="fg">
                  <label className="fl">Phòng ID thay thế (tạm thời)</label>
                  <input type="number" className="fc" value={currentEx.replacementRoomId || ''} onChange={e => setCurrentEx({...currentEx, replacementRoomId: e.target.value})} placeholder="Nhập ID phòng..." />
                </div>
              </div>
            </div>
            <div className="modal-ft">
              <button className="btn btn-ghost" onClick={() => setEModal(false)}>Hủy</button>
              <button className="btn btn-blue" onClick={handleSaveEx}>💾 Lưu</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
