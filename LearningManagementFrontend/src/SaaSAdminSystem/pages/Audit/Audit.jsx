import React from 'react';
import { AUDITS } from '../../mockData';

export default function Audit() {
  const actionColor = { INSERT: 'badge-green', UPDATE: 'badge-blue', DELETE: 'badge-red', LOGIN: 'badge-purple' };

  return (
    <div>
      <div className="flex items-center gap-3 mb-4">
        <input type="text" placeholder="Tìm user, bảng, action..." className="inp" style={{ maxWidth: '260px' }} />
        <select className="inp" style={{ maxWidth: '150px' }}><option>Tất cả action</option><option>INSERT</option><option>UPDATE</option><option>DELETE</option></select>
        <select className="inp" style={{ maxWidth: '160px' }}><option>Tất cả trường</option><option>ĐH Bách Khoa HCM</option></select>
      </div>
      <div className="card overflow-hidden">
        <table>
          <thead>
            <tr><th>THỜI GIAN</th><th>NGƯỜI DÙNG</th><th>TRƯỜNG</th><th>ACTION</th><th>BẢNG</th><th>RECORD ID</th><th>IP</th><th></th></tr>
          </thead>
          <tbody>
            {AUDITS.map((a, index) => (
              <tr key={index}>
                <td className="font-mono text-xs" style={{ color: 'var(--muted)' }}>{a.time}</td>
                <td className="text-xs">{a.user}</td>
                <td className="text-xs">{a.school}</td>
                <td><span className={`badge ${actionColor[a.action]}`}>{a.action}</span></td>
                <td className="font-mono text-xs">{a.table}</td>
                <td className="font-mono text-xs" style={{ color: 'var(--muted)' }}>#{a.record}</td>
                <td className="font-mono text-xs" style={{ color: 'var(--muted)' }}>{a.ip}</td>
                <td><button className="btn btn-ghost btn-sm">Xem diff</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}