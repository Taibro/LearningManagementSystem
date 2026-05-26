import React from 'react';

export default function Departments() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Khoa / Bộ môn</h1>
      <div className="card">
        <div className="card-body" style={{ textAlign: 'center', padding: '40px', color: 'var(--muted)' }}>
          🏛 Quản lý 3 khoa / bộ môn trong hệ thống
        </div>
      </div>
    </div>
  );
}