import axios from 'axios';

const BASE_URL = 'http://localhost:8080/api/student';

// Lấy token từ localStorage (được lưu khi login)
const getHeaders = () => ({
  headers: {
    Authorization: `Bearer ${localStorage.getItem('token')}`,
  },
});

// ── PROFILE ─────────────────────────────────────────────────────────────────
export const getProfile = () =>
  axios.get(`${BASE_URL}/profile`, getHeaders()).then(res => res.data);

// ── WEEKLY SCHEDULE ──────────────────────────────────────────────────────────
// date: chuỗi 'YYYY-MM-DD' (tùy chọn, mặc định là tuần hiện tại)
export const getWeeklySchedule = (date) => {
  const params = date ? { date } : {};
  return axios.get(`${BASE_URL}/weekly-schedule`, { ...getHeaders(), params }).then(res => res.data);
};

// ── PROGRESS SCHEDULE ────────────────────────────────────────────────────────
// semesterId: số nguyên (tùy chọn, 0 = tất cả HK)
export const getProgressSchedule = (semesterId) => {
  const params = semesterId ? { semesterId } : {};
  return axios.get(`${BASE_URL}/progress-schedule`, { ...getHeaders(), params }).then(res => res.data);
};

// ── GRADES ───────────────────────────────────────────────────────────────────
export const getGrades = () =>
  axios.get(`${BASE_URL}/grades`, getHeaders()).then(res => res.data);

// ── ATTENDANCE ───────────────────────────────────────────────────────────────
export const getAttendance = () =>
  axios.get(`${BASE_URL}/attendance`, getHeaders()).then(res => res.data);

// ── CONDUCT ──────────────────────────────────────────────────────────────────
export const getConduct = () =>
  axios.get(`${BASE_URL}/conduct`, getHeaders()).then(res => res.data);

// ── TUITION ──────────────────────────────────────────────────────────────────
export const getTuition = () =>
  axios.get(`${BASE_URL}/tuition`, getHeaders()).then(res => res.data);

// ── NOTIFICATIONS ────────────────────────────────────────────────────────────
export const getNotifications = () =>
  axios.get(`${BASE_URL}/notifications`, getHeaders()).then(res => res.data);

// ── SURVEYS ──────────────────────────────────────────────────────────────────
export const getSurveys = () =>
  axios.get(`${BASE_URL}/surveys`, getHeaders()).then(res => res.data);

export const submitSurvey = (payload) =>
  axios.post(`${BASE_URL}/surveys`, payload, getHeaders()).then(res => res.data);

