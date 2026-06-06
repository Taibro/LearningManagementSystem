import 'package:flutter/material.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/lecturer/salary/teacher_salary_bloc.dart';
import '../../blocs/lecturer/salary/teacher_salary_event.dart';
import '../../blocs/lecturer/salary/teacher_salary_state.dart';
import '../../models/lecturer/monthly_salary.dart';
import 'package:intl/intl.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

class LecturerSalaryScreen extends StatefulWidget {
  const LecturerSalaryScreen({super.key});

  @override
  State<LecturerSalaryScreen> createState() => _LecturerSalaryScreenState();
}

class _LecturerSalaryScreenState extends State<LecturerSalaryScreen> {
  int _selectedYear = 2026;
  int _selectedMonth = 3;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedYear = now.year;
    _selectedMonth = now.month;
    _fetchSalary();
  }

  void _fetchSalary() {
    context.read<TeacherSalaryBloc>().add(TeacherSalaryFetchRequested(
          year: _selectedYear,
          month: _selectedMonth,
        ));
  }

  final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

  String formatCurrency(double amount) {
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const LecturerCustomAppBar(title: 'Thông tin lương'),
          Expanded(
            child: BlocBuilder<TeacherSalaryBloc, TeacherSalaryState>(
              builder: (context, state) {
                if (state is TeacherSalaryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TeacherSalaryLoadFailure) {
                  return Column(
                    children: [
                      _buildMonthSelector(),
                      Expanded(child: Center(child: Text('Không có dữ liệu lương tháng $_selectedMonth/$_selectedYear'))),
                    ],
                  );
                } else if (state is TeacherSalaryLoadSuccess) {
                  final salary = state.salary;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildSummaryCards(salary),
                        const SizedBox(height: 16),
                        _buildMonthSelector(),
                        const SizedBox(height: 16),
                        _buildSalaryBreakdown(salary),
                        const SizedBox(height: 16),
                        _buildTotalCard(salary),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(MonthlySalary salary) {
    final items = [
      {'value': formatCurrency(salary.baseAmount ?? 0), 'label': 'Lương cơ bản', 'color': const Color(0xFF4CAF50)},
      {'value': formatCurrency((salary.sessionAmount ?? 0) + (salary.bonusAmount ?? 0)), 'label': 'Phụ cấp', 'color': _kPrimary},
      {'value': formatCurrency(salary.netAmount ?? 0), 'label': 'Thực nhận', 'color': const Color(0xFFE85D75)},
    ];

    return Row(
      children: items.map((item) {
        final color = item['color'] as Color;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Text(
                  item['value'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['label'] as String,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.calendar_month, color: _kPrimary, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            'Tháng $_selectedMonth/$_selectedYear',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212121),
            ),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down_rounded, color: _kPrimary, size: 24),
        ],
      ),
    );
  }

  Widget _buildSalaryBreakdown(MonthlySalary salary) {
    final List<Map<String, dynamic>> details = [
      {'label': 'Lương cơ bản', 'amount': formatCurrency(salary.baseAmount ?? 0), 'note': 'Hệ số ${salary.coefficientSnapshot ?? 1.0}', 'plus': true},
      {'label': 'Phụ cấp & Thưởng', 'amount': formatCurrency(salary.bonusAmount ?? 0), 'note': '', 'plus': true},
      {'label': 'Thù lao vượt tiết', 'amount': formatCurrency(salary.sessionAmount ?? 0), 'note': '', 'plus': true},
      {'label': 'Các khoản khấu trừ', 'amount': '-${formatCurrency(salary.deductionAmount ?? 0)}', 'note': '', 'plus': false},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chi tiết bảng lương',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 12),
          ...details.map((item) => _buildSalaryRow(item)),
        ],
      ),
    );
  }

  Widget _buildSalaryRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: item['plus']
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              item['plus'] ? Icons.add_rounded : Icons.remove_rounded,
              color: item['plus']
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFC62828),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['label'],
                  style: TextStyle(
                    fontSize: 13,
                    color: item['plus']
                        ? const Color(0xFF212121)
                        : const Color(0xFFC62828),
                  ),
                ),
                if ((item['note'] as String).isNotEmpty)
                  Text(
                    item['note'],
                    style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                  ),
              ],
            ),
          ),
          Text(
            item['amount'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: item['plus']
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFC62828),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard(MonthlySalary salary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: _kPrimary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'THỰC NHẬN',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Tháng $_selectedMonth/$_selectedYear',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
          Text(
            formatCurrency(salary.netAmount ?? 0),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
