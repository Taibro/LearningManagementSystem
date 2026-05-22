import React from 'react';

export default function Semesters() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Học kỳ</h1>
      <div className="card">
        <div className="card-body" style={{ textAlign: 'center', padding: '40px', color: 'var(--muted)' }}>
          📅 3 học kỳ trong hệ thống
        </div>
      </div>
    </div>
  );
}