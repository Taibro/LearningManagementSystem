import 'package:flutter/material.dart';
import 'widgets/attendance/manual_attendance_tab.dart';
import 'widgets/attendance/qr_attendance_tab.dart';
import 'widgets/attendance/grades_tab.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

class LecturerAttendanceScreen extends StatefulWidget {
  final int initialTabIndex;
  const LecturerAttendanceScreen({super.key, this.initialTabIndex = 0});

  @override
  State<LecturerAttendanceScreen> createState() =>
      _LecturerAttendanceScreenState();
}

class _LecturerAttendanceScreenState extends State<LecturerAttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: Column(
        children: [
          const LecturerCustomAppBar(
            title: 'Quản lý điểm danh',
            icon: Icons.how_to_reg_outlined,
          ),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ManualAttendanceTab(),
                QrAttendanceTab(),
                GradesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFF6B4FA0),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Điểm danh'),
          Tab(text: 'QR Code'),
          Tab(text: 'Kết quả HT'),
        ],
      ),
    );
  }
}