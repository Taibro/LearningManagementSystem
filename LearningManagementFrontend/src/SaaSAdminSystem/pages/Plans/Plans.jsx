import React, { useState, useEffect } from 'react';

const API_BASE = 'http://localhost:8080/api/saas-admin';

const getAuthHeaders = () => ({
  'Content-Type': 'application/json',
  'Authorization': `Bearer ${localStorage.getItem('saas_token')}`
});

export default function Plans() {
  const [plans, setPlans] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchPlans();
  }, []);

  const fetchPlans = async () => {
    try {
      const res = await fetch(`${API_BASE}/plans`, { headers: getAuthHeaders() });
      if (res.ok) {
        const data = await res.json();
        setPlans(data);
      }
    } catch (err) {
      console.error('Lỗi khi tải plans:', err);
    } finally {
      setLoading(false);
    }
  };

  const formatPrice = (price) => {
    if (!price) return '₫0';
    const millions = Number(price) / 1000000;
    return `₫${millions.toFixed(1)}M`;
  };

  const parseFeatures = (featuresJson) => {
    try {
      return JSON.parse(featuresJson || '[]');
    } catch {
      return [];
    }
  };

  const getPlanColor = (code) => {
    if (!code) return 'var(--accent4)';
    const c = code.toUpperCase();
    if (c === 'STARTER') return 'var(--accent4)';
    if (c === 'PRO') return 'var(--accent)';
    if (c === 'ENTERPRISE') return 'var(--accent3)';
    return 'var(--accent)';
  };

  const getPlanBadgeClass = (code) => {
    if (!code) return 'badge-yellow';
    const c = code.toUpperCase();
    if (c === 'STARTER') return 'badge-yellow';
    if (c === 'PRO') return 'badge-purple';
    if (c === 'ENTERPRISE') return 'badge-green';
    return 'badge-blue';
  };

  if (loading) {
    return <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '400px', color: 'var(--muted)' }}>Đang tải dữ liệu...</div>;
  }

  return (
    <div>
      <div className="grid grid-cols-3 gap-5">
        {plans.map((plan, index) => {
          const isPro = plan.code?.toUpperCase() === 'PRO';
          const features = parseFeatures(plan.features);
          const color = getPlanColor(plan.code);
          const badgeClass = getPlanBadgeClass(plan.code);

          return (
            <div key={plan.id} className="card p-5 relative overflow-hidden"
              style={isPro ? { borderColor: 'var(--accent)', boxShadow: '0 0 30px rgba(124,109,250,.12)' } : {}}>
              {isPro && <div className="absolute -top-px left-0 right-0 h-0.5 rounded-t-xl" style={{ background: 'var(--accent)' }}></div>}
              <div className="absolute top-0 right-0 w-24 h-24 rounded-full -translate-y-8 translate-x-8" style={{ background: `${color}10` }}></div>
              
              <div className="flex items-center justify-between mb-1">
                <p className="font-mono text-xs" style={{ color }}>{plan.code?.toUpperCase()}</p>
                {isPro && <span className="badge badge-purple">PHỔ BIẾN NHẤT</span>}
              </div>
              
              <p className="font-syne font-bold text-2xl mb-1">
                {plan.code?.toUpperCase() === 'ENTERPRISE' ? 'Liên hệ' : formatPrice(plan.monthlyPrice)}
                {plan.code?.toUpperCase() !== 'ENTERPRISE' && <span className="text-sm font-sans font-normal" style={{ color: 'var(--muted)' }}>/tháng</span>}
                {plan.code?.toUpperCase() === 'ENTERPRISE' && <span className="text-sm font-sans font-normal ml-1" style={{ color: 'var(--muted)' }}>/ custom</span>}
              </p>
              
              <p className="text-xs mb-4" style={{ color: 'var(--muted)' }}>
                {plan.code?.toUpperCase() === 'ENTERPRISE' ? 'Hợp đồng theo năm · SLA riêng' : `${formatPrice(plan.yearlyPrice)}/năm (tiết kiệm 17%)`}
              </p>
              
              <div className="space-y-2 text-xs mb-5">
                <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Tối đa <strong>{plan.maxStudents === -1 ? 'Không giới hạn' : plan.maxStudents?.toLocaleString()}</strong> sinh viên</div>
                <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> {plan.maxStorageGb === -1 ? 'Storage theo yêu cầu' : `${plan.maxStorageGb}GB lưu trữ`}</div>
                {features.map((f, i) => (
                  <div key={i} className="flex items-center gap-2">
                    <span style={{ color: f.included ? 'var(--accent3)' : 'var(--muted)' }}>{f.included ? '✓' : '✕'}</span>
                    <span style={f.included ? {} : { color: 'var(--muted)' }}>{f.name}</span>
                  </div>
                ))}
              </div>
              
              <div className="flex items-center justify-between">
                <span className={`badge ${badgeClass}`}>{plan.subscriberCount} trường đang dùng</span>
                <button className="btn btn-ghost btn-sm">Sửa</button>
              </div>
            </div>
          );
        })}
      </div>

      {/* Ma trận tính năng */}
      <div className="card mt-5 overflow-hidden">
        <div className="p-4 border-b" style={{ borderColor: 'var(--border)' }}>
          <p className="font-syne font-bold text-sm">Ma trận tính năng</p>
        </div>
        <table>
          <thead>
            <tr>
              <th style={{ width: '40%' }}>TÍNH NĂNG</th>
              {plans.map(p => <th key={p.id} className="text-center">{p.code?.toUpperCase()}</th>)}
            </tr>
          </thead>
          <tbody>
            <tr><td className="text-xs font-semibold py-2.5" style={{ color: 'var(--muted)' }}>HỌC VỤ CƠ BẢN</td>{plans.map(p => <td key={p.id}></td>)}</tr>
            <tr><td className="text-sm">Quản lý lớp học & Lịch học</td>{plans.map(p => <td key={p.id} className="text-center text-green-400">✓</td>)}</tr>
            <tr><td className="text-sm">Điểm danh & Đăng ký học phần</td>{plans.map(p => <td key={p.id} className="text-center text-green-400">✓</td>)}</tr>
            <tr><td className="text-sm">Thông báo trong app</td>{plans.map(p => <td key={p.id} className="text-center text-green-400">✓</td>)}</tr>
            
            <tr><td className="text-xs font-semibold py-2.5" style={{ color: 'var(--muted)' }}>TÀI CHÍNH & NHÂN SỰ</td>{plans.map(p => <td key={p.id}></td>)}</tr>
            <tr><td className="text-sm">Quản lý học phí</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'STARTER' ? { color: 'var(--muted)' } : {}}>{p.code?.toUpperCase() === 'STARTER' ? '✕' : <span className="text-green-400">✓</span>}</td>)}</tr>
            <tr><td className="text-sm">Bảng lương giảng viên theo bậc</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'STARTER' ? { color: 'var(--muted)' } : {}}>{p.code?.toUpperCase() === 'STARTER' ? '✕' : <span className="text-green-400">✓</span>}</td>)}</tr>
            
            <tr><td className="text-xs font-semibold py-2.5" style={{ color: 'var(--muted)' }}>NÂNG CAO</td>{plans.map(p => <td key={p.id}></td>)}</tr>
            <tr><td className="text-sm">Báo cáo & Dashboard Analytics</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'STARTER' ? { color: 'var(--muted)' } : {}}>{p.code?.toUpperCase() === 'STARTER' ? '✕' : <span className="text-green-400">✓</span>}</td>)}</tr>
            <tr><td className="text-sm">QR Code điểm danh</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'STARTER' ? { color: 'var(--muted)' } : {}}>{p.code?.toUpperCase() === 'STARTER' ? '✕' : <span className="text-green-400">✓</span>}</td>)}</tr>
            <tr><td className="text-sm">SSO / Azure AD / Google Workspace</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'ENTERPRISE' ? {} : { color: 'var(--muted)' }}>{p.code?.toUpperCase() === 'ENTERPRISE' ? <span className="text-green-400">✓</span> : '✕'}</td>)}</tr>
            <tr><td className="text-sm">Open API tích hợp ERP</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'ENTERPRISE' ? {} : { color: 'var(--muted)' }}>{p.code?.toUpperCase() === 'ENTERPRISE' ? <span className="text-green-400">✓</span> : '✕'}</td>)}</tr>
            <tr><td className="text-sm">Audit Log đầy đủ + Export</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'ENTERPRISE' ? {} : { color: 'var(--muted)' }}>{p.code?.toUpperCase() === 'ENTERPRISE' ? <span className="text-green-400">✓</span> : '✕'}</td>)}</tr>
            <tr><td className="text-sm">SLA & Backup riêng</td>{plans.map(p => <td key={p.id} className="text-center" style={p.code?.toUpperCase() === 'ENTERPRISE' ? {} : { color: 'var(--muted)' }}>{p.code?.toUpperCase() === 'ENTERPRISE' ? <span className="text-green-400">✓</span> : '✕'}</td>)}</tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}