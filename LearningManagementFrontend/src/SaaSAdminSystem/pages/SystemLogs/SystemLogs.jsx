import React, { useState } from 'react';
import { useOutletContext } from 'react-router-dom';
import { LOGS } from '../../mockData';

export default function SystemLogs() {
  const { addToast } = useOutletContext();
  const [logs, setLogs] = useState(LOGS);

  const markResolved = (id) => {
    setLogs(prev => prev.map(l => l.id === id ? { ...l, resolved: true } : l));
    addToast('✅', 'Đã đánh dấu lỗi là Resolved', 'green');
  };

  return (
    <div>
      <div className="flex items-center gap-3 mb-4">
        <div className="flex gap-2"><div className="tab active">Tất cả (47)</div><div className="tab">Chưa xử lý (3)</div><div className="tab">Đã fix</div></div>
        <select className="inp ml-auto" style={{ maxWidth: '180px' }}><option>24h qua</option><option>7 ngày</option></select>
      </div>
      <div className="card overflow-hidden">
        <table>
          <thead>
            <tr><th style={{ width: '50px' }}>#</th><th>ENDPOINT</th><th>LỖI</th><th>TRƯỜNG</th><th>THỜI GIAN</th><th>TRẠNG THÁI</th><th></th></tr>
          </thead>
          <tbody>
            {logs.map(l => (
              <tr key={l.id}>
                <td className="font-mono text-xs" style={{ color: 'var(--muted)' }}>{l.id}</td>
                <td className="font-mono text-xs" style={{ color: 'var(--accent)' }}>{l.endpoint}</td>
                <td className="text-xs max-w-xs truncate" style={{ maxWidth: '200px', color: 'var(--accent2)' }}>{l.error}</td>
                <td className="text-xs">{l.school}</td>
                <td className="font-mono text-xs" style={{ color: 'var(--muted)' }}>{l.time}</td>
                <td>{l.resolved ? <span className="badge badge-green">✓ Đã fix</span> : <span className="badge badge-red pulse-red">● Chưa xử lý</span>}</td>
                <td>{!l.resolved && <button className="btn btn-ghost btn-sm" onClick={() => markResolved(l.id)}>Mark fixed</button>}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}