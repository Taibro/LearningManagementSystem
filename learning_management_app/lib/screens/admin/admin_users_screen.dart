import 'package:flutter/material.dart';
import 'widgets/users/students_tab.dart';
import 'widgets/users/lecturers_tab.dart';
import 'widgets/users/bottom_sheets/user_form_sheet.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});
  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg = Color(0xFFF0F2FF);

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
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
                children: const [StudentsTab(), LecturersTab()])),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddUserSheet(),
        backgroundColor: _kPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm mới',
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
          bottom: 14),
      child: Row(children: [
        const Icon(Icons.people_alt_rounded, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        const Text('Quản lý người dùng',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        const Spacer(),
        GestureDetector(
          onTap: () => _snack('Xuất danh sách'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            child: const Row(children: [
              Icon(Icons.download_outlined, color: Colors.white, size: 16),
              SizedBox(width: 5),
              Text('Xuất',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
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
        tabs: const [Tab(text: 'Sinh viên'), Tab(text: 'Giảng viên')],
      ),
    );
  }

  void _showAddUserSheet() {
    final isStudent = _tab.index == 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          UserFormSheet(type: isStudent ? 'student' : 'lecturer'),
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