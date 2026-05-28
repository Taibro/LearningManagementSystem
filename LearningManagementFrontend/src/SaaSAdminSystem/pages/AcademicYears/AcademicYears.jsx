import React from 'react';
import { Calendar, CheckCircle2, Search, Filter, CalendarDays, PlayCircle, Clock3, Edit, Trash2, CalendarRange } from 'lucide-react';
import './AcademicYears.css';

export default function AcademicYears() {
    const academicYearList = [
        {
            id: 'AY_2024_2025',
            name: 'Năm học 2024-2025',
            startDate: '05/09/2024',
            endDate: '31/08/2025',
            status: 'completed'
        },
        {
            id: 'AY_2025_2026',
            name: 'Năm học 2025-2026',
            startDate: '05/09/2025',
            endDate: '31/08/2026',
            status: 'active'
        },
        {
            id: 'AY_2026_2027',
            name: 'Năm học 2026-2027',
            startDate: '05/09/2026',
            endDate: '31/08/2027',
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

    const totalYears = academicYearList.length;
    const activeYear = academicYearList.find(y => y.status === 'active');
    const completedCount = academicYearList.filter(y => y.status === 'completed').length;
    const upcomingCount = academicYearList.filter(y => y.status === 'upcoming').length;

    const summaryCards = [
        { title: "Tổng số Năm học", value: totalYears, color: "text-indigo-400", icon: <Calendar className="w-6 h-6 text-indigo-500/50 absolute right-6 top-8" /> },
        { title: "Năm học hiện tại", value: activeYear ? activeYear.name : "N/A", color: "text-emerald-400", icon: <PlayCircle className="w-6 h-6 text-emerald-500/50 absolute right-6 top-8" /> },
        { title: "Đã lưu trữ (Hoàn thành)", value: completedCount, color: "text-slate-400", icon: <CheckCircle2 className="w-6 h-6 text-slate-500/50 absolute right-6 top-8" /> },
        { title: "Kế hoạch sắp tới", value: upcomingCount, color: "text-amber-400", icon: <Clock3 className="w-6 h-6 text-amber-500/50 absolute right-6 top-8" /> }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <Calendar className="w-7 h-7 text-indigo-400" />
                        </div>
                        Quản lý Năm học
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Cấu hình thời gian và lộ trình đào tạo theo từng năm học</p>
                </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                {summaryCards.map((card, index) => (
                    <div
                        key={index}
                        className="invoice-summary-card bg-[#151a26] rounded-2xl border border-slate-800 relative group flex flex-col justify-center transition-all duration-300 hover:-translate-y-1 hover:border-slate-600 hover:shadow-lg hover:shadow-black/20"
                    >
                        <div className="text-sm font-medium text-slate-400 mb-2 relative z-10">{card.title}</div>
                        <div className={`invoice-summary-value text-3xl lg:text-4xl font-extrabold ${card.color} pt-1 pb-3 leading-relaxed tracking-tight relative z-10 truncate`}>
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
                        placeholder="Tìm kiếm mã năm học, tên năm học..."
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
                        + Tạo Năm học mới
                    </button>
                </div>
            </div>

            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th className="px-5 py-6 first:pl-8">Mã NH</th>
                                <th className="px-5 py-6">Tên Năm Học</th>
                                <th className="px-5 py-6 text-center">Ngày bắt đầu</th>
                                <th className="px-5 py-6 text-center">Ngày kết thúc</th>
                                <th className="px-5 py-6 text-center">Trạng thái</th>
                                <th className="px-5 py-6 text-right last:pr-8">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {academicYearList.map((year) => (
                                <tr key={year.id} className="hover:bg-slate-800/40 transition-colors group">
                                    <td className="px-5 py-7 first:pl-8">
                                        <span className="text-sm font-bold text-slate-400 group-hover:text-indigo-400 transition-colors">{year.id}</span>
                                    </td>
                                    <td className="px-5 py-7">
                                        <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit flex items-center gap-2">
                                            <CalendarRange className="w-4 h-4 text-indigo-400" />
                                            {year.name}
                                        </div>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-300">
                                            <CalendarDays className="w-4 h-4 text-slate-500" />
                                            {year.startDate}
                                        </span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-300">
                                            <CalendarDays className="w-4 h-4 text-slate-500" />
                                            {year.endDate}
                                        </span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <div className="flex justify-center">
                                            {renderStatus(year.status)}
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