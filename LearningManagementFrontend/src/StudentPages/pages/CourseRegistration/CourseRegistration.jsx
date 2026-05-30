import React, { useState } from 'react';
import './CourseRegistration.css';
import { FileText, User, Plus, Trash2, CheckCircle2, X, School, Search, Info, Eye, Library, Sparkles } from 'lucide-react';

// --- MOCK DATA ---
const MOCK_STUDENT = {
  name: 'Phan Sĩ Thịnh',
  gender: 'Nam',
  id: '2001230933',
  status: 'Đang học',
  course: '2023',
  level: 'Đại học',
  major: 'Công nghệ thông tin',
  faculty: 'Khoa Công nghệ Thông tin',
  class: '14DHTH05',
  type: 'Chính quy',
  spec: 'Công nghệ phần mềm',
  campus: 'ĐHCT TP.HCM'
};

const MOCK_SUBJECTS = [
  { id: '0101007881', oldId: '01202067', name: 'Công nghệ .NET', credits: 3, required: true },
  { id: '0101101981', oldId: '01201073', name: 'Dữ liệu NoSQL', credits: 2, required: true },
  { id: '0101001706', oldId: '16201001', name: 'Giáo dục thể chất 1 (Bơi lội)', credits: 2, required: false },
  { id: '0101001702', oldId: '16201002', name: 'Giáo dục thể chất 3 (Bóng đá)', credits: 2, required: false },
  { id: '0101101975', oldId: '01011019', name: 'Internet of Things', credits: 3, required: true },
];

const MOCK_CLASSES = [
  { id: '010100170201', subjectId: '0101001702', name: 'Giáo dục thể chất 3 (Bóng đá)', expected: 'bongda', max: 55, registered: 55, status: 'Chỉ đăng ký' },
  { id: '010100170202', subjectId: '0101001702', name: 'Giáo dục thể chất 3 (Bóng đá)', expected: 'bongda', max: 55, registered: 20, status: 'Chỉ đăng ký' },
  { id: '010110197501', subjectId: '0101101975', name: 'Internet of Things', expected: '14DHTH', max: 80, registered: 45, status: 'Chỉ đăng ký' }
];

const MOCK_SCHEDULES = {
  '010100170202': [
    { day: 'Thứ 3 (T1 -> T2)', room: 'Sân bóng đá', building: 'T', campus: 'ĐHCT TP.HCM', lecturer: 'ThS Phạm Văn Kiên', time: '07/07/26 - 04/08/26' },
    { day: 'Thứ 5 (T1 -> T2)', room: 'Sân bóng đá', building: 'T', campus: 'ĐHCT TP.HCM', lecturer: 'ThS Phạm Văn Kiên', time: '09/07/26 - 06/08/26' }
  ],
  '010110197501': [
    { day: 'Thứ 2 (T1 -> T3)', room: 'A307', building: 'A', campus: 'ĐHCT TP.HCM', lecturer: 'ThS Đinh Huy Hoàng', time: '06/07/26 - 03/08/26' }
  ]
};

