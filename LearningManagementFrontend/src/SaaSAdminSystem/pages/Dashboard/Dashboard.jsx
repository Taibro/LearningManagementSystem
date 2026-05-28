import React, { useEffect } from 'react';
import Chart from 'chart.js/auto';

export default function Dashboard() {
  useEffect(() => {
    const gridColor = 'rgba(30,33,48,.8)';
    const font = { family: 'DM Mono', size: 10 };

    const revChart = new Chart(document.getElementById('revenueChart'), {
      type: 'bar',
      data: {
        labels: ['Th12/24','Th1/25','Th2/25','Th3/25','Th4/25','Th5/25'],
        datasets: [
          { label:'MRR (triệu ₫)', data:[98,105,111,118,123,127.5], backgroundColor:'rgba(124,109,250,.7)', borderRadius:5, borderSkipped:false },
          { label:'Khách mới', data:[2,3,1,4,2,4], backgroundColor:'rgba(109,250,194,.7)', borderRadius:5, borderSkipped:false, yAxisID:'y1' },
        ]
      },
      options: {
        responsive: true, maintainAspectRatio: false, interaction: { mode: 'index' },
        plugins: { legend: { display: false } },
        scales: {
          x: { grid: { color: gridColor }, ticks: { color: '#5a5f7a', font } },
          y: { grid: { color: gridColor }, ticks: { color: '#5a5f7a', font, callback: v => v + 'M' } },
          y1: { position: 'right', grid: { display: false }, ticks: { color: '#5a5f7a', font } }
        }
      }
    });

    const planChart = new Chart(document.getElementById('planChart'), {
      type: 'doughnut',
      data: {
        labels: ['Enterprise','Pro','Starter'],
        datasets: [{ data: [8,18,12], backgroundColor: ['#7c6dfa','#6dfac2','#fac96d'], borderWidth: 0, hoverOffset: 4 }]
      },
      options: { responsive: true, maintainAspectRatio: false, cutout: '72%', plugins: { legend: { display: false } } }
    });

    return () => { revChart.destroy(); planChart.destroy(); };
  }, []);

  return (
    <div>
      <div className="grid grid-cols-4 gap-4 mb-5">
        <div className="card p-5 col-span-1" style={{ background: 'linear-gradient(135deg,rgba(124,109,250,.15),rgba(124,109,250,.04))', borderColor: 'rgba(124,109,250,.25)' }}>
          <p className="text-xs font-mono mb-3" style={{ color: 'var(--muted)' }}>MRR (THÁNG NÀY)</p>
          <p className="stat-num text-3xl mrr-glow" style={{ color: 'var(--accent)' }}>₫127.5M</p>
          <p className="text-xs mt-2" style={{ color: 'var(--accent3)' }}>▲ +12.4% so với tháng trước</p>
        </div>
        <div className="card p-5">
          <p className="text-xs font-mono mb-3" style={{ color: 'var(--muted)' }}>TỔNG TRƯỜNG / TT</p>
          <p className="stat-num text-3xl">38</p>
          <div className="flex items-center gap-2 mt-2"><span className="badge badge-green">+4 tháng này</span></div>
        </div>
        <div className="card p-5">
          <p className="text-xs font-mono mb-3" style={{ color: 'var(--muted)' }}>TỔNG USERS</p>
          <p className="stat-num text-3xl">84,291</p>
          <p className="text-xs mt-2" style={{ color: 'var(--muted)' }}>62,840 SV · 21,451 GV</p>
        </div>
        <div className="card p-5">
          <p className="text-xs font-mono mb-3" style={{ color: 'var(--muted)' }}>STORAGE DÙNG</p>
          <p className="stat-num text-3xl">1.84<span className="text-lg font-sans font-normal ml-1" style={{ color: 'var(--muted)' }}>TB</span></p>
          <div className="progress mt-3"><div className="progress-fill" style={{ width: '61%', background: 'var(--accent4)' }}></div></div>
          <p className="text-xs mt-1.5" style={{ color: 'var(--muted)' }}>61% / 3TB quota</p>
        </div>
      </div>

      <div className="grid grid-cols-3 gap-4 mb-5">
        <div className="card p-5 col-span-2">
          <div className="flex items-center justify-between mb-4">
            <p className="font-syne font-bold text-sm">Doanh thu 6 tháng gần nhất</p>
            <div className="flex gap-2">
              <div className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--muted)' }}><span className="w-2.5 h-2.5 rounded-sm inline-block" style={{ background: 'var(--accent)' }}></span> MRR</div>
              <div className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--muted)' }}><span className="w-2.5 h-2.5 rounded-sm inline-block" style={{ background: 'var(--accent3)' }}></span> Khách mới</div>
            </div>
          </div>
          <div style={{ height: '180px' }}><canvas id="revenueChart"></canvas></div>
        </div>
        <div className="card p-5">
          <p className="font-syne font-bold text-sm mb-4">Phân bổ Gói cước</p>
          <div style={{ height: '160px' }}><canvas id="planChart"></canvas></div>
          <div className="space-y-2 mt-4">
            <div className="flex items-center justify-between text-xs"><span className="flex items-center gap-1.5"><span className="w-2.5 h-2.5 rounded-full inline-block" style={{ background: '#7c6dfa' }}></span>Enterprise</span><span className="font-mono">8 trường</span></div>
            <div className="flex items-center justify-between text-xs"><span className="flex items-center gap-1.5"><span className="w-2.5 h-2.5 rounded-full inline-block" style={{ background: '#6dfac2' }}></span>Pro</span><span className="font-mono">18 trường</span></div>
            <div className="flex items-center justify-between text-xs"><span className="flex items-center gap-1.5"><span className="w-2.5 h-2.5 rounded-full inline-block" style={{ background: '#fac96d' }}></span>Starter</span><span className="font-mono">12 trường</span></div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div className="card">
          <div className="flex items-center justify-between p-4 border-b" style={{ borderColor: 'var(--border)' }}>
            <p className="font-syne font-bold text-sm">Sắp hết hạn <span className="ml-1 badge badge-yellow">5 trường</span></p>
            <span className="text-xs" style={{ color: 'var(--muted)' }}>trong 30 ngày tới</span>
          </div>
          <div className="divide-y" style={{ borderColor: 'var(--border)' }}>
            <div className="p-3 flex items-center justify-between"><div><p className="text-sm font-semibold">ĐH Kinh tế Quốc dân</p><p className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>Gói Enterprise · 4,200 SV</p></div><div className="text-right"><span className="badge badge-red pulse-red">7 ngày</span><p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>₫12.5M/tháng</p></div></div>
            <div className="p-3 flex items-center justify-between"><div><p className="text-sm font-semibold">TT Ngoại ngữ IELTS Pro</p><p className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>Gói Pro · 620 HV</p></div><div className="text-right"><span className="badge badge-yellow">14 ngày</span><p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>₫3.2M/tháng</p></div></div>
            <div className="p-3 flex items-center justify-between"><div><p className="text-sm font-semibold">CĐ FPT Polytechnic</p><p className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>Gói Pro · 2,100 SV</p></div><div className="text-right"><span className="badge badge-yellow">21 ngày</span><p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>₫5.8M/tháng</p></div></div>
            <div className="p-3 flex items-center justify-between"><div><p className="text-sm font-semibold">THPT Chuyên Lê Hồng Phong</p><p className="text-xs mt-0.5" style={{ color: 'var(--muted)' }}>Gói Starter · 890 HS</p></div><div className="text-right"><span className="badge badge-yellow">28 ngày</span><p className="text-xs mt-1" style={{ color: 'var(--muted)' }}>₫1.5M/tháng</p></div></div>
          </div>
        </div>

        <div className="card">
          <div className="flex items-center justify-between p-4 border-b" style={{ borderColor: 'var(--border)' }}>
            <p className="font-syne font-bold text-sm">System Health</p>
            <span className="badge badge-green">● All systems operational</span>
          </div>
          <div className="p-4 space-y-4">
            <div><div className="flex justify-between text-xs mb-1.5"><span style={{ color: 'var(--muted)' }}>API Response Time</span><span className="font-mono">142ms avg</span></div><div className="progress"><div className="progress-fill" style={{ width: '15%', background: 'var(--accent3)' }}></div></div></div>
            <div><div className="flex justify-between text-xs mb-1.5"><span style={{ color: 'var(--muted)' }}>CPU Load</span><span className="font-mono">34%</span></div><div className="progress"><div className="progress-fill" style={{ width: '34%', background: 'var(--accent)' }}></div></div></div>
            <div><div className="flex justify-between text-xs mb-1.5"><span style={{ color: 'var(--muted)' }}>DB Connections</span><span className="font-mono">287 / 1000</span></div><div className="progress"><div className="progress-fill" style={{ width: '29%', background: 'var(--accent)' }}></div></div></div>
            <div><div className="flex justify-between text-xs mb-1.5"><span style={{ color: 'var(--muted)' }}>Cloudinary Storage</span><span className="font-mono">1.84TB / 3TB</span></div><div className="progress"><div className="progress-fill" style={{ width: '61%', background: 'var(--accent4)' }}></div></div></div>
            <div><div className="flex justify-between text-xs mb-1.5"><span style={{ color: 'var(--muted)' }}>Uptime (30 ngày)</span><span className="font-mono text-green-400">99.97%</span></div><div className="progress"><div className="progress-fill" style={{ width: '99.97%', background: 'var(--accent3)' }}></div></div></div>
          </div>
          <div className="px-4 pb-4">
            <div className="card-sm p-3 flex items-center gap-2">
              <div className="w-1.5 h-1.5 rounded-full flex-shrink-0" style={{ background: 'var(--accent2)' }}></div>
              <p className="text-xs" style={{ color: 'var(--muted)' }}><span style={{ color: 'var(--accent2)' }}>3 lỗi mới</span> trong 24h qua</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}