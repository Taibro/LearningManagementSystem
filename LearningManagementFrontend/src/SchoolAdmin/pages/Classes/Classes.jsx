import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';

export default function Classes() {
  const [classes, setClasses] = useState([]);
  const [toast, setToast] = useState(null);

  const [cModal, setCModal] = useState(false);
  const [currentClass, setCurrentClass] = useState({
    id: null, code: '', courseId: '', semesterId: '', maxStudents: 40, status: 'OPEN', notes: ''
  });

  useEffect(() => {
    fetchClasses();
  }, []);

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3000);
  };

  const fetchClasses = async () => {
    try {
      const res = await fetch('http://localhost:8080/api/auth/school-admin/classes', {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('token')}` }
      });
      if (res.ok) {
        const data = await res.json();
        setClasses(data);
      }
    } catch (error) {
      showToast('Lỗi tải danh sách lớp học!', 'error');
    }
  };

  const handleSaveClass = async () => {
    const method = currentClass.id ? 'PUT' : 'POST';
    const url = currentClass.id 
      ? `http://localhost:8080/api/auth/school-admin/classes/${currentClass.id}`
      : `http://localhost:8080/api/auth/school-admin/classes`;

    const payload = {
      code: currentClass.code,
      courseId: parseInt(currentClass.courseId),
      semesterId: parseInt(currentClass.semesterId),
      maxStudents: parseInt(currentClass.maxStudents),
      status: currentClass.status,
      notes: currentClass.notes
    };

    try {
      const res = await fetch(url, {
        method,
        headers: { 
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
        body: JSON.stringify(payload)
      });
      if (res.ok) {
        showToast(currentClass.id ? 'Cập nhật lớp thành công!' : 'Tạo lớp thành công!');
        setCModal(false);
        fetchClasses();
      } else {
        showToast('Lỗi khi lưu lớp học!', 'error');
      }
    } catch (err) {
      showToast('Lỗi kết nối mạng!', 'error');
    }
  };

  const openModal = (c = null) => {
    setCurrentClass(c ? { ...c } : {
      id: null, code: '', courseId: '', semesterId: '', maxStudents: 40, status: 'OPEN', notes: ''
    });
    setCModal(true);
  };

  const renderStatusBadge = (status) => {
    if (status === 'OPEN') return <span className="badge b-green">MỞ ĐĂNG KÝ</span>;
    if (status === 'IN_PROGRESS') return <span className="badge b-blue">ĐANG HỌC</span>;
    if (status === 'COMPLETED') return <span className="badge b-gray">ĐÃ KẾT THÚC</span>;
    if (status === 'CLOSED') return <span className="badge b-amber">ĐÃ ĐÓNG</span>;
    if (status === 'CANCELLED') return <span className="badge b-red">HỦY LỚP</span>;
    return <span className="badge b-gray">{status}</span>;
  };

  return (
    <div className="page" style={{ position: 'relative' }}>

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
          <div className="ph-title">Quản lý Lớp học</div>
          <div className="ph-sub">Tạo lớp · Phân công giảng viên · Quản lý sĩ số</div>
        </div>
        <button className="btn btn-blue" onClick={() => openModal()}>+ Tạo lớp học</button>
      </div>
      
      <div className="card">
        {classes.length === 0 ? (
          <div className="card-body" style={{textAlign:'center', padding:'50px', color:'var(--muted)'}}>
            <div style={{fontSize:'48px', marginBottom:'12px'}}>🎓</div>
            <div style={{fontSize:'16px', fontWeight:700, marginBottom:'8px'}}>Chưa có lớp học nào</div>
            <button className="btn btn-blue" style={{marginTop:'16px'}} onClick={() => openModal()}>+ Tạo lớp đầu tiên</button>
          </div>
        ) : (
          <table className="tbl">
            <thead>
              <tr>
                <th>Mã lớp</th>
                <th>Môn học (ID)</th>
                <th>Học kỳ (ID)</th>
                <th>Giảng viên</th>
                <th>Sĩ số</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {classes.map(c => (
                <tr key={c.id}>
                  <td style={{fontFamily:'monospace', fontSize:'12px', color:'var(--blue)', fontWeight:700}}>{c.code}</td>
                  <td><div style={{fontWeight:600}}>{c.courseName || `Course ID: ${c.courseId}`}</div></td>
                  <td>{c.semesterName || `Semester ID: ${c.semesterId}`}</td>
                  <td>
                    <div style={{display:'flex', flexDirection:'column', gap:'3px'}}>
                      {c.teachers && c.teachers.length > 0 ? c.teachers.map((t, idx) => (
                        <span key={idx} className={t.includes('main') ? "badge b-blue" : "badge b-cyan"}>{t}</span>
                      )) : <span className="badge b-gray">Chưa phân công</span>}
                    </div>
                  </td>
                  <td>
                    <span style={{fontWeight:700, color: c.enrolledStudents >= c.maxStudents ? 'var(--red)' : 'var(--blue)'}}>
                      {c.enrolledStudents || 0}
                    </span>
                    <span style={{color:'var(--muted)'}}>/{c.maxStudents}</span>
                  </td>
                  <td>{renderStatusBadge(c.status)}</td>
                  <td>
                    <div style={{display:'flex', gap:'4px'}}>
                      <button className="btn btn-ghost btn-xs" onClick={() => openModal(c)}>Sửa</button>
                      <Link to="/attendance" className="btn btn-ghost btn-xs" style={{textDecoration:'none'}}>Điểm danh</Link>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {cModal && (
        <div className="ov open">
          <div className="modal">
            <div className="modal-hd">
              <span className="modal-title">{currentClass.id ? '🎓 Sửa Lớp học' : '🎓 Tạo Lớp học'}</span>
              <button className="close-btn" onClick={() => setCModal(false)}>×</button>
            </div>
            <div className="modal-body">
              <div className="fg">
                <label className="fl">Mã lớp</label>
                <input className="fc" value={currentClass.code} onChange={e => setCurrentClass({...currentClass, code: e.target.value})} placeholder="INT101-01-HK1-2425" />
              </div>
              <div className="grid2">
                <div className="fg">
                  <label className="fl">ID Môn học</label>
                  <input type="number" className="fc" value={currentClass.courseId} onChange={e => setCurrentClass({...currentClass, courseId: e.target.value})} placeholder="ID Môn" />
                </div>
                <div className="fg">
                  <label className="fl">ID Học kỳ</label>
                  <input type="number" className="fc" value={currentClass.semesterId} onChange={e => setCurrentClass({...currentClass, semesterId: e.target.value})} placeholder="ID Học kỳ" />
                </div>
              </div>
              <div className="grid2">
                <div className="fg">
                  <label className="fl">Sĩ số tối đa</label>
                  <input type="number" className="fc" value={currentClass.maxStudents} onChange={e => setCurrentClass({...currentClass, maxStudents: e.target.value})} min="1" />
                </div>
                <div className="fg">
                  <label className="fl">Trạng thái</label>
                  <select className="fc" value={currentClass.status} onChange={e => setCurrentClass({...currentClass, status: e.target.value})}>
                    <option value="OPEN">Mở đăng ký</option>
                    <option value="IN_PROGRESS">Đang học</option>
                    <option value="COMPLETED">Đã kết thúc</option>
                    <option value="CLOSED">Đã đóng</option>
                    <option value="CANCELLED">Hủy lớp</option>
                  </select>
                </div>
              </div>
              <div className="fg">
                <label className="fl">Ghi chú</label>
                <textarea className="fc" rows="2" value={currentClass.notes} onChange={e => setCurrentClass({...currentClass, notes: e.target.value})} placeholder="Ghi chú về lớp học..."></textarea>
              </div>
            </div>
            <div className="modal-ft">
              <button className="btn btn-ghost" onClick={() => setCModal(false)}>Hủy</button>
              <button className="btn btn-blue" onClick={handleSaveClass}>💾 Lưu lớp học</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
