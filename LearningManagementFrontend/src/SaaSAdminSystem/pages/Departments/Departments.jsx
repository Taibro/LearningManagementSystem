import React from 'react';
import { Building2, CheckCircle2, Search, Filter, Download, ChevronDown, Users, BookOpen, GraduationCap, Edit, Trash2 } from 'lucide-react';
import './Department.css';

export default function Departments() {
    const departmentList = [
        {
            id: 'F_CNTT',
            name: 'Khoa Công nghệ Thông tin',
            headOfDept: 'PGS. TS. Nguyễn Ánh Tuấn',
            majorsCount: 5,
            studentsCount: 4500,
            establishedYear: 2001,
            status: 'active'
        },
        {
            id: 'F_QTKD',
            name: 'Khoa Quản trị Kinh doanh',
            headOfDept: 'TS. Lê Thị Thu Hà',
            majorsCount: 4,
            studentsCount: 3800,
            establishedYear: 1998,
            status: 'active'
        },
        {
            id: 'F_NN',
            name: 'Khoa Ngoại ngữ',
            headOfDept: 'TS. Trần Văn Bình',
            majorsCount: 3,
            studentsCount: 2100,
            establishedYear: 2005,
            status: 'active'
        }
    ];

    const renderStatus = (status) => {
        if (status === 'active') {
            return (
                <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-950/80 text-emerald-400 border border-emerald-900/50">
                    <CheckCircle2 className="w-4 h-4" /> Đang hoạt động
                </span>
            );
        }
        return null;
    };

    const totalDepartments = departmentList.length;
    const totalMajors = departmentList.reduce((acc, curr) => acc + curr.majorsCount, 0);
    const totalStudents = departmentList.reduce((acc, curr) => acc + curr.studentsCount, 0);

    const formatNumber = (num) => {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    };

    const summaryCards = [
        { title: "Tổng số Khoa quản lý", value: totalDepartments, color: "text-indigo-400", icon: <Building2 className="w-6 h-6 text-indigo-500/50 absolute right-6 top-8" /> },
        { title: "Tổng số Chuyên ngành", value: totalMajors, color: "text-emerald-400", icon: <BookOpen className="w-6 h-6 text-emerald-500/50 absolute right-6 top-8" /> },
        { title: "Quy mô Sinh viên", value: formatNumber(totalStudents), color: "text-amber-400", icon: <Users className="w-6 h-6 text-amber-500/50 absolute right-6 top-8" /> },
        { title: "Trạng thái hệ thống", value: "100%", color: "text-blue-400", icon: <CheckCircle2 className="w-6 h-6 text-blue-500/50 absolute right-6 top-8" /> }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <Building2 className="w-7 h-7 text-indigo-400" />
                        </div>
                        Quản lý Khoa / Bộ môn
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Quản lý cơ cấu tổ chức và quy mô đào tạo của trường</p>
                </div>

                <div className="flex items-center gap-3">
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        Năm học 2025-2026
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
                        placeholder="Tìm kiếm tên khoa, mã khoa..."
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
                        + Thêm Khoa mới
                    </button>
                </div>
            </div>

            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th className="px-5 py-6 first:pl-8">Mã Khoa</th>
                                <th className="px-5 py-6">Tên Khoa</th>
                                <th className="px-5 py-6">Trưởng Khoa</th>
                                <th className="px-5 py-6 text-center">Số Chuyên Ngành</th>
                                <th className="px-5 py-6 text-center">Số Sinh Viên</th>
                                <th className="px-5 py-6 text-center">Trạng thái</th>
                                <th className="px-5 py-6 text-right last:pr-8">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {departmentList.map((dept) => (
                                <tr key={dept.id} className="hover:bg-slate-800/40 transition-colors group">
                                    <td className="px-5 py-7 first:pl-8">
                                        <span className="text-sm font-bold text-slate-400 group-hover:text-indigo-400 transition-colors">{dept.id}</span>
                                    </td>
                                    <td className="px-5 py-7">
                                        <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit flex items-center gap-2">
                                            <GraduationCap className="w-4 h-4 text-slate-500" />
                                            {dept.name}
                                        </div>
                                        <div className="text-xs text-slate-500 mt-1.5">Thành lập: {dept.establishedYear}</div>
                                    </td>
                                    <td className="px-5 py-7">
                                        <div className="text-sm text-slate-200">{dept.headOfDept}</div>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="inline-flex items-center justify-center w-8 h-8 rounded-lg bg-slate-800 text-sm font-bold text-slate-300">
                                            {dept.majorsCount}
                                        </span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="text-sm font-bold text-slate-200">
                                            {formatNumber(dept.studentsCount)}
                                        </span>
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <div className="flex justify-center">
                                            {renderStatus(dept.status)}
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