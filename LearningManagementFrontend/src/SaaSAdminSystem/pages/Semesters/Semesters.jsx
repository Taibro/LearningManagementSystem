import React from 'react';
import { CalendarDays, CheckCircle2, Search, Filter, Download, ChevronDown, PlayCircle, Clock3, Edit, Trash2, CalendarRange } from 'lucide-react';
import './Semesters.css';

export default function Semesters() {
    // 1. MOCK DATA HỌC KỲ
    const semesterList = [
        {
            id: 'HK1_2526',
            name: 'Học kỳ 1',
            schoolYear: '2025-2026',
            startDate: '05/09/2025',
            endDate: '15/01/2026',
            status: 'completed'
        },
        {
            id: 'HK2_2526',
            name: 'Học kỳ 2',
            schoolYear: '2025-2026',
            startDate: '15/02/2026',
            endDate: '30/06/2026',
            status: 'active'
        },
        {
            id: 'HK3_2526',
            name: 'Học kỳ Hè',
            schoolYear: '2025-2026',
            startDate: '10/07/2026',
            endDate: '25/08/2026',
            status: 'upcoming'
        }
    ];

    const renderStatus = (status) => {
        switch (status) {
            case 'completed':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-slate-800/80 text-slate-400 border border-slate-700/50">
                        <CheckCircle2 className="w-4 h-4" /> Đã kết thúc
                    </span>
                );
            case 'active':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-950/80 text-emerald-400 border border-emerald-900/50">
                        <PlayCircle className="w-4 h-4" /> Đang diễn ra
                    </span>
                );
            case 'upcoming':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-amber-950/80 text-amber-400 border border-amber-900/50">
                        <Clock3 className="w-4 h-4" /> Sắp tới
                    </span>
                );
            default:
                return null;
        }
    };

    // 2. TÍNH TOÁN DATA CHO SUMMARY CARDS
    const totalSemesters = semesterList.length;
    const activeSemester = semesterList.find(s => s.status === 'active');
    const completedCount = semesterList.filter(s => s.status === 'completed').length;
    const upcomingCount = semesterList.filter(s => s.status === 'upcoming').length;

    const summaryCards = [
        { title: "Tổng số Học kỳ", value: totalSemesters, color: "text-indigo-400", icon: <CalendarDays className="w-6 h-6 text-indigo-500/50 absolute right-6 top-8" /> },
        { title: "Đang diễn ra", value: activeSemester ? activeSemester.name : "Không có", color: "text-emerald-400", icon: <PlayCircle className="w-6 h-6 text-emerald-500/50 absolute right-6 top-8" /> },
        { title: "Đã hoàn thành", value: completedCount, color: "text-slate-400", icon: <CheckCircle2 className="w-6 h-6 text-slate-500/50 absolute right-6 top-8" /> },
        { title: "Sắp tới", value: upcomingCount, color: "text-amber-400", icon: <Clock3 className="w-6 h-6 text-amber-500/50 absolute right-6 top-8" /> }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">
            {/* Page Title Area */}
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <CalendarDays className="w-7 h-7 text-indigo-400" />
                        </div>
                        Quản lý Học kỳ
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Cấu hình thời gian và trạng thái các học kỳ trong năm học</p>
                </div>

                <div className="flex items-center gap-3">
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        Năm học 2025-2026
                        <ChevronDown className="w-4 h-4 text-slate-500" />
                    </div>
                </div>
            </div>

            {/* Summary Cards */}
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

            {/* Toolbar */}
            <div className="flex items-center justify-between mb-6">
                <div className="flex items-center w-full max-w-md bg-[#151a26] border border-slate-700/50 rounded-xl focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500 transition-all shadow-sm">
                    <input
                        type="text"
                        placeholder="Tìm kiếm mã học kỳ, tên học kỳ..."
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
                        + Tạo Học kỳ mới
                    </button>
                </div>
            </div>

            {/* Data Table */}
            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th className="px-5 py-6 first:pl-8">Mã HK</th>
                                <th className="px-5 py-6">Tên Học Kỳ</th>
                                <th className="px-5 py-6 text-center">Năm học</th>
                                <th className="px-5 py-6 text-center">Ngày bắt đầu</th>
                                <th className="px-5 py-6 text-center">Ngày kết thúc</th>
                                <th className="px-5 py-6 text-center">Trạng thái</th>
                                <th className="px-5 py-6 text-right last:pr-8">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {semesterList.map((semester) => (
                                <tr key={semester.id} className="hover:bg-slate-800/40 transition-colors group">
                                    <td className="px-5 py-7 first:pl-8">
                                        <span className="text-sm font-bold text-slate-400 group-hover:text-indigo-400 transition-colors">{semester.id}</span>
                                    </td>
                                    <td className="px-5 py-7">
                                        <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit flex items-center gap-2">
                                            <CalendarRange className="w-4 h-4 text-indigo-400" />
                                            {semester.name}
                                        </div>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="text-sm font-medium text-slate-300">{semester.schoolYear}</span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="text-sm font-medium text-slate-300">{semester.startDate}</span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="text-sm font-medium text-slate-300">{semester.endDate}</span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <div className="flex justify-center">
                                            {renderStatus(semester.status)}
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