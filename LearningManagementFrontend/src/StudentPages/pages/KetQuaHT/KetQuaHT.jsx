import React from 'react';

export default function KetQuaHT() {
  return (
    <div className="page active">
      <div className="page-title-bar">
        <div className="page-title" style={{margin:0}}>Kết quả học tập</div>
        <button className="btn btn-blue" onClick={() => alert('Đang tính toán...')}>Xét thử TN</button>
      </div>

      <div className="card" style={{marginBottom:'16px'}}>
        <div style={{background:'#fffde7',padding:'10px 16px',fontWeight:700,color:'#b45309',fontSize:'13px',borderBottom:'1px solid var(--border)'}}>CHUẨN ĐẦU RA</div>
        <table className="tbl">
          <tbody>
            <tr><th>STT</th><th>Loại chứng chỉ</th><th>Theo quy định</th><th>Đã nộp</th><th>Xác nhận</th></tr>
            <tr><td>1</td><td>Chuẩn năng lực Ngoại ngữ</td><td>NN_Tương đương Bậc 3 theo khung NL 6 bậc của VN</td><td></td><td style={{color:'#e85d75'}}>Chưa hoàn tất</td></tr>
            <tr><td>2</td><td>Chứng chỉ Giáo dục nghề nghiệp...</td><td>CC Giáo dục nghề nghiệp và Công tác Xã hội</td><td>CC Giáo dục nghề nghiệp...</td><td style={{color:'var(--green)'}}>Hoàn tất</td></tr>
            <tr><td>3</td><td>Đánh giá chuẩn đầu ra chương trình...</td><td>Chuẩn đầu ra chương trình đào tạo ĐH</td><td></td><td style={{color:'#e85d75'}}>Chưa hoàn tất</td></tr>
            <tr><td>4</td><td>Đối chiếu bằng</td><td>Đối chiếu bằng tốt nghiệp THPT, hoặc CĐ</td><td>Đối chiếu bằng tốt nghiệp...</td><td style={{color:'var(--green)'}}>Hoàn tất</td></tr>
          </tbody>
        </table>
      </div>

      <div className="card" style={{marginBottom:'16px',overflowX:'auto'}}>
        <table className="tbl" style={{minWidth:'900px'}}>
          <tbody>
            <tr>
              <th rowSpan="3">STT</th><th rowSpan="3">Mã môn học</th><th rowSpan="3">Tên môn học/học phần</th>
              <th rowSpan="3">Lớp dự kiến</th><th rowSpan="3">Số TC</th>
              <th colSpan="2" style={{textAlign:'center'}}>Giữa kỳ</th><th colSpan="5" style={{textAlign:'center'}}>Thường xuyên LT Hệ số 1</th>
              <th colSpan="2" style={{textAlign:'center'}}>TL/BTL</th><th rowSpan="3">TB thực</th>
            </tr>
            <tr>
              <th style={{textAlign:'center'}}>1</th><th style={{textAlign:'center'}}>2</th>
              <th style={{textAlign:'center'}}>1</th><th style={{textAlign:'center'}}>6</th><th style={{textAlign:'center'}}>7</th><th style={{textAlign:'center'}}>8</th><th style={{textAlign:'center'}}>9</th>
              <th style={{textAlign:'center'}}>Tiểu luận 1</th><th style={{textAlign:'center'}}>Tiểu luận 2</th>
            </tr>
            <tr><th colSpan="10"></th></tr>
            <tr><td>1</td><td>101966</td><td>Ảo hóa và điện toán đám mây</td><td>14DHBM01</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>9,10</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>9,1</td></tr>
            <tr><td>2</td><td>101963</td><td>Công nghệ phần mềm</td><td>14DHTH15</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>8,80</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>8,8</td></tr>
            <tr><td>3</td><td>101968</td><td>Hệ quản trị cơ sở dữ liệu</td><td>14DHTH06</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>9,20</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>9,2</td></tr>
            <tr><td>4</td><td>101979</td><td>Xử lý ảnh</td><td>14DHTH15</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>8,40</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>8,4</td></tr>
            <tr><td>5</td><td>006237</td><td>Trí tuệ nhân tạo</td><td>14DHTH06</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>8,70</td><td></td><td style={{fontWeight:700,color:'var(--blue)'}}>8,7</td></tr>
            <tr><td>6</td><td>002921</td><td>Lập trình web</td><td>14DHTH03</td><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td style={{textAlign:'center'}}>10,00</td><td></td><td style={{fontWeight:700,color:'var(--green)'}}>10,0</td></tr>
          </tbody>
        </table>
      </div>

      <div className="card" style={{marginBottom:'16px'}}>
        <div className="card-body">
          <div style={{display:'flex',gap:'20px',fontSize:'13px',flexWrap:'wrap'}}>
            <div>Điểm TB học kỳ hệ 10: <strong style={{color:'var(--blue)'}}>8,87</strong></div>
            <div>Điểm TB học kỳ hệ 4: <strong style={{color:'var(--blue)'}}>3,92</strong></div>
            <div>Điểm TB tích lũy: <strong style={{color:'var(--blue)'}}>8,29</strong></div>
            <div>Điểm TB tích lũy (hệ 4): <strong style={{color:'var(--blue)'}}>3,54</strong></div>
            <div>Tổng số tín chỉ tích lũy: <strong style={{color:'var(--blue)'}}>85</strong></div>
            <div>Xử lý học vụ: <strong>Học tiếp</strong></div>
          </div>
        </div>
      </div>

      <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:0}}>
        <div className="card" style={{borderRight:'none',borderRadius:'8px 0 0 8px'}}>
          <div className="card-body">
            <h4 style={{fontSize:'13px',fontWeight:700,marginBottom:'8px'}}>Tính theo thực học</h4>
            <div style={{display:'grid',gridTemplateColumns:'1fr auto',gap:'4px',fontSize:'13px'}}>
              <span>Tổng tín chỉ:</span><strong>119</strong>
              <span>Trung bình chung tích lũy:</span><strong>8,25 - 3,51</strong>
              <span>Xếp loại tốt nghiệp:</span><strong></strong>
            </div>
          </div>
        </div>
        <div className="card" style={{borderRadius:'0 8px 8px 0'}}>
          <div className="card-body">
            <h4 style={{fontSize:'13px',fontWeight:700,marginBottom:'8px'}}>Tính theo chương trình khung</h4>
            <div style={{display:'grid',gridTemplateColumns:'1fr auto',gap:'4px',fontSize:'13px'}}>
              <span>Tổng tín chỉ:</span><strong>88</strong>
              <span>Trung bình chung tích lũy:</span><strong>8,25 - 3,51</strong>
              <span>Số tín chỉ phải tích lũy:</span><strong style={{color:'var(--red)'}}>151</strong>
            </div>
          </div>
        </div>
      </div>
      <div style={{fontSize:'12px',color:'var(--red)',marginTop:'10px',padding:'10px',background:'#fff',borderRadius:'6px',border:'1px solid var(--border)'}}>
        <strong>Ghi chú:</strong> Điểm Giáo dục quốc phòng - an ninh 1, Giáo dục thể chất 1 (võ thuật)... không tính vào Trung bình chung tích lũy
      </div>
    </div>
  );
}