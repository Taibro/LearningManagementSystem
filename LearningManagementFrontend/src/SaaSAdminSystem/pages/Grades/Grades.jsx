import React from 'react';

export default function Grades() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Kết quả học tập</h1>
      <div className="card">
        <div className="card-body" style={{ textAlign: 'center', padding: '40px', color: 'var(--muted)' }}>
          📊 Chưa có điểm được nhập
        </div>
      </div>
    </div>
  );
}