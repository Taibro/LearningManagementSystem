import React, { useState } from 'react';

export default function Tenants() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-extrabold text-white tracking-tight">Quản lý Tenants (Tổ chức)</h1>
          <p className="text-sm text-[var(--saas-muted2)] mt-0.5">Quản lý không gian lưu trữ và database độc lập của từng cơ sở</p>
        </div>
        <button className="saas-btn" onClick={() => setIsOpen(true)}>+ Khởi tạo Tenant mới</button>
      </div>

      <div className="saas-card p-0 overflow-hidden">
        <table className="saas-table">
          <thead>
            <tr>
              <th>Tenant ID / Domain</th>
              <th>Tên tổ chức</th>
              <th>Gói dịch vụ</th>
              <th>Database Node</th>
              <th>Ngày kích hoạt</th>
              <th>Trạng thái</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td className="font-mono text-[var(--saas-blue)]">hcmut.edusaas.io</td>
              <td className="font-bold">Trường Đại học Bách Khoa TP.HCM</td>
              <td><span className="saas-badge saas-badge-info">ENTERPRISE</span></td>
              <td className="font-mono text-xs">db-cluster-node-01</td>
              <td>12/01/2024</td>
              <td><span className="saas-badge saas-badge-success">ĐANG CHẠY</span></td>
            </tr>
            <tr>
              <td className="font-mono text-[var(--saas-blue)]">ieltspro.edusaas.io</td>
              <td className="font-bold">Trung tâm Tiếng Anh IELTS Pro</td>
              <td><span className="saas-badge saas-badge-warning">GROWTH</span></td>
              <td className="font-mono text-xs">db-cluster-node-04</td>
              <td>18/03/2025</td>
              <td><span className="saas-badge saas-badge-success">ĐANG CHẠY</span></td>
            </tr>
          </tbody>
        </table>
      </div>

      {isOpen && (
        <div className="fixed inset-0 bg-black/60 backdrop-blur-sm z-[300] flex items-center justify-center p-4">
          <div className="saas-card w-full max-w-md space-y-4">
            <div className="flex justify-between items-center border-b border-[var(--saas-border)] pb-3">
              <h3 className="text-base font-bold text-white">Khởi tạo Tenant Độc lập</h3>
              <button className="text-xl text-gray-500 hover:text-white" onClick={() => setIsOpen(false)}>×</button>
            </div>
            <div className="space-y-3">
              <div>
                <label className="block text-xs font-mono text-[var(--saas-muted2)] mb-1">MÃ ĐỊNH DANH (SUBDOMAIN)</label>
                <input className="saas-input" placeholder="e.g. huit" />
              </div>
              <div>
                <label className="block text-xs font-mono text-[var(--saas-muted2)] mb-1">TÊN TRƯỜNG / TỔ CHỨC</label>
                <input className="saas-input" placeholder="e.g. Đại học Công Thương" />
              </div>
              <div>
                <label className="block text-xs font-mono text-[var(--saas-muted2)] mb-1">CHỌN DATABASE CLUSTER</label>
                <select className="saas-input">
                  <option>asia-southeast-db-01 (Production)</option>
                  <option>asia-southeast-db-02 (Backup-Node)</option>
                </select>
              </div>
            </div>
            <div className="flex justify-end gap-2 pt-2 border-t border-[var(--saas-border)]">
              <button className="px-4 py-2 text-sm text-gray-400 hover:text-white" onClick={() => setIsOpen(false)}>Hủy</button>
              <button className="saas-btn text-sm" onClick={() => setIsOpen(false)}>Cấp phát hạ tầng</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}