export default function CourseRegistration() {
  const [activeTab, setActiveTab] = useState('registration'); // 'info' | 'registration'
  const [toastMsg, setToastMsg] = useState('');

  // Form State
  const [regType, setRegType] = useState('new');
  const [hideConflict, setHideConflict] = useState(false);

  // Selection
  const [selectedSubject, setSelectedSubject] = useState(null);
  const [selectedClass, setSelectedClass] = useState(null);
  const [registeredClasses, setRegisteredClasses] = useState([]);

  // Modals
  const [modalType, setModalType] = useState(null);
  const [actionClass, setActionClass] = useState(null);
  const [dropdownOpen, setDropdownOpen] = useState(null);

  const showToast = (msg) => {
    setToastMsg(msg);
    setTimeout(() => setToastMsg(''), 3000);
  };

  const handleRegister = () => {
    if (!selectedClass) return;
    if (registeredClasses.some(c => c.id === selectedClass.id)) {
      alert("Bạn đã đăng ký lớp này rồi!");
      return;
    }
    const subject = MOCK_SUBJECTS.find(s => s.id === selectedClass.subjectId);
    setRegisteredClasses([...registeredClasses, { ...selectedClass, subjectName: subject.name, credits: subject.credits }]);
    showToast("Đăng ký học phần thành công!");
    setSelectedClass(null);
  };

  const handleCancelRegistration = () => {
    setRegisteredClasses(registeredClasses.filter(c => c.id !== actionClass.id));
    setModalType(null);
    setActionClass(null);
    showToast("Đã hủy đăng ký học phần!");
  };

  return (
    <div className="modern-portal">
      {/* Header Banner */}
      <header className="modern-header">
        <img src="https://via.placeholder.com/800x80?text=CỔNG+ĐĂNG+KÝ+HỌC+PHẦN+SINH+VIÊN&bg=f8fafc&textColor=1d4ed8" alt="Banner" style={{borderRadius: '8px', objectFit: 'cover'}} />
      </header>

      <div className="modern-container">
        <div className="modern-layout">
          
          {/* SIDEBAR LEFT */}
          <aside className="modern-sidebar">
            <div className="profile-card">
              <div className="profile-header">
                <h3>Thẻ Sinh Viên</h3>
              </div>
              <div className="profile-body">
                <img src="https://ui-avatars.com/api/?name=Sĩ+Thịnh&background=0D8ABC&color=fff&size=128" alt="Avatar" className="profile-avatar" />
                <div style={{textAlign: 'center'}}>
                  <h4 style={{margin: '0 0 4px 0', fontSize: '18px', color: 'var(--text-main)'}}>{MOCK_STUDENT.name}</h4>
                  <span className="badge blue">{MOCK_STUDENT.id}</span>
                </div>
                <div className="profile-info">
                  <div className="info-row"><span className="info-label">Giới tính</span><span className="info-value">{MOCK_STUDENT.gender}</span></div>
                  <div className="info-row"><span className="info-label">Trạng thái</span><span className="badge green" style={{fontSize: '11px'}}>{MOCK_STUDENT.status}</span></div>
                </div>
              </div>
            </div>

            <div className="modern-menu">
              <div className={`menu-item ${activeTab === 'info' ? 'active' : ''}`} onClick={() => setActiveTab('info')}>
                <span><User className="w-4 h-4 inline-block mr-2" /></span> Thông tin sinh viên
              </div>
              <div className={`menu-item ${activeTab === 'registration' ? 'active' : ''}`} onClick={() => setActiveTab('registration')}>
                <span><FileText className="w-4 h-4 inline-block mr-2" /></span> Đăng ký học phần
              </div>
            </div>
          </aside>

          {/* MAIN CONTENT RIGHT */}
          <main className="modern-content">
            {activeTab === 'info' && (
              <div>
                <h2 className="page-title">Thông tin sinh viên</h2>
                <div className="info-grid">
                  <div>
                    <p><span>Khóa</span><b>{MOCK_STUDENT.course}</b></p>
                    <p style={{marginTop:'16px'}}><span>Bậc đào tạo</span><b>{MOCK_STUDENT.level}</b></p>
                    <p style={{marginTop:'16px'}}><span>Ngành</span><b>{MOCK_STUDENT.major}</b></p>
                    <p style={{marginTop:'16px'}}><span>Khoa</span><b>{MOCK_STUDENT.faculty}</b></p>
                  </div>
                  <div>
                    <p><span>Lớp</span><b>{MOCK_STUDENT.class}</b></p>
                    <p style={{marginTop:'16px'}}><span>Loại hình đào tạo</span><b>{MOCK_STUDENT.type}</b></p>
                    <p style={{marginTop:'16px'}}><span>Chuyên ngành</span><b>{MOCK_STUDENT.spec}</b></p>
                    <p style={{marginTop:'16px'}}><span>Cơ sở</span><b>{MOCK_STUDENT.campus}</b></p>
                  </div>
                </div>
              </div>
            )}

            {activeTab === 'registration' && (
              <div>
                <h2 className="page-title">Đăng ký học phần</h2>
                
                <div className="filter-bar">
                  <div>
                    <span style={{fontSize:'13px', color:'var(--text-muted)', display:'block', marginBottom:'4px'}}>Đợt đăng ký</span>
                    <select className="modern-select">
                      <option>HK3 (2025 - 2026)</option>
                    </select>
                  </div>
                  <div style={{width:'1px', height:'30px', background:'var(--border-color)', margin:'0 8px'}}></div>
                  <div className="radio-group">
                    <label className="radio-label"><input type="radio" checked={regType === 'new'} onChange={() => setRegType('new')} /> Học mới</label>
                    <label className="radio-label"><input type="radio" checked={regType === 'retake'} onChange={() => setRegType('retake')} /> Học lại</label>
                    <label className="radio-label"><input type="radio" checked={regType === 'improve'} onChange={() => setRegType('improve')} /> Học cải thiện</label>
                  </div>
                </div>

                {/* 1. Môn chờ ĐK */}
                <div className="section-header"><h4><Library className="w-4 h-4 inline-block mr-2" /> Môn học phần đang chờ đăng ký</h4></div>
                <div className="table-wrapper">
                  <table className="modern-table">
                    <thead>
                      <tr><th style={{width:'40px'}}></th><th>Mã MH</th><th>Tên môn học</th><th>TC</th><th>Bắt buộc</th></tr>
                    </thead>
                    <tbody>
                      {MOCK_SUBJECTS.map(sub => (
                        <tr key={sub.id} className={selectedSubject?.id === sub.id ? 'selected' : ''} onClick={() => {setSelectedSubject(sub); setSelectedClass(null);}}>
                          <td><input type="radio" checked={selectedSubject?.id === sub.id} readOnly style={{accentColor: 'var(--huit-blue)'}}/></td>
                          <td style={{fontFamily:'monospace', color:'var(--text-muted)'}}>{sub.id}</td>
                          <td style={{fontWeight:'500'}}>{sub.name}</td>
                          <td><span className="badge blue">{sub.credits}</span></td>
                          <td>{sub.required ? <span style={{color:'#dc2626', fontWeight:'bold'}}><X className="w-4 h-4 inline-block mr-2" /></span> : <span style={{color:'#16a34a'}}>Tự chọn</span>}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                {/* 2. Lớp chờ ĐK */}
                {selectedSubject && (
                  <>
                    <div className="section-header">
                      <h4><School className="w-4 h-4 inline-block mr-2" /> Lớp học phần chờ đăng ký</h4>
                      <label className="modern-checkbox">
                        <input type="checkbox" checked={hideConflict} onChange={(e) => setHideConflict(e.target.checked)}/> Lọc lớp trùng lịch
                      </label>
                    </div>
                    <div className="table-wrapper">
                      <table className="modern-table">
                        <thead>
                          <tr><th style={{width:'40px'}}></th><th>Mã Lớp</th><th>Tên lớp</th><th>Sĩ số</th><th>Trạng thái</th></tr>
                        </thead>
                        <tbody>
                          {MOCK_CLASSES.filter(c => c.subjectId === selectedSubject.id).map(cls => (
                            <tr key={cls.id} className={selectedClass?.id === cls.id ? 'selected' : ''} onClick={() => setSelectedClass(cls)}>
                              <td><input type="radio" checked={selectedClass?.id === cls.id} readOnly style={{accentColor: 'var(--huit-blue)'}}/></td>
                              <td style={{fontFamily:'monospace'}}>{cls.id}</td>
                              <td style={{fontWeight:'500'}}>{cls.name} <span style={{color:'var(--text-muted)', fontSize:'12px'}}>({cls.expected})</span></td>
                              <td><span style={{color: cls.registered >= cls.max ? '#dc2626' : 'inherit'}}>{cls.registered}/{cls.max}</span></td>
                              <td><span className="badge orange">{cls.status}</span></td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </>
                )}

                {/* 3. Chi tiết lớp */}
                {selectedClass && (
                  <div style={{background: '#f8fafc', padding: '24px', borderRadius: '16px', border: '1px solid var(--border-color)', marginBottom: '24px'}}>
                    <div className="section-header" style={{marginTop: 0}}>
                      <h4><Info className="w-4 h-4 inline-block mr-2" /> Chi tiết lịch học</h4>
                      <div style={{display:'flex', gap:'12px'}}>
                        <button className="btn btn-outline" onClick={() => setModalType('conflict')}><Search className="w-4 h-4 inline-block mr-2" /> Xem lịch trùng</button>
                        <button className="btn btn-primary" onClick={handleRegister}><Plus className="w-4 h-4 inline-block mr-2" /> Đăng ký lớp này</button>
                      </div>
                    </div>
                    <div className="table-wrapper" style={{marginBottom: 0, boxShadow: 'none'}}>
                      <table className="modern-table">
                        <thead>
                          <tr><th>Lịch học</th><th>Phòng / Tòa</th><th>Giảng viên</th><th>Thời gian</th><th></th></tr>
                        </thead>
                        <tbody>
                          {(MOCK_SCHEDULES[selectedClass.id] || []).map((sch, idx) => (
                            <tr key={idx}>
                              <td style={{fontWeight:'500'}}>{sch.day}</td>
                              <td>{sch.room} - {sch.building}</td>
                              <td>{sch.lecturer}</td>
                              <td style={{color:'var(--text-muted)'}}>{sch.time}</td>
                              <td style={{textAlign:'right'}}><button className="btn btn-outline" style={{padding:'4px 12px', fontSize:'12px'}} onClick={() => setModalType('lecturer')}>Info</button></td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}

                {/* 4. Lớp đã đăng ký */}
                <div className="section-header"><h4><CheckCircle2 className="w-4 h-4 inline-block mr-2" /> Lớp học phần đã đăng ký (Học kỳ này)</h4></div>
                <div className="table-wrapper">
                  <table className="modern-table">
                    <thead>
                      <tr><th style={{width:'60px'}}></th><th>Mã LHP</th><th>Tên môn học</th><th>TC</th><th>Học phí</th><th>Trạng thái</th></tr>
                    </thead>
                    <tbody>
                      {registeredClasses.length === 0 ? (
                        <tr><td colSpan="6" style={{textAlign:'center', padding:'32px', color:'var(--text-muted)'}}>Chưa có môn học nào được đăng ký</td></tr>
                      ) : (
                        registeredClasses.map(cls => (
                          <tr key={cls.id}>
                            <td className="action-dropdown">
                              <button className="action-btn" onClick={() => setDropdownOpen(dropdownOpen === cls.id ? null : cls.id)}>⋮</button>
                              {dropdownOpen === cls.id && (
                                <div className="action-menu">
                                  <div className="action-item" onClick={() => {setActionClass(cls); setModalType('classDetail'); setDropdownOpen(null);}}><Eye className="w-4 h-4 inline-block mr-2" /> Xem chi tiết</div>
                                  <div className="action-item danger" onClick={() => {setActionClass(cls); setModalType('cancelConfirm'); setDropdownOpen(null);}}><Trash2 className="w-4 h-4 inline-block mr-2" /> Hủy đăng ký</div>
                                </div>
                              )}
                            </td>
                            <td style={{fontFamily:'monospace'}}>{cls.id}</td>
                            <td style={{fontWeight:'600'}}>{cls.subjectName}</td>
                            <td><span className="badge blue">{cls.credits}</span></td>
                            <td style={{fontWeight:'500'}}>2,355,000 đ</td>
                            <td><span className="badge green">Thành công</span></td>
                          </tr>
                        ))
                      )}
                    </tbody>
                  </table>
                </div>

              </div>
            )}
          </main>
        </div>
      </div>

      {/* --- MODALS --- */}
      
      {modalType === 'conflict' && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">Lịch học bị trùng</div>
            <div className="modal-body text-center" style={{padding: '40px', color: 'var(--text-muted)'}}>
              <span style={{fontSize: '40px', display: 'block', marginBottom: '10px'}}><CheckCircle2 className="w-4 h-4 inline-block mr-2" /></span>
              Không phát hiện lịch học nào bị trùng.
            </div>
            <div className="modal-footer"><button className="btn btn-outline" onClick={() => setModalType(null)}>Đóng</button></div>
          </div>
        </div>
      )}

      {modalType === 'lecturer' && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">Hồ sơ Giảng viên</div>
            <div className="modal-body">
              <div style={{display: 'flex', gap: '24px', alignItems: 'center', marginBottom: '24px'}}>
                <img src="https://ui-avatars.com/api/?name=Phạm+Văn+Kiên&background=f97316&color=fff&size=80" style={{borderRadius: '12px'}} alt="GV"/>
                <div>
                  <h3 style={{margin: '0 0 8px 0', fontSize: '20px', color: 'var(--huit-blue)'}}>ThS. PHẠM VĂN KIÊN</h3>
                  <p style={{margin: 0, color: 'var(--text-muted)', fontSize: '14px'}}>Khoa Giáo dục Thể chất và Quốc phòng</p>
                </div>
              </div>
              <div className="info-grid">
                <p><span>Mã NS</span><b>01011013</b></p><p><span>Giới tính</span><b>Nam</b></p>
                <p><span>Chức vụ</span><b>Giảng viên</b></p><p><span>Email</span><b>kienpv@huit.edu.vn</b></p>
              </div>
            </div>
            <div className="modal-footer"><button className="btn btn-outline" onClick={() => setModalType(null)}>Đóng</button></div>
          </div>
        </div>
      )}

      {modalType === 'classDetail' && actionClass && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">Chi tiết lịch học: {actionClass.subjectName}</div>
            <div className="modal-body" style={{padding: 0}}>
              <table className="modern-table">
                <thead><tr><th>Lịch học</th><th>Phòng</th><th>Giảng viên</th><th>Thời gian</th></tr></thead>
                <tbody>
                  {(MOCK_SCHEDULES[actionClass.id] || MOCK_SCHEDULES['010110197501']).map((sch, idx) => (
                    <tr key={idx}><td>{sch.day}</td><td>{sch.room} - {sch.campus}</td><td>{sch.lecturer}</td><td>{sch.time}</td></tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="modal-footer"><button className="btn btn-outline" onClick={() => setModalType(null)}>Đóng</button></div>
          </div>
        </div>
      )}

      {modalType === 'cancelConfirm' && actionClass && (
        <div className="modal-overlay">
          <div className="modal-content small">
            <div className="modal-body">
              <div style={{fontSize: '50px', marginBottom: '16px'}}><Trash2 className="w-4 h-4 inline-block mr-2" /></div>
              <h3 style={{margin: '0 0 12px 0', fontSize: '20px'}}>Xác nhận hủy môn</h3>
              <p style={{color: 'var(--text-muted)', lineHeight: '1.5', margin: 0}}>Bạn có chắc chắn muốn hủy đăng ký lớp học <b>{actionClass.subjectName}</b> không? Hành động này không thể hoàn tác.</p>
            </div>
            <div className="modal-footer" style={{justifyContent: 'center', borderTop: 'none', paddingBottom: '24px'}}>
              <button className="btn btn-outline" onClick={() => setModalType(null)}>Quay lại</button>
              <button className="btn btn-danger" onClick={handleCancelRegistration}>Xác nhận Hủy</button>
            </div>
          </div>
        </div>
      )}

      {/* Toast Notification */}
      {toastMsg && (
        <div className="toast-msg">
          <span><Sparkles className="w-4 h-4 inline-block mr-2" /></span> {toastMsg}
        </div>
      )}
    </div>
  );
}