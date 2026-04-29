import React from 'react';

export default function CTKhung() { 
  return (
    <div className="page active">
      <div className="page-title">Chương trình khung</div>
      <div className="card" style={{overflowX:'auto'}}>
        <table className="tbl" style={{minWidth:'800px'}}>
          <tbody>
            <tr><th>STT</th><th>Tên môn học/Học phần</th><th>Mã Học phần</th><th>Học phần</th><th>Số TC</th><th>Số tiết LT</th><th>Số tiết TH</th><th>Nhóm tự chọn</th><th>Số TC bắt buộc của nhóm</th><th>Đạt</th></tr>
            <tr className="section-row"><td colSpan="10">Học phần bắt buộc &nbsp;&nbsp;&nbsp; <strong>12 TC</strong></td></tr>
            <tr><td>1</td><td>Nhập môn Big Data</td><td>0101101971</td><td></td><td>2</td><td>30</td><td>0</td><td>0</td><td></td><td></td></tr>
            <tr><td>2</td><td>Thực hành nhập môn Big data</td><td>0101101972</td><td></td><td>1</td><td>0</td><td>30</td><td>0</td><td></td><td></td></tr>
            <tr><td>3</td><td>Internet of Things</td><td>0101101975</td><td></td><td>3</td><td>45</td><td>0</td><td>0</td><td></td><td></td></tr>
            <tr className="red-row"><td>4</td><td>Thực tập nghề nghiệp</td><td>0101102007</td><td></td><td>2</td><td>0</td><td>60</td><td>0</td><td></td><td></td></tr>
            <tr className="red-row"><td>5</td><td>Khóa luận cử nhân</td><td>0101102008</td><td></td><td>4</td><td>0</td><td>0</td><td>0</td><td></td><td></td></tr>
            <tr className="section-row"><td colSpan="10">Học phần tự chọn &nbsp;&nbsp;&nbsp; <strong>4 TC</strong></td></tr>
            <tr><td>6</td><td>Lập trình mã nguồn mở</td><td>0101101978</td><td></td><td>2</td><td>0</td><td>60</td><td>1</td><td>4</td><td></td></tr>
            <tr><td>7</td><td>Dữ liệu NoSQL</td><td>0101101981</td><td></td><td>2</td><td>0</td><td>60</td><td>1</td><td>4</td><td></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  ); 
}