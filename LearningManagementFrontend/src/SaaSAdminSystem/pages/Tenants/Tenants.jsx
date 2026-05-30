import React, { useState, useEffect } from 'react';
import { useOutletContext } from 'react-router-dom';

const API_BASE = 'http://localhost:8080/api/saas-admin';

const getAuthHeaders = () => ({
  'Content-Type': 'application/json',
  'Authorization': `Bearer ${localStorage.getItem('saas_token')}`
});

export default function Tenants() {
  const { addToast } = useOutletContext();
  const [tenants, setTenants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [activeTenant, setActiveTenant] = useState(null);

  // Form state cho thêm tenant
  const [form, setForm] = useState({
    schoolName: '', schoolCode: '', schoolType: 'UNIVERSITY',
    planId: 1, billingCycle: 'MONTHLY', phone: '',
    adminName: '', adminEmail: ''
  });

  // Plans cho dropdown
  const [plans, setPlans] = useState([]);

  useEffect(() => {
    fetchTenants();
    fetchPlans();
  }, []);

  const fetchTenants = async () => {
    try {
      const res = await fetch(`${API_BASE}/tenants`, { headers: getAuthHeaders() });
      if (res.ok) {
        const data = await res.json();
        setTenants(data);
      }
    } catch (err) {
      console.error('Lỗi khi tải tenants:', err);
    } finally {
      setLoading(false);
    }
  };

  const fetchPlans = async () => {
    try {
      const res = await fetch(`${API_BASE}/plans`, { headers: getAuthHeaders() });
      if (res.ok) {
        const data = await res.json();
        setPlans(data);
        if (data.length > 0) setForm(f => ({ ...f, planId: data[0].id }));
      }
    } catch (err) {
      console.error('Lỗi khi tải plans:', err);
    }
  };

  const toggleTenant = async (id, isActive) => {
    try {
      const res = await fetch(`${API_BASE}/tenants/${id}/status`, {
        method: 'PATCH',
        headers: getAuthHeaders(),
        body: JSON.stringify({ isActive })
      });
      if (res.ok) {
        setTenants(prev => prev.map(t => t.id === id ? { ...t, active: isActive } : t));
        const tName = tenants.find(x => x.id === id)?.name;
        addToast(isActive ? '✅' : '🔒', `${isActive ? 'MỞ KHOÁ' : 'KHOÁ'} tenant: ${tName}`, isActive ? 'green' : 'blue');
      }
    } catch (err) {
      addToast('❌', 'Lỗi khi thay đổi trạng thái tenant', 'red');
    }
  };

  const handleCreateTenant = async () => {
    try {
      const res = await fetch(`${API_BASE}/tenants`, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify(form)
      });
      if (res.ok) {
        setIsAddOpen(false);
        fetchTenants();
        addToast('🎉', 'Tạo Tenant thành công! Email đã gửi cho School Admin', 'green');
        setForm({ schoolName: '', schoolCode: '', schoolType: 'UNIVERSITY', planId: plans[0]?.id || 1, billingCycle: 'MONTHLY', phone: '', adminName: '', adminEmail: '' });
      } else {
        const err = await res.json();
        addToast('❌', err.message || 'Lỗi khi tạo tenant', 'red');
      }
    } catch (err) {
      addToast('❌', 'Không thể kết nối đến server', 'red');
    }
  };

  if (loading) {
    return <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '400px', color: 'var(--muted)' }}>Đang tải dữ liệu...</div>;
  }

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
                <td><span className={`badge ${t.planName === 'Enterprise' ? 'badge-green' : t.planName === 'Pro' ? 'badge-purple' : 'badge-yellow'}`}>{t.planName}</span></td>
                <td><div className="text-sm">{(t.students || 0).toLocaleString()} SV</div><div className="text-xs" style={{ color: 'var(--muted)' }}>{(t.teachers || 0).toLocaleString()} GV</div></td>
                <td><div className="text-sm font-mono">{t.expires}</div>{t.daysLeft < 30 ? <div className="text-xs mt-0.5" style={{ color: 'var(--accent2)' }}>{t.daysLeft} ngày còn lại</div> : <div className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>{t.daysLeft} ngày còn lại</div>}</td>
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
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>TÊN TRƯỜNG / TRUNG TÂM *</label><input className="inp" placeholder="VD: ĐH Bách Khoa HCM" value={form.schoolName} onChange={e => setForm({...form, schoolName: e.target.value})} /></div>
                <div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>MÃ TRƯỜNG *</label><input className="inp" placeholder="VD: HCMUT" value={form.schoolCode} onChange={e => setForm({...form, schoolCode: e.target.value})} /></div>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>LOẠI HÌNH</label><select className="inp" value={form.schoolType} onChange={e => setForm({...form, schoolType: e.target.value})}><option value="UNIVERSITY">university</option><option value="COLLEGE">college</option><option value="LANGUAGE_CENTER">language_center</option><option value="HIGH_SCHOOL">high_school</option><option value="TUTORING_CENTER">tutoring_center</option></select></div>
                <div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>GÓI CƯỚC *</label><select className="inp" value={form.planId} onChange={e => setForm({...form, planId: Number(e.target.value)})}>{plans.map(p => <option key={p.id} value={p.id}>{p.name} — ₫{(Number(p.monthlyPrice)/1000000).toFixed(1)}M/tháng</option>)}</select></div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>CHU KỲ THANH TOÁN</label>
                  <select className="inp" value={form.billingCycle} onChange={e => setForm({...form, billingCycle: e.target.value})}><option value="MONTHLY">monthly</option><option value="YEARLY">yearly</option></select>
                </div>
                <div>
                  <label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>SỐ ĐIỆN THOẠI</label>
                  <input className="inp" placeholder="028-xxxx-xxxx" value={form.phone} onChange={e => setForm({...form, phone: e.target.value})} />
                </div>
              </div>

              <div className="card-sm p-3 mt-3">
                <p className="text-xs font-semibold mb-2" style={{ color: 'var(--accent3)' }}>⚡ Tài khoản School Admin (tự động tạo)</p>
                <div className="grid grid-cols-2 gap-3">
                  <div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>HỌ TÊN ADMIN</label><input className="inp" placeholder="VD: Nguyễn Văn A" value={form.adminName} onChange={e => setForm({...form, adminName: e.target.value})} /></div>
                  <div><label className="text-xs font-mono mb-1.5 block" style={{ color: 'var(--muted)' }}>EMAIL ADMIN *</label><input className="inp" type="email" placeholder="admin@truong.edu.vn" value={form.adminEmail} onChange={e => setForm({...form, adminEmail: e.target.value})} /></div>
                </div>
              </div>
            </div>
            <div className="flex justify-end gap-3 p-5 border-t" style={{ borderColor: 'var(--border)' }}>
              <button className="btn btn-ghost" onClick={() => setIsAddOpen(false)}>Huỷ</button>
              <button className="btn btn-primary" onClick={handleCreateTenant}>Tạo Tenant & Gửi email</button>
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
            
            <div className="p-5">
              <div className="grid grid-cols-2 gap-3 mb-4">
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>MÃ TRƯỜNG</p><p className="font-mono font-bold">{activeTenant.code}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>GÓI CƯỚC</p><p className="font-semibold">{activeTenant.planName}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>SINH VIÊN</p><p className="font-semibold">{(activeTenant.students || 0).toLocaleString()}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>GIẢNG VIÊN</p><p className="font-semibold">{(activeTenant.teachers || 0).toLocaleString()}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>STORAGE</p><p className="font-semibold">{activeTenant.storage}</p></div>
                <div className="card-sm p-3"><p className="text-xs font-mono mb-1" style={{ color: 'var(--muted)' }}>HẾT HẠN</p><p className={`font-semibold ${activeTenant.daysLeft < 30 ? 'text-yellow-400' : ''}`}>{activeTenant.expires}</p></div>
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
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}