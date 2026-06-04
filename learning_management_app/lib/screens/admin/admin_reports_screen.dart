import 'package:flutter/material.dart';
import 'widgets/reports/reports_header_and_filter.dart';
import 'widgets/reports/attendance_tab.dart';
import 'widgets/reports/grades_tab.dart';
import 'widgets/reports/teaching_tab.dart';
import 'widgets/reports/requests_tab.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});
  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg = Color(0xFFF0F2FF);

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        ReportsHeaderAndFilter(
          onExport: () => _snack('Xuất báo cáo tổng hợp'),
        ),
        _buildTabBar(),
        Expanded(
            child: TabBarView(controller: _tab, children: const [
          AttendanceTab(),
          GradesTab(),
          TeachingTab(),
          RequestsTab(),
        ])),
      ]),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: _kPrimary,
      child: TabBar(
        controller: _tab,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Điểm danh'),
          Tab(text: 'Kết quả HT'),
          Tab(text: 'Giảng dạy'),
          Tab(text: 'Đề xuất')
        ],
      ),
    );
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(msg),
            backgroundColor: _kPrimary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2)),
      );
}