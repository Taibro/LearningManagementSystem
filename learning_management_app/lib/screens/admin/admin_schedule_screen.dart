import 'package:flutter/material.dart';
import 'data/mock_admin_schedule_data.dart';
import 'widgets/schedule/class_list_tab.dart';
import 'widgets/schedule/weekly_view_tab.dart';
import 'widgets/schedule/rooms_tab.dart';
import 'widgets/schedule/bottom_sheets/class_form_sheet.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({super.key});
  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg = Color(0xFFF0F2FF);

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
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
        _buildHeader(),
        _buildTabBar(),
        Expanded(
            child: TabBarView(
                controller: _tab,
                children: const [
              ClassListTab(),
              WeeklyViewTab(),
              RoomsTab(),
            ])),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddClassSheet(),
        backgroundColor: _kPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm lịch',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF0D1B6E), _kPrimary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 14,
          left: 16,
          right: 16,
          bottom: 16),
      child: Row(children: [
        const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        const Text('Quản lý lịch học',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        const Spacer(),
        Text('${mockClasses.length} lớp',
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ]),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: _kPrimary,
      child: TabBar(
        controller: _tab,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Danh sách lớp'),
          Tab(text: 'Lịch theo tuần'),
          Tab(text: 'Phòng học')
        ],
      ),
    );
  }

  void _showAddClassSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ClassFormSheet(existing: null),
    );
  }
}