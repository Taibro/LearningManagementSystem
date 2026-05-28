import React from 'react';

export default function Plans() {
  return (
    <div>
      <div className="grid grid-cols-3 gap-5">
        <div className="card p-5 relative overflow-hidden">
          <div className="absolute top-0 right-0 w-24 h-24 rounded-full -translate-y-8 translate-x-8" style={{ background: 'rgba(250,201,109,.06)' }}></div>
          <p className="font-mono text-xs mb-1" style={{ color: 'var(--accent4)' }}>STARTER</p>
          <p className="font-syne font-bold text-2xl mb-1">₫1.5M<span className="text-sm font-sans font-normal" style={{ color: 'var(--muted)' }}>/tháng</span></p>
          <p className="text-xs mb-4" style={{ color: 'var(--muted)' }}>₫15M/năm (tiết kiệm 17%)</p>
          <div className="space-y-2 text-xs mb-5">
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Tối đa <strong>500 sinh viên</strong></div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> 1 cơ sở</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> 10GB lưu trữ</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Quản lý lớp + Lịch học</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Điểm danh + Đăng ký</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--muted)' }}>✕</span> <span style={{ color: 'var(--muted)' }}>Học phí & Lương GV</span></div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--muted)' }}>✕</span> <span style={{ color: 'var(--muted)' }}>Báo cáo nâng cao</span></div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--muted)' }}>✕</span> <span style={{ color: 'var(--muted)' }}>API & SSO</span></div>
          </div>
          <div className="flex items-center justify-between"><span className="badge badge-yellow">12 trường đang dùng</span><button className="btn btn-ghost btn-sm">Sửa</button></div>
        </div>

        <div className="card p-5 relative overflow-hidden" style={{ borderColor: 'var(--accent)', boxShadow: '0 0 30px rgba(124,109,250,.12)' }}>
          <div className="absolute -top-px left-0 right-0 h-0.5 rounded-t-xl" style={{ background: 'var(--accent)' }}></div>
          <div className="absolute top-0 right-0 w-32 h-32 rounded-full -translate-y-10 translate-x-10" style={{ background: 'rgba(124,109,250,.06)' }}></div>
          <div className="flex items-center justify-between mb-1"><p className="font-mono text-xs" style={{ color: 'var(--accent)' }}>PRO</p><span className="badge badge-purple">PHỔ BIẾN NHẤT</span></div>
          <p className="font-syne font-bold text-2xl mb-1">₫5.8M<span className="text-sm font-sans font-normal" style={{ color: 'var(--muted)' }}>/tháng</span></p>
          <p className="text-xs mb-4" style={{ color: 'var(--muted)' }}>₫58M/năm (tiết kiệm 17%)</p>
          <div className="space-y-2 text-xs mb-5">
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Tối đa <strong>5,000 sinh viên</strong></div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> 5 cơ sở</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> 100GB lưu trữ</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Tất cả tính năng Starter</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Học phí & Lương GV</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Báo cáo nâng cao</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> QR Code điểm danh</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--muted)' }}>✕</span> <span style={{ color: 'var(--muted)' }}>API & SSO / Azure AD</span></div>
          </div>
          <div className="flex items-center justify-between"><span className="badge badge-purple">18 trường đang dùng</span><button className="btn btn-ghost btn-sm">Sửa</button></div>
        </div>

        <div className="card p-5 relative overflow-hidden">
          <div className="absolute top-0 right-0 w-32 h-32 rounded-full -translate-y-10 translate-x-10" style={{ background: 'rgba(109,250,194,.05)' }}></div>
          <p className="font-mono text-xs mb-1" style={{ color: 'var(--accent3)' }}>ENTERPRISE</p>
          <p className="font-syne font-bold text-2xl mb-1">Liên hệ<span className="text-sm font-sans font-normal ml-1" style={{ color: 'var(--muted)' }}>/ custom</span></p>
          <p className="text-xs mb-4" style={{ color: 'var(--muted)' }}>Hợp đồng theo năm · SLA riêng</p>
          <div className="space-y-2 text-xs mb-5">
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> <strong>Không giới hạn</strong> sinh viên</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Không giới hạn cơ sở</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Storage theo yêu cầu</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Tất cả tính năng Pro</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> API tích hợp ERP</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> SSO / Azure AD / Google</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Backup riêng · SLA 99.9%</div>
            <div className="flex items-center gap-2"><span style={{ color: 'var(--accent3)' }}>✓</span> Audit Log đầy đủ</div>
          </div>
          <div className="flex items-center justify-between"><span className="badge badge-green">8 trường đang dùng</span><button className="btn btn-ghost btn-sm">Sửa</button></div>
        </div>
      </div>

      {/* ĐÃ BỔ SUNG BẢNG MA TRẬN TÍNH NĂNG */}
      <div className="card mt-5 overflow-hidden">
        <div className="p-4 border-b" style={{ borderColor: 'var(--border)' }}>
          <p className="font-syne font-bold text-sm">Ma trận tính năng</p>
        </div>
        <table>
          <thead>
            <tr>
              <th style={{ width: '40%' }}>TÍNH NĂNG</th>
              <th className="text-center">STARTER</th>
              <th className="text-center">PRO</th>
              <th className="text-center">ENTERPRISE</th>
            </tr>
          </thead>
          <tbody>
            <tr><td className="text-xs font-semibold py-2.5" style={{ color: 'var(--muted)' }}>HỌC VỤ CƠ BẢN</td><td></td><td></td><td></td></tr>
            <tr><td className="text-sm">Quản lý lớp học & Lịch học</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">Điểm danh & Đăng ký học phần</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">Thông báo trong app</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            
            <tr><td className="text-xs font-semibold py-2.5" style={{ color: 'var(--muted)' }}>TÀI CHÍNH & NHÂN SỰ</td><td></td><td></td><td></td></tr>
            <tr><td className="text-sm">Quản lý học phí</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">Bảng lương giảng viên theo bậc</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            
            <tr><td className="text-xs font-semibold py-2.5" style={{ color: 'var(--muted)' }}>NÂNG CAO</td><td></td><td></td><td></td></tr>
            <tr><td className="text-sm">Báo cáo & Dashboard Analytics</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">QR Code điểm danh</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">SSO / Azure AD / Google Workspace</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">Open API tích hợp ERP</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">Audit Log đầy đủ + Export</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td></tr>
            <tr><td className="text-sm">SLA & Backup riêng</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center" style={{ color: 'var(--muted)' }}>✕</td><td className="text-center text-green-400">✓</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}