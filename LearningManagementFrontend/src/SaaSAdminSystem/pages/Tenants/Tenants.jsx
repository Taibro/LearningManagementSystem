import React, { useState } from 'react';
import { useOutletContext } from 'react-router-dom';
import { TENANTS } from '../../mockData';

export default function Tenants() {
  const { addToast } = useOutletContext();
  const [tenants, setTenants] = useState(TENANTS);
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [activeTenant, setActiveTenant] = useState(null);

  const toggleTenant = (id, isActive) => {
    setTenants(prev => prev.map(t => t.id === id ? { ...t, active: isActive } : t));
    const tName = tenants.find(x => x.id === id).name;
    addToast(isActive ? '✅' : '🔒', `${isActive ? 'MỞ KHOÁ' : 'KHOÁ'} tenant: ${tName}`, isActive ? 'green' : 'blue');
  };

  const getDaysLeft = (dateStr) => Math.ceil((new Date(dateStr) - new Date()) / 86400000);

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <div className="flex gap-3">
          <input type="text" placeholder="Tìm tên trường, mã, email..." className="inp" style={{ maxWidth: '280px' }} />
          <select className="inp" style={{ maxWidth: '160px' }}><option>Tất cả gói</option><option>Enterprise</option><option>Pro</option><option>Starter</option></select>
          <select className="inp" style={{ maxWidth: '160px' }}><option>Tất cả trạng thái</option><option>Đang hoạt động</option><option>Bị khóa</option><option>Hết hạn</option></select>
        </div>
        <button className="btn btn-primary btn-sm" onClick={() => setIsAddOpen(true)}>Thêm Tenant</button>
      </div>

      <div className="card overflow-hidden">
        <table>
          <thead>
            <tr><th>TRƯỜNG / TRUNG TÂM</th><th>GÓI CƯỚC</th><th>SỐ USERS</th><th>HẾT HẠN</th><th>STORAGE</th><th>TRẠNG THÁI</th><th>KILL SWITCH</th><th></th></tr>
          </thead>
          <tbody>
            {tenants.map(t => (
              <tr key={t.id}>
                <td><div className="font-semibold text-sm">{t.name}</div><div className="text-xs font-mono mt-0.5" style={{ color: 'var(--muted)' }}>{t.code} · {t.type}</div></td>
                <td><span className={`badge ${t.plan === 'Enterprise' ? 'badge-green' : t.plan === 'Pro' ? 'badge-purple' : 'badge-yellow'}`}>{t.plan}</span></td>
                <td><div className="text-sm">{t.students.toLocaleString()} SV</div><div className="text-xs" style={{ color: 'var(--muted)' }}>{t.teachers.toLocaleString()} GV</div></td>
                <td><div className="text-sm font-mono">{t.expires}</div>{getDaysLeft(t.expires) < 30 ? <div className="text-xs mt-0.5" style={{ color: 'var(--accent2)' }}>{getDaysLeft(t.expires)} ngày còn lại</div> : <div className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>{getDaysLeft(t.expires)} ngày còn lại</div>}</td>
                <td><div className="text-sm">{t.storage}</div><div className="progress mt-1" style={{ width: '80px' }}><div className="progress-fill" style={{ width: '60%', background: 'var(--accent)' }}></div></div></td>
                <td>{t.active ? <span className="badge badge-green">● Hoạt động</span> : <span className="badge badge-red">● Bị khóa</span>}</td>
                <td><label className="toggle" data-tip={t.active ? 'Đang BẬT — Click để khóa' : 'Đang TẮT — Click để mở'}><input type="checkbox" checked={t.active} onChange={(e) => toggleTenant(t.id, e.target.checked)} /><span className="slider"></span></label></td>
                <td><button className="btn btn-ghost btn-sm" onClick={() => setActiveTenant(t)}>Chi tiết</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {isAddOpen && (
        <div className="modal-overlay open">
          <div className="modal">
            <div className="flex items-center justify-between p-5 border-b" style={{ borderColor: 'var(--border)' }}>
              <div><p className="font-syne font-bold text-base">Thêm Tenant mới</p><p className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>Tạo trường + tài khoản School Admin đầu tiên</p></div>
              <button onClick={() => setIsAddOpen(false)} className="w-7 h-7 rounded-lg flex items-center justify-center text-lg" style={{ background: 'var(--surface2)', color: 'var(--muted)' }}>×</button>
            </div>
            <div className="p-5 space-y-3">
              <div className="grid grid-cols-2 gap-3"><div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>TÊN TRƯỜNG / TRUNG TÂM *</label><input className="inp" placeholder="VD: ĐH Bách Khoa HCM" /></div><div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>MÃ TRƯỜNG *</label><input className="inp" placeholder="VD: HCMUT" /></div></div>
              <div className="grid grid-cols-2 gap-3"><div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>LOẠI HÌNH</label><select className="inp"><option>university</option><option>college</option><option>language_center</option></select></div><div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>GÓI CƯỚC *</label><select className="inp"><option>Starter — ₫1.5M/tháng</option><option>Pro — ₫5.8M/tháng</option><option>Enterprise — Liên hệ</option></select></div></div>
              
              {/* ĐÃ BỔ SUNG CHU KỲ THANH TOÁN VÀ SĐT NHƯ HÌNH */}
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>CHU KỲ THANH TOÁN</label>
                  <select className="inp"><option>monthly</option><option>yearly</option><option>lifetime</option></select>
                </div>
                <div>
                  <label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>SỐ ĐIỆN THOẠI</label>
                  <input className="inp" placeholder="028-xxxx-xxxx" />
                </div>
              </div>

              <div className="card-sm p-3 mt-3">
                <p className="text-xs font-semibold mb-2" style={{ color: 'var(--accent3)' }}>⚡ Tài khoản School Admin (tự động tạo)</p>
                <div className="grid grid-cols-2 gap-3"><div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>HỌ TÊN ADMIN</label><input className="inp" placeholder="VD: Nguyễn Văn A" /></div><div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>EMAIL ADMIN *</label><input className="inp" type="email" placeholder="admin@truong.edu.vn" /></div></div>
              </div>
            </div>
            <div className="flex justify-end gap-3 p-5 border-t" style={{ borderColor: 'var(--border)' }}>
              <button className="btn btn-ghost" onClick={() => setIsAddOpen(false)}>Huỷ</button>
              <button className="btn btn-primary" onClick={() => { setIsAddOpen(false); addToast('🎉', 'Tạo Tenant thành công! Email đã gửi cho School Admin', 'green'); }}>Tạo Tenant & Gửi email</button>
            </div>
          </div>
        </div>
      )}

      {activeTenant && (
        <div className="modal-overlay open">
          <div className="modal" style={{ width: '560px' }}>
            <div className="flex items-center justify-between p-5 border-b" style={{ borderColor: 'var(--border)' }}>
              <p className="font-syne font-bold text-base">{activeTenant.name}</p>
              <button onClick={() => setActiveTenant(null)} className="w-7 h-7 rounded-lg flex items-center justify-center text-lg" style={{ background: 'var(--surface2)', color: 'var(--muted)' }}>×</button>
            </div>
            
            {/* ĐÃ BỔ SUNG ĐẦY ĐỦ CÁC FIELD NHƯ TRONG HTML VÀ HÌNH ẢNH */}
            <div className="p-5">
              <div className="grid grid-cols-2 gap-3 mb-4">
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>MÃ TRƯỜNG</p><p className="font-mono font-bold">{activeTenant.code}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>GÓI CƯỚC</p><p className="font-semibold">{activeTenant.plan}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>SINH VIÊN</p><p className="font-semibold">{activeTenant.students.toLocaleString()}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>GIẢNG VIÊN</p><p className="font-semibold">{activeTenant.teachers.toLocaleString()}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>STORAGE</p><p className="font-semibold">{activeTenant.storage}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>HẾT HẠN</p><p className={`font-semibold ${getDaysLeft(activeTenant.expires) < 30 ? 'text-yellow-400' : ''}`}>{activeTenant.expires}</p></div>
              </div>
              
              <div className="card-sm p-3 mb-3">
                <p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>EMAIL ADMIN TRƯỜNG</p>
                <p className="text-sm">{activeTenant.email}</p>
              </div>

              <div className="card-sm p-3">
                <p className="text-xs font-mono mb-2" style={{ color: 'var(--muted)' }}>TRẠNG THÁI KILL SWITCH</p>
                <div className="flex items-center gap-3">
                  <label className="toggle">
                    <input type="checkbox" checked={activeTenant.active} onChange={(e) => {
                      toggleTenant(activeTenant.id, e.target.checked);
                      setActiveTenant({...activeTenant, active: e.target.checked});
                    }} />
                    <span className="slider"></span>
                  </label>
                  <span className="text-sm" style={{ color: activeTenant.active ? 'var(--accent3)' : 'var(--accent2)' }}>
                    {activeTenant.active ? '● Trường đang hoạt động bình thường' : '● Trường đang bị khoá — User không thể đăng nhập'}
                  </span>
                </div>
              </div>
            </div>

            <div className="flex items-center justify-between p-5 border-t" style={{ borderColor: 'var(--border)' }}>
              <button className="btn btn-danger btn-sm pulse-red" onClick={() => { 
                toggleTenant(activeTenant.id, !activeTenant.active); 
                setActiveTenant(null); 
              }}>
                {activeTenant.active ? '⚡ Kích hoạt Kill Switch (Khoá ngay)' : '🔓 Mở khoá Tenant'}
              </button>
              <div className="flex gap-2">
                <button className="btn btn-ghost btn-sm" onClick={() => setActiveTenant(null)}>Đóng</button>
                <button className="btn btn-primary btn-sm">Lưu thay đổi</button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}