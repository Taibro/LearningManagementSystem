import React from 'react';
import { Award, CheckCircle2, Search, Filter, Download, ChevronDown, Star, Trophy, Medal, Edit, Trash2, UserCheck } from 'lucide-react';
import './Conduct.css';

export default function Conduct() {
    const conductList = [
        {
            id: 'RL_001',
            studentName: 'Trần Tấn Phát',
            studentCode: '2001230638',
            conductScore: 92,
            rank: 'Xuất sắc',
            scholarship: 'Học bổng loại 1',
            status: 'approved'
        },
        {
            id: 'RL_002',
            studentName: 'Nguyễn Văn Đức',
            studentCode: '21IT001',
            conductScore: 75,
            rank: 'Khá',
            scholarship: 'Không có',
            status: 'approved'
        },
        {
            id: 'RL_003',
            studentName: 'Hoàng Thị Lan',
            studentCode: '21IT002',
            conductScore: 88,
            rank: 'Tốt',
            scholarship: 'Học bổng loại 2',
            status: 'pending'
        }
    ];

    const renderRankBadge = (rank) => {
        switch (rank) {
            case 'Xuất sắc':
                return <span className="px-3 py-1 rounded-lg text-xs font-bold bg-fuchsia-950/50 text-fuchsia-400 border border-fuchsia-900/50">Xuất sắc</span>;
            case 'Tốt':
                return <span className="px-3 py-1 rounded-lg text-xs font-bold bg-emerald-950/50 text-emerald-400 border border-emerald-900/50">Tốt</span>;
            case 'Khá':
                return <span className="px-3 py-1 rounded-lg text-xs font-bold bg-blue-950/50 text-blue-400 border border-blue-900/50">Khá</span>;
            default:
                return <span className="px-3 py-1 rounded-lg text-xs font-bold bg-slate-800 text-slate-400">Trung bình</span>;
        }
    };

    const renderScholarship = (type) => {
        if (type === 'Không có') return <span className="text-slate-500 text-sm italic">---</span>;
        return (
            <span className="flex items-center gap-1.5 text-sm font-bold text-amber-400">
                <Trophy className="w-4 h-4" /> {type}
            </span>
        );
    };

    const avgConduct = (conductList.reduce((acc, curr) => acc + curr.conductScore, 0) / conductList.length).toFixed(1);
    const scholarshipCount = conductList.filter(c => c.scholarship !== 'Không có').length;

    const summaryCards = [
        { title: "Đang xét học bổng", value: scholarshipCount, color: "text-amber-400", icon: <Award className="w-6 h-6 text-amber-500/50 absolute right-6 top-8" /> },
        { title: "Điểm rèn luyện TB", value: avgConduct, color: "text-emerald-400", icon: <Star className="w-6 h-6 text-emerald-500/50 absolute right-6 top-8" /> },
        { title: "Sinh viên Xuất sắc", value: conductList.filter(c => c.rank === 'Xuất sắc').length, color: "text-fuchsia-400", icon: <Medal className="w-6 h-6 text-fuchsia-500/50 absolute right-6 top-8" /> },
        { title: "Trạng thái tổng kết", value: "85%", color: "text-blue-400", icon: <UserCheck className="w-6 h-6 text-blue-500/50 absolute right-6 top-8" /> }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <Trophy className="w-7 h-7 text-indigo-400" />
                        </div>
                        Rèn luyện & Học bổng
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Tổng kết điểm rèn luyện và xét duyệt danh sách học bổng học kỳ</p>
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
                        placeholder="Tìm kiếm MSSV, tên sinh viên..."
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
                    <button className="flex items-center gap-2 px-4 py-3 bg-emerald-600 hover:bg-emerald-500 text-white rounded-xl font-medium transition-colors shadow-sm">
                        <CheckCircle2 className="w-4 h-4" /> Chốt danh sách
                    </button>
                </div>
            </div>

            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th className="px-5 py-6 first:pl-8">Sinh viên</th>
                                <th className="px-5 py-6 text-center">Điểm rèn luyện</th>
                                <th className="px-5 py-6 text-center">Xếp loại</th>
                                <th className="px-5 py-6">Học bổng dự kiến</th>
                                <th className="px-5 py-6 text-center">Trạng thái duyệt</th>
                                <th className="px-5 py-6 text-right last:pr-8">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {conductList.map((item) => (
                                <tr key={item.id} className="hover:bg-slate-800/40 transition-colors group">
                                    <td className="px-5 py-7 first:pl-8">
                                        <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit">
                                            {item.studentName}
                                        </div>
                                        <div className="text-xs font-mono text-slate-500 mt-1.5">{item.studentCode}</div>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="text-lg font-extrabold text-emerald-400">{item.conductScore}</span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        {renderRankBadge(item.rank)}
                                    </td>
                                    <td className="px-5 py-7">
                                        {renderScholarship(item.scholarship)}
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <div className="flex justify-center">
                                            {item.status === 'approved' ?
                                                <span className="text-xs text-emerald-500 font-medium bg-emerald-500/10 px-2 py-1 rounded">Đã duyệt</span> :
                                                <span className="text-xs text-amber-500 font-medium bg-amber-500/10 px-2 py-1 rounded">Chờ duyệt</span>
                                            }
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