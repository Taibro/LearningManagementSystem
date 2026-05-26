import React from 'react';

export default function SystemLogs() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-extrabold text-white tracking-tight">Nhật ký Audit Logs &amp; An ninh</h1>
        <p className="text-sm text-[var(--saas-muted2)] mt-0.5">Theo dõi thời gian thực lịch sử ghi log truy xuất API nội bộ nền tảng SaaS</p>
      </div>

      <div className="saas-card p-0 overflow-hidden border-[var(--saas-border)]">
        <div className="p-4 bg-[var(--saas-surface2)] border-b border-[var(--saas-border)] flex items-center gap-3">
          <div className="w-2 h-2 rounded-full bg-red-500 animate-pulse"></div>
          <span className="text-xs font-mono tracking-wider uppercase text-[var(--saas-muted2)]">Streaming live diagnostics channel</span>
        </div>
        
        <table className="saas-table">
          <thead>
            <tr>
              <th>Timestamp</th>
              <th>Node / Service</th>
              <th>Sự kiện</th>
              <th>IP Address</th>
              <th>Mức độ</th>
            </tr>
          </thead>
          <tbody className="font-mono text-xs">
            <tr>
              <td className="text-gray-500">2026-05-19 16:32:01</td>
              <td className="text-[var(--saas-cyan)]">tenant-router-service</td>
              <td>Route request matched: [hcmut.edusaas.io/dashboard]</td>
              <td>14.226.45.102</td>
              <td><span className="text-[var(--saas-green)]">INFO</span></td>
            </tr>
            <tr>
              <td className="text-gray-500">2026-05-19 16:30:14</td>
              <td className="text-[var(--saas-purple)]">auth-service-v4</td>
              <td>Super Admin 2FA Verification successful</td>
              <td>112.198.22.41</td>
              <td><span className="text-[var(--saas-blue)]">SECURE</span></td>
            </tr>
            <tr>
              <td className="text-gray-500">2026-05-19 16:28:44</td>
              <td className="text-[var(--saas-amber)]">db-backup-worker</td>
              <td>CRON: Automated backup completed for node-04</td>
              <td>127.0.0.1</td>
              <td><span className="text-[var(--saas-green)]">INFO</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}