import React from 'react';

export default function AcademicYears() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Năm học</h1>
      <div className="card">
        <div className="card-body" style={{ textAlign: 'center', padding: '40px', color: 'var(--muted)' }}>
          📆 2 năm học đang hoạt động
        </div>
      </div>
    </div>
  );
}