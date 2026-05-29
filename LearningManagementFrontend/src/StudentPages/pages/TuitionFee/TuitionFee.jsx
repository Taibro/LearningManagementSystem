import React, { useEffect, useState } from 'react';
import { getTuition } from '../../studentApi';

export default function TuitionFee() {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(true);
  const [tab, setTab] = useState('hp');

  useEffect(() => {
    getTuition()
      .then(data => { setRows(data); setLoading(false); })
      .catch(() => setLoading(false));
  }, []);

  const formatMoney = (n) => n != null ? Number(n).toLocaleString('vi-VN') : '0';

  const statusLabel = (s) => {
    if (s === 'PAID')    return { label: 'Đã nộp', color: 'var(--green)' };
    if (s === 'PARTIAL') return { label: 'Nộp một phần', color: 'var(--orange)' };
    if (s === 'UNPAID')  return { label: 'Chưa nộp', color: 'var(--red)' };
    return { label: s, color: 'var(--text-light)' };
  };

  const totalAmount = rows.reduce((s, r) => s + Number(r.totalAmount || 0), 0);
  const totalPaid   = rows.reduce((s, r) => s + Number(r.paidAmount || 0), 0);
  const totalDebt   = totalAmount - totalPaid;

  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Tra cứu công nợ</div>
      </div>

      <div className="tabs">
        <div className={`tab-btn ${tab==='hp'?'active':''}`} onClick={()=>setTab('hp')}>Học phí</div>
      </div>

      {tab === 'hp' && (
        <div>
          <div className="card" style={{overflowX:'auto'}}>
            <table className="tbl" style={{minWidth:'700px'}}>
              <tbody>
                <tr>
                  <th>STT</th>
                  <th>Học kỳ</th>
                  <th style={{textAlign:'right'}}>Tổng học phí</th>
                  <th style={{textAlign:'right'}}>Đã nộp</th>
                  <th style={{textAlign:'right'}}>Còn nợ</th>
                  <th style={{textAlign:'center'}}>Hạn nộp</th>
                  <th style={{textAlign:'center'}}>Trạng thái</th>
                </tr>
                {loading && <tr><td colSpan="7" style={{textAlign:'center',padding:'20px',color:'var(--text-light)'}}>Đang tải...</td></tr>}
                {!loading && rows.length === 0 && (
                  <tr><td colSpan="7" style={{textAlign:'center',padding:'30px',color:'var(--text-light)'}}>Chưa có dữ liệu</td></tr>
                )}
                {rows.map((r, i) => {
                  const st = statusLabel(r.status);
                  const debt = Number(r.totalAmount || 0) - Number(r.paidAmount || 0);
                  return (
                    <tr key={r.invoiceId || i}>
                      <td>{i + 1}</td>
                      <td>{r.semesterName}</td>
                      <td style={{textAlign:'right'}}>{formatMoney(r.totalAmount)}</td>
                      <td style={{textAlign:'right',color:'var(--green)',fontWeight:600}}>{formatMoney(r.paidAmount)}</td>
                      <td style={{textAlign:'right',color: debt > 0 ? 'var(--red)' : undefined, fontWeight: debt > 0 ? 700 : undefined}}>
                        {formatMoney(debt)}
                      </td>
                      <td style={{textAlign:'center'}}>{r.dueDate ? new Date(r.dueDate).toLocaleDateString('vi-VN') : '—'}</td>
                      <td style={{textAlign:'center',fontWeight:600,color:st.color}}>{st.label}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
          {!loading && rows.length > 0 && (
            <div style={{padding:'12px 0',fontSize:'13px',display:'flex',gap:'24px',flexWrap:'wrap'}}>
              <span>Tổng học phí: <strong style={{color:'var(--text)'}}>{formatMoney(totalAmount)} đ</strong></span>
              <span>Đã nộp: <strong style={{color:'var(--green)'}}>{formatMoney(totalPaid)} đ</strong></span>
              <span>Tổng còn nợ: <strong style={{color: totalDebt > 0 ? 'var(--red)' : 'var(--green)'}}>{formatMoney(totalDebt)} đ</strong></span>
            </div>
          )}
        </div>
      )}
    </div>
  );
}