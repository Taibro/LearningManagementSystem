import React from 'react';

export default function Invoices() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Công nợ Học phí</h1>
      <div className="card">
        <div className="card-body" style={{ textAlign: 'center', padding: '40px', color: 'var(--muted)' }}>
          🧾 Chưa có hóa đơn học phí
        </div>
      </div>
    </div>
  );
}