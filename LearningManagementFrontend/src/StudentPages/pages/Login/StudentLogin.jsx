import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import './StudentLogin.css';

export default function StudentLogin() {
  const [studentCode, setStudentCode] = useState('2001216301');
  const [password, setPassword] = useState('hash123');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const res = await axios.post('http://localhost:8080/api/auth/login', {
        userType: 'STUDENT',
        loginCode: studentCode,
        password: password
      });

      if (res.data && res.data.token) {
        localStorage.setItem('token', res.data.token);
        localStorage.setItem('user', JSON.stringify(res.data));
        navigate('/dashboard');
      } else {
        setError('Đăng nhập thất bại. Vui lòng thử lại.');
      }
    } catch (err) {
      setError(err.response?.data?.message || 'Tài khoản hoặc mật khẩu không chính xác.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="student-login-container">
      <div className="login-box">
        <div className="login-header">
          <div className="logo-placeholder">🎓</div>
          <h2>Cổng thông tin sinh viên</h2>
          <p>Đăng nhập để xem thời khóa biểu, điểm số và học phí</p>
        </div>

        <form onSubmit={handleLogin} className="login-form">
          <div className="form-group">
            <label>Mã số sinh viên</label>
            <input 
              type="text" 
              value={studentCode}
              onChange={(e) => setStudentCode(e.target.value)}
              placeholder="VD: 2001216301"
              required 
            />
          </div>

          <div className="form-group">
            <label>Mật khẩu</label>
            <input 
              type="password" 
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Nhập mật khẩu..."
              required 
            />
          </div>

          {error && <div className="error-message">{error}</div>}

          <button type="submit" className="btn-submit" disabled={loading}>
            {loading ? 'Đang xác thực...' : 'Đăng nhập vào hệ thống'}
          </button>
        </form>
      </div>
    </div>
  );
}
