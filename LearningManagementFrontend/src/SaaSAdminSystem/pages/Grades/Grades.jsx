import React from 'react';
import { GraduationCap, CheckCircle2, Search, Filter, Download, ChevronDown, BookOpen, Edit, Trash2, XCircle, Award, Target } from 'lucide-react';
import './Grades.css';

export default function Grades() {
    const gradeList = [
        {
            id: 'KQ_0192',
            studentName: 'Trần Tấn Phát',
            studentCode: '2001230638',
            subject: 'Công nghệ Java',
            credits: 3,
            midtermScore: 8.5,
            finalScore: 9.0,
            totalScore: 8.8,
            status: 'passed'
        },
        {
            id: 'KQ_0193',
            studentName: 'Nguyễn Văn Đức',
            studentCode: '21IT001',
            subject: 'Cấu trúc dữ liệu',
            credits: 3,
            midtermScore: 4.0,
            finalScore: 3.5,
            totalScore: 3.7,
            status: 'failed'
        },
        {
            id: 'KQ_0194',
            studentName: 'Hoàng Thị Lan',
            subject: 'Cơ sở dữ liệu',
            studentCode: '21IT002',
            credits: 4,
            midtermScore: 7.0,
            finalScore: 8.0,
            totalScore: 7.6,
            status: 'passed'
        }
    ];

    const renderStatus = (status) => {
        if (status === 'passed') {
            return (
                <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-950/80 text-emerald-400 border border-emerald-900/50">
                    <CheckCircle2 className="w-4 h-4" /> Đạt
                </span>
            );
        }
        if (status === 'failed') {
            return (
                <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-rose-950/80 text-rose-400 border border-rose-900/50">
                    <XCircle className="w-4 h-4" /> Không đạt
                </span>
            );
        }
        return null;
    };

    const getScoreColor = (score) => {
        if (score >= 8.0) return 'text-emerald-400';
        if (score >= 5.0) return 'text-blue-400';
        return 'text-rose-500';
    };

    const totalRecords = gradeList.length;
    const passedCount = gradeList.filter(g => g.status === 'passed').length;
    const failedCount = gradeList.filter(g => g.status === 'failed').length;

    const averageTotal = (gradeList.reduce((acc, curr) => acc + curr.totalScore, 0) / totalRecords).toFixed(1);

    const summaryCards = [
        { title: "Tổng lượt nhập điểm", value: totalRecords, color: "text-indigo-400", icon: <BookOpen className="w-6 h-6 text-indigo-500/50 absolute right-6 top-8" /> },
        { title: "Tỷ lệ Đạt", value: passedCount, color: "text-emerald-400", icon: <CheckCircle2 className="w-6 h-6 text-emerald-500/50 absolute right-6 top-8" /> },
        { title: "Tỷ lệ Không đạt", value: failedCount, color: "text-rose-500", icon: <XCircle className="w-6 h-6 text-rose-500/50 absolute right-6 top-8" /> },
        { title: "Điểm trung bình chung", value: isNaN(averageTotal) ? "0.0" : averageTotal, color: "text-amber-400", icon: <Target className="w-6 h-6 text-amber-500/50 absolute right-6 top-8" /> }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <GraduationCap className="w-7 h-7 text-indigo-400" />
                        </div>
                        Kết quả học tập
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Quản lý điểm số và tiến độ học tập của sinh viên</p>
                </div>

                <div className="flex items-center gap-3">
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        Học kỳ 2 (2025-2026)
                        <ChevronDown className="w-4 h-4 text-slate-500" />
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                {summaryCards.map((card, index) => (
                    <div
                        key={index}
                        className="invoice-summary-card bg-[#151a26] rounded-2xl border border-slate-800 relative group flex flex-col justify-center transition-all duration-300 hover:-translate-y-1 hover:border-slate-600 hover:shadow-lg hover:shadow-black/20"
                    >
                        <div className="text-sm font-medium text-slate-400 mb-2 relative z-10">{card.title}</div>
                        <div className={`invoice-summary-value text-3xl lg:text-4xl font-extrabold ${card.color} pt-1 pb-3 leading-relaxed tracking-tight relative z-10`}>
                            {card.value}
                        </div>
                        {card.icon}
                        <div className="w-24 h-24 bg-slate-800/40 rounded-full absolute -right-6 -top-6 pointer-events-none group-hover:bg-slate-700/30 transition-colors z-0"></div>
                    </div>
                ))}
            </div>

            <div className="flex items-center justify-between mb-6">
                <div className="flex items-center w-full max-w-md bg-[#151a26] border border-slate-700/50 rounded-xl focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500 transition-all shadow-sm">
                    <input
                        type="text"
                        placeholder="Tìm kiếm MSSV, Mã học phần..."
                        className="flex-1 px-5 py-3 bg-transparent text-slate-200 text-sm focus:outline-none placeholder-slate-500"
                    />
                    <button className="px-5 py-3 text-slate-400 hover:text-indigo-400 hover:bg-slate-800/50 border-l border-slate-700/50 rounded-r-xl transition-colors">
                        <Search className="w-5 h-5" />
                    </button>
                </div>

                <div className="flex items-center gap-3">
                    <button className="p-3 bg-[#151a26] border border-slate-800 text-slate-400 rounded-xl hover:text-white hover:bg-slate-800 transition-colors shadow-sm" title="Lọc">
                        <Filter className="w-5 h-5" />
                    </button>
                    <button className="flex items-center gap-2 px-4 py-3 bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl font-medium transition-colors shadow-sm">
                        + Nhập điểm
                    </button>
                </div>
            </div>

            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th className="px-5 py-6 first:pl-8">Sinh viên</th>
                                <th className="px-5 py-6">Môn học</th>
                                <th className="px-5 py-6 text-center">Tín chỉ</th>
                                <th className="px-5 py-6 text-right">Quá trình</th>
                                <th className="px-5 py-6 text-right">Thi</th>
                                <th className="px-5 py-6 text-right">Tổng kết</th>
                                <th className="px-5 py-6 text-center">Kết quả</th>
                                <th className="px-5 py-6 text-right last:pr-8">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {gradeList.map((grade) => (
                                <tr key={grade.id} className="hover:bg-slate-800/40 transition-colors group">
                                    <td className="px-5 py-7 first:pl-8">
                                        <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit">
                                            {grade.studentName}
                                        </div>
                                        <div className="text-xs font-mono text-slate-500 mt-1.5">{grade.studentCode}</div>
                                    </td>
                                    <td className="px-5 py-7">
                                        <div className="text-sm font-bold text-slate-200 flex items-center gap-2">
                                            <Award className="w-4 h-4 text-indigo-400" />
                                            {grade.subject}
                                        </div>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="text-sm font-medium text-slate-300">{grade.credits}</span>
                                    </td>
                                    <td className="px-5 py-7 text-sm font-bold text-slate-300 text-right">
                                        {grade.midtermScore.toFixed(1)}
                                    </td>
                                    <td className="px-5 py-7 text-sm font-bold text-slate-300 text-right">
                                        {grade.finalScore.toFixed(1)}
                                    </td>
                                    <td className={`px-5 py-7 text-sm font-extrabold text-right ${getScoreColor(grade.totalScore)}`}>
                                        {grade.totalScore.toFixed(1)}
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <div className="flex justify-center">
                                            {renderStatus(grade.status)}
                                        </div>
                                    </td>
                                    <td className="px-5 py-7 text-right last:pr-8">
                                        <div className="flex items-center justify-end gap-3">
                                            <button className="text-slate-500 hover:text-indigo-400 transition-colors" title="Chỉnh sửa">
                                                <Edit className="w-4 h-4" />
                                            </button>
                                            <button className="text-slate-500 hover:text-rose-400 transition-colors" title="Xóa">
                                                <Trash2 className="w-4 h-4" />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}