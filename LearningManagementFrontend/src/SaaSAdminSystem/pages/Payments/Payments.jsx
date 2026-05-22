import React from 'react';

export default function Payments() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Giao dịch Thanh toán</h1>
      <div className="card">
        <div className="card-body" style={{ textAlign: 'center', padding: '40px', color: 'var(--muted)' }}>
          💳 Chưa có giao dịch
        </div>
      </div>
    </div>
  );
}