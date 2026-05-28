
import React from 'react';
import { CreditCard, CheckCircle2, Clock3, XCircle, Search, Filter, Download, ChevronDown, CalendarDays, Landmark, Wallet } from 'lucide-react';
import './Payments.css'; // Dùng lại CSS siêu chuẩn của trang Công nợ luôn nha ní!

export default function Payments() {

    const paymentList = [
        {
            id: 'GD_00921',
            studentName: 'Nguyễn Thành Tài',
            studentCode: '2001230773',
            semester: 'Học kỳ 2 (2025-2026)',
            amount: 8500000,
            paymentDate: '15/05/2026 14:30',
            method: 'Chuyển khoản ngân hàng',
            status: 'success'
        },
        {
            id: 'GD_00922',
            studentName: 'Phạm Văn Đức',
            studentCode: '21IT001',
            semester: 'Học kỳ 2 (2025-2026)',
            amount: 3000000,
            paymentDate: '16/05/2026 09:15',
            method: 'Ví MoMo',
            status: 'pending'
        },
        {
            id: 'GD_00923',
            studentName: 'Hoàng Thị Lan',
            studentCode: '21IT002',
            semester: 'Học kỳ 2 (2025-2026)',
            amount: 8500000,
            paymentDate: '10/04/2026 16:45',
            method: 'Tiền mặt (Tại quầy)',
            status: 'failed'
        }
    ];

    const formatVND = (amount) => {
        return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + '₫';
    };

    const renderStatus = (status) => {
        switch (status) {
            case 'success':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-950/80 text-emerald-400 border border-emerald-900/50">
                        <CheckCircle2 className="w-4 h-4" /> Thành công
                    </span>
                );
            case 'pending':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-amber-950/80 text-amber-400 border border-amber-900/50">
                        <Clock3 className="w-4 h-4" /> Đang xử lý
                    </span>
                );
            case 'failed':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-rose-950/80 text-rose-400 border border-rose-900/50">
                        <XCircle className="w-4 h-4" /> Thất bại
                    </span>
                );
            default:
                return null;
        }
    };

    // 3. TÍNH TOÁN DATA CHO SUMMARY CARDS
    const totalSuccess = paymentList.filter(p => p.status === 'success').reduce((acc, curr) => acc + curr.amount, 0);
    const totalPending = paymentList.filter(p => p.status === 'pending').reduce((acc, curr) => acc + curr.amount, 0);
    const countFailed = paymentList.filter(p => p.status === 'failed').length;
    const totalTransactions = paymentList.length;

    const summaryCards = [
        { title: "Tổng thực thu (Thành công)", value: formatVND(totalSuccess), color: "text-emerald-500" },
        { title: "Đang chờ xử lý (Pending)", value: formatVND(totalPending), color: "text-amber-500" },
        { title: "Giao dịch lỗi/Hủy", value: countFailed, color: "text-rose-500" },
        { title: "Tổng số giao dịch", value: totalTransactions, color: "text-blue-500" }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">

            {/* Page Title Area */}
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        {/* Đổi icon thành CreditCard */}
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <CreditCard className="w-7 h-7 text-indigo-400" />
                        </div>
                        Giao dịch Thanh toán
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Quản lý lịch sử và trạng thái thanh toán học phí</p>
                </div>

                <div className="flex items-center gap-3">
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        Học kỳ 2 (2025-2026)
                        <ChevronDown className="w-4 h-4 text-slate-500" />
                    </div>
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        <CalendarDays className="w-5 h-5 text-indigo-400" />
                        Hôm nay
                    </div>
                </div>
            </div>

            {/* Summary Cards - Dùng lại class của Invoices.css */}
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
                        <div className="w-24 h-24 bg-slate-800/40 rounded-full absolute -right-6 -top-6 pointer-events-none group-hover:bg-slate-700/30 transition-colors z-0"></div>
                    </div>
                ))}
            </div>

            {/* Toolbar */}
            <div className="flex items-center justify-between mb-6">
                <div className="flex items-center w-full max-w-md bg-[#151a26] border border-slate-700/50 rounded-xl focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500 transition-all shadow-sm">
                    <input
                        type="text"
                        placeholder="Tìm kiếm Mã GD, MSSV..."
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
                    <button className="p-3 bg-[#151a26] border border-slate-800 text-slate-400 rounded-xl hover:text-white hover:bg-slate-800 transition-colors shadow-sm" title="Xuất file">
                        <Download className="w-5 h-5" />
                    </button>
                </div>
            </div>

            {/* Data Table - Dùng lại class của Invoices.css */}
            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th className="px-5 py-6 first:pl-8">Mã GD</th>
                                <th className="px-5 py-6">Sinh viên</th>
                                <th className="px-5 py-6">Phương thức</th>
                                <th className="px-5 py-6 text-right">Số tiền</th>
                                <th className="px-5 py-6 text-center">Thời gian</th>
                                <th className="px-5 py-6 text-center last:pr-8">Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {paymentList.map((payment) => (
                                <tr key={payment.id} className="hover:bg-slate-800/40 transition-colors group">
                                    <td className="px-5 py-7 first:pl-8">
                                        <span className="text-sm font-medium text-slate-500 font-mono group-hover:text-indigo-400 transition-colors">{payment.id}</span>
                                    </td>
                                    <td className="px-5 py-7">
                                        <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit">
                                            {payment.studentName}
                                        </div>
                                        <div className="text-xs font-mono text-slate-500 mt-1.5">{payment.studentCode}</div>
                                    </td>
                                    <td className="px-5 py-7">
                                        <span className="text-sm text-slate-300 flex items-center gap-2">
                                            {payment.method.includes('MoMo') ? <Wallet className="w-4 h-4 text-pink-500" /> : <Landmark className="w-4 h-4 text-slate-400" />}
                                            {payment.method}
                                        </span>
                                    </td>
                                    <td className="px-5 py-7 text-sm font-bold text-slate-100 text-right">
                                        {formatVND(payment.amount)}
                                    </td>
                                    <td className="px-5 py-7 text-center">
                                        <span className="inline-flex items-center justify-center gap-1.5 text-sm text-slate-300">
                                            <CalendarDays className="w-4 h-4 text-slate-500" />
                                            {payment.paymentDate}
                                        </span>
                                    </td>
                                    <td className="px-5 py-7 text-center last:pr-8">
                                        <div className="flex justify-center">
                                            {renderStatus(payment.status)}
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