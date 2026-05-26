import React from 'react';

export default function Plans() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-extrabold text-white tracking-tight">Thiết lập cấu hình SaaS Gói dịch vụ</h1>
        <p className="text-sm text-[var(--saas-muted2)] mt-0.5">Phân định hạn ngạch (Quotas) tài nguyên phần cứng cho các cấp độ tài khoản</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="saas-card border-[var(--saas-border2)] flex flex-col justify-between">
          <div className="space-y-4">
            <div className="text-xs font-mono text-[var(--saas-cyan)] uppercase tracking-widest font-bold">BASIC PLAN</div>
            <div className="text-3xl font-black text-white">49$ <span className="text-xs font-normal text-[var(--saas-muted2)]">/ tháng</span></div>
            <hr className="border-[var(--saas-border)]" />
            <ul className="text-sm space-y-2 text-[var(--saas-text)] opacity-80">
              <li>• Giới hạn 500 Học viên</li>
              <li>• Storage: 20 GB Cloud SSD</li>
              <li>• DB độc lập chuẩn SQLite/MySQL isolated</li>
            </ul>
          </div>
          <button className="saas-btn w-full mt-6 bg-[var(--saas-surface2)] border border-[var(--saas-border)] hover:bg-[var(--saas-border)]">Cấu hình lại hạn mức</button>
        </div>

        <div className="saas-card border-[var(--saas-blue)] bg-gradient-to-b from-[var(--saas-surface)] to-[var(--saas-blue-dim)]/20 flex flex-col justify-between">
          <div className="space-y-4">
            <div className="text-xs font-mono text-[var(--saas-blue)] uppercase tracking-widest font-bold">GROWTH ADVANCED</div>
            <div className="text-3xl font-black text-white">199$ <span className="text-xs font-normal text-[var(--saas-muted2)]">/ tháng</span></div>
            <hr className="border-[var(--saas-border)]" />
            <ul className="text-sm space-y-2 text-[var(--saas-text)]">
              <li>• Giới hạn 5.000 Học viên</li>
              <li>• Storage: 200 GB NVMe Cloud</li>
              <li>• Hỗ trợ Backup tự động hàng ngày</li>
            </ul>
          </div>
          <button className="saas-btn w-full mt-6">Cấu hình lại hạn mức</button>
        </div>

        <div className="saas-card border-[var(--saas-purple)] flex flex-col justify-between">
          <div className="space-y-4">
            <div className="text-xs font-mono text-[var(--saas-purple)] uppercase tracking-widest font-bold">ENTERPRISE SCALE</div>
            <div className="text-3xl font-black text-white">Custom <span className="text-xs font-normal text-[var(--saas-muted2)]">/ Overage</span></div>
            <hr className="border-[var(--saas-border)]" />
            <ul className="text-sm space-y-2 text-[var(--saas-text)] opacity-80">
              <li>• Không giới hạn Học viên</li>
              <li>• Dedicated Server &amp; Database cluster</li>
              <li>• SLA Cam kết uptime 99.99%</li>
            </ul>
          </div>
          <button className="saas-btn w-full mt-6 bg-[var(--saas-surface2)] border border-[var(--saas-border)] hover:bg-[var(--saas-border)]">Cấu hình lại hạn mức</button>
        </div>
      </div>
    </div>
  );
}