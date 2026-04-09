import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './ScheduleProgress.css';

const ScheduleProgressPage = () => {
    const [courseData, setCourseData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [isCollapsed, setIsCollapsed] = useState(false);
    const [showUserMenu, setShowUserMenu] = useState(false); // Trạng thái hiện Popup đăng xuất

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Link API kết nối với Backend của bạn Tài
                const response = await axios.get('http://localhost:8080/api/classes/1/progress');
                setCourseData(response.data);
            } catch (error) {
                console.error("API chưa sẵn sàng - Đang hiển thị trạng thái chờ");
            }
            setLoading(false);
        };
        fetchData();
    }, []);

    const menuItems = [
        { name: "Quản lý kết quả học tập", active: false },
        { name: "Lịch theo tiến độ", active: true },
        { name: "Lịch theo tuần", active: false },
        { name: "Đề xuất tạm ngừng dạy", active: false },
        { name: "Đề xuất dạy bù", active: false },
        { name: "Đề xuất dạy thay", active: false },
        { name: "Thống kê thực giảng", active: false },
        { name: "Khảo sát", active: false },
        { name: "Cài đặt hệ thống", active: false }
    ];

    return (
        <div className="huit-layout">

            <div className="huit-sidebar" style={{ width: isCollapsed ? '60px' : '260px' }}>
                <div className="huit-logo">
                    {!isCollapsed && (
                        <div>
                            <strong>HUIT</strong><br/>
                            <small style={{fontSize: '9px'}}>University of Industry and Trade</small>
                        </div>
                    )}
                    <button onClick={() => setIsCollapsed(!isCollapsed)} className="btn-toggle">☰</button>
                </div>

                <div className="huit-sidebar-content">
                    {menuItems.map((item, index) => (
                        <div key={index} className={`huit-menu-item ${item.active ? 'active' : ''}`}>
                            <span style={{minWidth: '20px'}}>●</span>
                            {!isCollapsed && <span>{item.name}</span>}
                        </div>
                    ))}
                </div>
            </div>

            {/* PHẦN CHÍNH */}
            <div className="huit-main">
                <div className="huit-navbar">
                    <div className="breadcrumb">Dashboard / <strong>Lịch theo tiến độ</strong></div>

                   {/*Pop up*/}
                    <div
                        className="user-profile-wrapper"
                        onMouseEnter={() => setShowUserMenu(true)}
                        onMouseLeave={() => setShowUserMenu(false)}
                    >
                        <div className="user-info">
                            <div className="user-text">
                                <strong>Nguyễn Văn A</strong><br/>
                                <small>Giảng viên</small>
                            </div>
                            <div className="avatar">GV</div>
                        </div>

                        {/* POPUP ĐĂNG XUẤT */}
                        {showUserMenu && (
                            <div className="user-popup-simple">
                                <div className="popup-item">Hồ sơ cá nhân</div>
                                <div className="popup-divider"></div>
                                <div className="popup-item logout">Đăng xuất</div>
                            </div>
                        )}
                    </div>
                </div>

                <div className="huit-content-area">
                    <h2>Lịch theo tiến độ</h2>
                    <p className="page-sub-title">Xem tiến độ giảng dạy theo từng môn học</p>

                    <div className="huit-filter-bar">
                        <div className="filter-item">
                            <label>Học kỳ</label>
                            <select className="huit-select">
                                <option>HK2 - 2025-2026</option>
                            </select>
                        </div>
                        <div className="filter-item">
                            <label>Môn học</label>
                            <select className="huit-select">
                                <option>Tất cả môn học</option>
                            </select>
                        </div>
                        <button className="btn-view-progress">
                            <span className="dot-cyan"></span> Xem tiến độ
                        </button>
                    </div>

                    {loading ? (
                        <div className="msg-box">Đang kết nối hệ thống...</div>
                    ) : !courseData ? (
                        <div className="msg-box">
                             <p>Không tìm thấy dữ liệu môn học.</p>

                        </div>
                    ) : (
                        <div className="progress-card">
                            <div className="card-header">
                                <h3>{courseData.courseName}</h3>
                                <span className="badge-status">Đang dạy</span>
                            </div>
                            <p className="course-code-text">{courseData.courseCode} | {courseData.totalSessions} tiết</p>

                            <div className="huit-progress-bar-container">
                                <div className="huit-progress-bar-fill" style={{width: `${courseData.progressPercent}%`}}></div>
                                <span className="percent-label">{courseData.progressPercent}%</span>
                            </div>

                            <p className="summary-text">
                                Đã dạy: <strong>{courseData.completedSessions}/{courseData.totalSessions}</strong> tiết |
                                Còn lại: <strong>{courseData.totalSessions - courseData.completedSessions}</strong> tiết
                            </p>

                            <div className="chapters-footer">
                                {courseData.chapters && courseData.chapters.map((chap, index) => (
                                    <div key={index} className="chapter-tag">
                                        {chap.name}: <span className={chap.isDone ? 'txt-done' : 'txt-ongoing'}>{chap.status}</span>
                                    </div>
                                ))}
                            </div>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default ScheduleProgressPage;