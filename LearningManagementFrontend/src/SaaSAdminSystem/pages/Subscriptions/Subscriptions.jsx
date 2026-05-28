import React from 'react';
import { INVOICES } from '../../mockData';

export default function Subscriptions() {
  const statusBadge = { paid: 'badge-green', pending: 'badge-yellow', failed: 'badge-red' };
  const statusLabel = { paid: 'Đã thanh toán', pending: 'Chờ TT', failed: 'Thất bại' };
  const methodIcon = { bank_transfer: '🏦', momo: '📱', vnpay: '💳', cash: '💵' };

  return (
    <div>
      <div className="grid grid-cols-3 gap-4 mb-5">
        <div className="card p-4">
          <p className="text-xs font-mono mb-2" style={{ color: 'var(--muted)' }}>TỔNG DOANH THU (YTD)</p>
          <p className="stat-num text-2xl" style={{ color: 'var(--accent)' }}>₫892.3M</p>
          <p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>▲ +28% so với năm ngoái</p>
        </div>
        <div className="card p-4">
          <p className="text-xs font-mono mb-2" style={{ color: 'var(--muted)' }}>HOÁ ĐƠN CHỜ THANH TOÁN</p>
          <p className="stat-num text-2xl" style={{ color: 'var(--accent4)' }}>5</p>
          <p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>Tổng ₫38.5M chưa thu</p>
        </div>
        <div className="card p-4">
          <p className="text-xs font-mono mb-2" style={{ color: 'var(--muted)' }}>CHURN RATE (THÁNG)</p>
          <p className="stat-num text-2xl" style={{ color: 'var(--accent3)' }}>2.1%</p>
          <p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>1 trường huỷ trong tháng</p>
        </div>
      </div>

      <div className="card overflow-hidden">
        <div className="flex items-center justify-between p-4 border-b" style={{ borderColor: 'var(--border)' }}>
          <p className="font-syne font-bold text-sm">Lịch sử Hoá đơn SaaS</p>
          {/* ĐÃ CẬP NHẬT TÊN VÀ SỐ LƯỢNG TAB GIỐNG FILE HTML */}
          <div className="flex gap-2">
            <div className="tab active">Tất cả</div>
            <div className="tab">Đã thanh toán</div>
            <div className="tab">Chờ thanh toán</div>
            <div className="tab">Thất bại</div>
          </div>
        </div>
        <table>
          <thead>
            <tr><th>#INV</th><th>TRƯỜNG</th><th>GÓI</th><th>CHU KỲ</th><th>SỐ TIỀN</th><th>PHƯƠNG THỨC</th><th>NGÀY</th><th>TRẠNG THÁI</th></tr>
          </thead>
          <tbody>
            {INVOICES.map((i, index) => (
              <tr key={index}>
                <td className="font-mono text-xs">{i.id}</td>
                <td className="text-sm font-semibold">{i.school}</td>
                <td><span className={`badge ${i.plan === 'Enterprise' ? 'badge-green' : i.plan === 'Pro' ? 'badge-purple' : 'badge-yellow'}`}>{i.plan}</span></td>
                <td className="text-xs font-mono">{i.cycle}</td>
                <td className="font-mono text-sm font-semibold">{i.amount}</td>
                <td className="text-xs">{methodIcon[i.method]} {i.method.replace('_', ' ')}</td>
                <td className="text-xs font-mono">{i.date}</td>
                <td><span className={`badge ${statusBadge[i.status]}`}>{statusLabel[i.status]}</span></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}