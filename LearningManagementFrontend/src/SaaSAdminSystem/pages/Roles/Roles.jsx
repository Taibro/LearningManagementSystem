import React from 'react';

export default function Roles() {
  return (
    <div>
      <h1 style={{ fontSize: '20px', fontWeight: 800, marginBottom: '20px' }}>Vai trò & Phân quyền</h1>
      <div className="card">
        <div className="card-body">
          <table className="data-table">
            <thead>
              <tr><th>ID</th><th>Tên vai trò</th><th>Mô tả</th><th>Số người dùng</th></tr>
            </thead>
            <tbody>
              <tr><td>1</td><td><span className="badge badge-red">admin</span></td><td>Quản trị viên hệ thống</td><td>1</td></tr>
              <tr><td>2</td><td><span className="badge badge-purple">teacher</span></td><td>Giảng viên</td><td>3</td></tr>
              <tr><td>3</td><td><span className="badge badge-cyan">student</span></td><td>Sinh viên / Học sinh</td><td>3</td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}