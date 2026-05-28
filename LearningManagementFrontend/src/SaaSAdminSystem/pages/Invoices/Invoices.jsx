import React from 'react';
import { Receipt, CheckCircle2, Clock3, AlertTriangle, Search, Filter, Download, ChevronDown, CalendarDays } from 'lucide-react';
import './Invoices.css'; // Đã import CSS

export default function Invoices() {
    const invoiceList = [
        {
            id: 'HD001',
            studentName: 'Nguyễn Thành Tài',
            studentCode: '2001230773',
            semester: 'Học kỳ 2 (2025-2026)',
            totalAmount: 8500000,
            paidAmount: 8500000,
            dueDate: '15/05/2026',
            status: 'paid'
        },
        {
            id: 'HD002',
            studentName: 'Phạm Văn Đức',
            studentCode: '21IT001',
            semester: 'Học kỳ 2 (2025-2026)',
            totalAmount: 9600000,
            paidAmount: 3000000,
            dueDate: '30/06/2026',
            status: 'partial'
        },
        {
            id: 'HD003',
            studentName: 'Hoàng Thị Lan',
            studentCode: '21IT002',
            semester: 'Học kỳ 2 (2025-2026)',
            totalAmount: 8500000,
            paidAmount: 0,
            dueDate: '10/04/2026',
            status: 'overdue'
        }
    ];

    const formatVND = (amount) => {
        return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + '₫';
    };

    const renderStatus = (status) => {
        switch (status) {
            case 'paid':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-950/80 text-emerald-400 border border-emerald-900/50">
                        <CheckCircle2 className="w-4 h-4" /> Đã thanh toán
                    </span>
                );
            case 'partial':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-amber-950/80 text-amber-400 border border-amber-900/50">
                        <Clock3 className="w-4 h-4" /> Đóng một phần
                    </span>
                );
            case 'overdue':
                return (
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-rose-950/80 text-rose-400 border border-rose-900/50">
                        <AlertTriangle className="w-4 h-4" /> Quá hạn nộp
                    </span>
                );
            default:
                return null;
        }
    };

    const totalDebtAmount = invoiceList.reduce((acc, inv) => acc + inv.totalAmount, 0);
    const totalPaidAmount = invoiceList.reduce((acc, inv) => acc + inv.paidAmount, 0);
    const remainingAmount = invoiceList.reduce((acc, inv) => acc + (inv.totalAmount - inv.paidAmount), 0);
    const totalInvoices = invoiceList.length;

    const summaryCards = [
        { title: "Tổng tiền nợ học kỳ", value: formatVND(totalDebtAmount), color: "text-emerald-500" },
        { title: "Đã thu (success)", value: formatVND(totalPaidAmount), color: "text-blue-500" },
        { title: "Còn nợ hạn nộp (warning)", value: formatVND(remainingAmount), color: "text-amber-500" },
        { title: "Tổng hóa đơn", value: totalInvoices, color: "text-rose-500" }
    ];

    return (
        <div className="p-4 md:p-6 bg-[#0a0f18] min-h-screen text-slate-100 font-sans">

            {/* Page Title Area */}
            <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-extrabold text-slate-50 flex items-center gap-3">
                        <div className="p-2 bg-indigo-500/10 border border-indigo-500/20 rounded-lg shadow-sm">
                            <Receipt className="w-7 h-7 text-indigo-400" />
                        </div>
                        Quản lý Công nợ
                    </h1>
                    <p className="text-slate-400 text-sm mt-2 ml-14">Theo dõi hóa đơn học phí và tình trạng thanh toán</p>
                </div>

                <div className="flex items-center gap-3">
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        Học kỳ 2 (2025-2026)
                        <ChevronDown className="w-4 h-4 text-slate-500" />
                    </div>
                    <div className="flex items-center gap-2 px-5 py-2.5 bg-[#151a26] border border-slate-800 rounded-xl text-slate-300 text-sm font-medium hover:bg-slate-800 transition-colors cursor-pointer shadow-sm">
                        <CalendarDays className="w-5 h-5 text-indigo-400" />
                        15/05/2026
                    </div>
                </div>
            </div>

            {/* Summary Cards */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                {summaryCards.map((card, index) => (
                    <div
                        key={index}
                        // Đã gắn class invoice-summary-card
                        className="invoice-summary-card bg-[#151a26] rounded-2xl border border-slate-800 relative group flex flex-col justify-center transition-all duration-300 hover:-translate-y-1 hover:border-slate-600 hover:shadow-lg hover:shadow-black/20"
                    >
                        <div className="text-sm font-medium text-slate-400 mb-2 relative z-10">{card.title}</div>
                        {/* Đã gắn class invoice-summary-value */}
                        <div className={`invoice-summary-value text-3xl lg:text-4xl font-extrabold ${card.color} tracking-tight relative z-10`}>
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
                        placeholder="Tìm kiếm MSSV..."
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

            {/* Data Table */}
            {/* Đã gắn class invoice-table-wrapper */}
            <div className="invoice-table-wrapper bg-[#151a26] rounded-2xl border border-slate-800 shadow-sm overflow-hidden pb-2">
                <div className="overflow-x-auto">
                    {/* Đã gắn class invoice-table */}
                    <table className="invoice-table w-full text-left border-collapse whitespace-nowrap">
                        <thead>
                            <tr className="border-b border-slate-700 text-slate-400 text-xs uppercase tracking-widest font-semibold bg-slate-800/20">
                                <th>Mã HĐ</th>
                                <th>Sinh viên</th>
                                <th>Học kỳ</th>
                                <th className="text-right">Tổng tiền</th>
                                <th className="text-right">Đã đóng</th>
                                <th className="text-right">Còn nợ</th>
                                <th className="text-center">Hạn nộp</th>
                                <th className="text-center">Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/80">
                            {invoiceList.map((invoice) => {
                                const debt = invoice.totalAmount - invoice.paidAmount;

                                return (
                                    <tr key={invoice.id} className="hover:bg-slate-800/40 transition-colors group">
                                        <td>
                                            <span className="text-sm font-medium text-slate-500 font-mono group-hover:text-indigo-400 transition-colors">{invoice.id}</span>
                                        </td>
                                        <td>
                                            <div className="text-sm font-bold text-slate-100 hover:text-indigo-400 cursor-pointer transition-colors w-fit">
                                                {invoice.studentName}
                                            </div>
                                            <div className="text-xs font-mono text-slate-500 mt-1.5">{invoice.studentCode}</div>
                                        </td>
                                        <td><span className="text-sm text-slate-300">{invoice.semester}</span></td>
                                        <td className="text-sm font-bold text-slate-100 text-right">
                                            {formatVND(invoice.totalAmount)}
                                        </td>
                                        <td className="text-sm font-bold text-emerald-400 text-right">
                                            {invoice.paidAmount === 0 ? '0₫' : formatVND(invoice.paidAmount)}
                                        </td>
                                        <td className="text-sm font-bold text-rose-500 text-right">
                                            {debt === 0 ? '0₫' : formatVND(debt)}
                                        </td>
                                        <td className="text-center">
                                            <span className="inline-flex items-center justify-center gap-1.5 text-sm text-slate-300">
                                                <CalendarDays className="w-4 h-4 text-slate-500" />
                                                {invoice.dueDate}
                                            </span>
                                        </td>
                                        <td className="text-center">
                                            <div className="flex justify-center">
                                                {renderStatus(invoice.status)}
                                            </div>
                                        </td>
                                    </tr>
                                )
                            })}
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    );
}