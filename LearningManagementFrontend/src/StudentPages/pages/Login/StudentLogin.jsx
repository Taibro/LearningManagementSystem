import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import './StudentLogin.css';

export default function StudentLogin() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [school, setSchool] = useState('');
  
  const [errorEmail, setErrorEmail] = useState(false);
  const [errorPass, setErrorPass] = useState(false);
  const [errorSchool, setErrorSchool] = useState(false);
  const [generalError, setGeneralError] = useState('');
  
  const [showPass, setShowPass] = useState(false);
  const [rememberMe, setRememberMe] = useState(false);
  const [loading, setLoading] = useState(false);
  const [shake, setShake] = useState(false);
  const [showSuccess, setShowSuccess] = useState(false);
  const [progressWidth, setProgressWidth] = useState('0%');

  const navigate = useNavigate();

  const handleLogin = async () => {
    let hasError = false;
    
    if (!email.trim()) { setErrorEmail(true); hasError = true; } else { setErrorEmail(false); }
    if (!password) { setErrorPass(true); hasError = true; } else { setErrorPass(false); }
    if (!school) { setErrorSchool(true); hasError = true; } else { setErrorSchool(false); }
    
    setGeneralError('');

    if (hasError) {
      setShake(true);
      setTimeout(() => setShake(false), 350);
      return;
    }

    setLoading(true);

    try {
      const res = await axios.post('http://localhost:8080/api/auth/login', {
        userType: 'STUDENT',
        loginCode: email.trim(),
        password: password
      });

      if (res.data && res.data.token) {
        localStorage.setItem('token', res.data.token);
        localStorage.setItem('user', JSON.stringify(res.data));
        
        setShowSuccess(true);
        setTimeout(() => setProgressWidth('100%'), 50);
        
        setTimeout(() => {
          navigate('/dashboard');
        }, 2500);
      } else {
        setGeneralError('Đăng nhập thất bại. Vui lòng thử lại.');
        setLoading(false);
      }
    } catch (err) {
      setGeneralError(err.response?.data?.message || 'Tài khoản hoặc mật khẩu không chính xác.');
      setLoading(false);
    }
  };

  return (
    <div className="student-login-body">
      <div className="sl-layout">
        {/* ══════════ LEFT ══════════ */}
        <div className="sl-left">
          <div className="sl-blob sl-blob-1"></div>
          <div className="sl-blob sl-blob-2"></div>
          <div className="sl-blob sl-blob-3"></div>

          <div className="logo-wrap sl-fl">
            <div className="logo-icon">E</div>
            <div>
              <div className="logo-text">EduSpace</div>
              <div className="logo-sub">Student Portal</div>
            </div>
          </div>

          <div style={{ position: 'relative', zIndex: 1 }}>
            <div className="badge-student sl-fl d1" style={{ marginBottom: '24px' }}>
              <span className="badge-dot"></span>
              CỔNG SINH VIÊN
            </div>
            <h1 className="headline sl-fl d2">
              Học tập.<br />
              <span className="accent">Phát triển</span><br />
              toàn diện.
            </h1>
            <div style={{ width: '40px', height: '3px', background: 'rgba(167,139,250,.5)', borderRadius: '2px', margin: '22px 0' }} className="sl-fl d3"></div>
            <p className="desc sl-fl d3">Xem lịch học, đăng ký môn học, tra cứu điểm số và nhận thông báo từ giảng viên mọi lúc mọi nơi.</p>

            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginTop: '28px' }} className="sl-fl d4">
              <div className="feature-chip">
                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2.5" d="M5 13l4 4L19 7" /></svg>
                Lịch học cá nhân
              </div>
              <div className="feature-chip">
                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2.5" d="M5 13l4 4L19 7" /></svg>
                Đăng ký môn học
              </div>
              <div className="feature-chip">
                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2.5" d="M5 13l4 4L19 7" /></svg>
                Tra cứu điểm số
              </div>
              <div className="feature-chip">
                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2.5" d="M5 13l4 4L19 7" /></svg>
                Tài liệu học tập
              </div>
              <div className="feature-chip">
                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2.5" d="M5 13l4 4L19 7" /></svg>
                Học phí & Học bổng
              </div>
            </div>
          </div>

          <div style={{ display: 'flex', gap: '16px', position: 'relative', zIndex: 1 }} className="sl-fl d5">
            <div className="stat-box"><div className="stat-num">62,840</div><div className="stat-lbl">Sinh viên</div></div>
            <div className="stat-box"><div className="stat-num">38</div><div className="stat-lbl">Trường / TT</div></div>
            <div className="stat-box"><div className="stat-num">4.8★</div><div className="stat-lbl">Đánh giá</div></div>
          </div>
        </div>

        {/* ══════════ RIGHT ══════════ */}
        <div className="sl-right">
          <div className={`success-wrap ${showSuccess ? 'show' : ''}`} id="success">
            <div className="success-icon-wrap">📚</div>
            <div className="success-title">Chào mừng trở lại!</div>
            <div className="success-sub">Đang chuyển đến trang Sinh viên...</div>
            <div className="progress-bar"><div className="progress-fill" style={{ width: progressWidth, transition: 'width 2s ease' }}></div></div>
          </div>

          <a href="/login-giang-vien.html" className="back-btn sl-fu" style={{ marginBottom: 'auto' }}>
            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" /></svg>
            Cổng Giảng viên
          </a>

          <div className="form-section" style={{ margin: 'auto 0' }}>
            <div className="sl-fu d1">
              <h2 className="form-title">Đăng nhập<br />Sinh viên</h2>
              <p className="form-sub">Nhập thông tin tài khoản được cấp bởi nhà trường</p>
            </div>
            <div className="hr-line sl-fu d2"></div>

            {/* Mã SV */}
            <div className="sl-fu d2">
              <label className="lbl">Mã sinh viên / Email</label>
              <div className="field">
                <svg className="field-ico" style={{ color: '#94A3B8' }} fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
                <input
                  className="inp"
                  type="text"
                  placeholder="21IT001 hoặc sv@truong.edu.vn"
                  autoComplete="username"
                  value={email}
                  onChange={(e) => { setEmail(e.target.value); setErrorEmail(false); }}
                />
              </div>
              <div className={`err-msg ${errorEmail ? 'on' : ''}`}>Vui lòng nhập mã sinh viên hoặc email</div>
            </div>

            {/* Mật khẩu */}
            <div className="sl-fu d3">
              <label className="lbl">Mật khẩu</label>
              <div className="field">
                <svg className="field-ico" style={{ color: '#94A3B8' }} fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                <input
                  className="inp inp-pass"
                  type={showPass ? 'text' : 'password'}
                  placeholder="••••••••••••"
                  autoComplete="current-password"
                  value={password}
                  onChange={(e) => { setPassword(e.target.value); setErrorPass(false); }}
                />
                <button className="eye-btn" onClick={() => setShowPass(!showPass)} type="button" style={{ color: showPass ? '#475569' : '#94A3B8' }}>
                  <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                </button>
              </div>
              <div className={`err-msg ${errorPass ? 'on' : ''}`}>Mật khẩu không được để trống</div>
            </div>

            {/* Chọn trường */}
            <div className="sl-fu d3">
              <label className="lbl">Trường / Trung tâm</label>
              <div className="field select-wrap">
                <svg className="field-ico" style={{ color: '#94A3B8' }} fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0H5m9-7h-4" /></svg>
                <select
                  className="inp inp-select"
                  value={school}
                  onChange={(e) => { setSchool(e.target.value); setErrorSchool(false); }}
                >
                  <option value="">-- Chọn trường của bạn --</option>
                  <option value="HUIT">ĐH Bách Khoa TP.HCM</option>
                  <option value="NEU">ĐH Kinh tế Quốc dân</option>
                  <option value="FPT">CĐ FPT Polytechnic</option>
                  <option value="IELTS">TT Ngoại ngữ IELTS Pro</option>
                  <option value="LHP">THPT Chuyên Lê Hồng Phong</option>
                </select>
                <svg className="select-arrow" width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 9l-7 7-7-7" /></svg>
              </div>
              <div className={`err-msg ${errorSchool ? 'on' : ''}`}>Vui lòng chọn trường của bạn</div>
            </div>

            {/* General Error Message */}
            {generalError && <div className="err-general sl-fu d3">{generalError}</div>}

            {/* 2FA */}
            <div className="tfa-row sl-fu d3">
              <div className="tfa-left">
                <div className="tfa-icon">🔒</div>
                <div>
                  <div className="tfa-title">Xác thực 2 bước (2FA)</div>
                  <div className="tfa-desc">Bảo vệ tài khoản sinh viên</div>
                </div>
              </div>
              <label className="toggle-switch">
                <input type="checkbox" />
                <span className="slider"></span>
              </label>
            </div>

            {/* Remember / Forgot */}
            <div className="row-mid sl-fu d4">
              <div className="check-row" onClick={() => setRememberMe(!rememberMe)}>
                <div className={`custom-cb ${rememberMe ? 'on' : ''}`}></div>
                <span className="cb-lbl">Ghi nhớ đăng nhập</span>
              </div>
              <a href="#" className="forgot">Quên mật khẩu?</a>
            </div>

            {/* Submit */}
            <button className={`btn-login sl-fu d4 ${loading ? 'loading' : ''} ${shake ? 'shake' : ''}`} onClick={handleLogin} disabled={loading}>
              <span className="btn-txt">Đăng nhập ngay</span>
              <div className="spinner">
                <div className="spin"></div>
                <span style={{ fontSize: '13px' }}>Đang xác thực...</span>
              </div>
            </button>

            <div className="divider sl-fu d5">hoặc tiếp tục với</div>

            <button className="btn-sso sl-fu d5" onClick={() => alert('Redirect đến Google Workspace của trường')}>
              <svg width="17" height="17" viewBox="0 0 48 48"><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z" /><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z" /><path fill="#FBBC05" d="M10.53 28.59c-.5-1.45-.79-3-.79-4.59s.29-3.14.79-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z" /><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.97 6.19C12.43 13.72 17.74 9.5 24 9.5z" /></svg>
              Tiếp tục với Google Workspace
            </button>

            <p className="form-footer sl-fu d6">
              Giảng viên? <a href="/lecturer/login">Đăng nhập tại đây →</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
