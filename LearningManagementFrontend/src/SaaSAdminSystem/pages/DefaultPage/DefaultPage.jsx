import React from 'react';

export default function DefaultPage({ title }) {
  return (
    <div className="saas-card p-10 text-center border-[var(--saas-border)]">
      <div className="text-3xl mb-3">🛠️</div>
      <h3 className="text-base font-bold text-white mb-1">{title}</h3>
      <p className="text-xs text-[var(--saas-muted2)]">Phân hệ đang kết nối đồng bộ hóa với Kubernetes cluster.</p>
    </div>
  );
}