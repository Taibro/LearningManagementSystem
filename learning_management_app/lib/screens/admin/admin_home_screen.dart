import 'package:flutter/material.dart';
import 'widgets/home/home_header.dart';
import 'widgets/home/system_stats_grid.dart';
import 'widgets/home/semester_progress_card.dart';
import 'widgets/home/pending_requests_card.dart';
import 'widgets/home/quick_actions_card.dart';
import 'widgets/home/activity_feed_card.dart';
import 'quick_actions/add_student_screen.dart';
import 'quick_actions/add_lecturer_screen.dart';
import 'quick_actions/add_class_screen.dart';
import 'quick_actions/admin_notifications_screen.dart';
import 'quick_actions/update_schedule_screen.dart';
import 'quick_actions/backup_data_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  static const _kBg = Color(0xFFF0F2FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SystemStatsGrid(),
                  const SizedBox(height: 20),
                  const SemesterProgressCard(),
                  const SizedBox(height: 20),
                  PendingRequestsCard(
                    onAction: (action) => _snack('Đã $action đề xuất'),
                  ),
                  const SizedBox(height: 20),
                  QuickActionsCard(
                    onAction: _handleQuickAction,
                  ),
                  const SizedBox(height: 20),
                  const ActivityFeedCard(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    // Remove newline characters for easier matching
    final cleanAction = action.replaceAll('\n', ' ').trim();
    
    Widget targetScreen;
    switch (cleanAction) {
      case 'Thêm sinh viên':
        targetScreen = const AddStudentScreen();
        break;
      case 'Thêm giảng viên':
        targetScreen = const AddLecturerScreen();
        break;
      case 'Thêm lớp học':
        targetScreen = const AddClassScreen();
        break;
      case 'Thông báo':
        targetScreen = const AdminNotificationsScreen();
        break;
      case 'Cập nhật lịch':
        targetScreen = const UpdateScheduleScreen();
        break;
      case 'Sao lưu DL':
        targetScreen = const BackupDataScreen();
        break;
      default:
        _snack('Tính năng đang phát triển');
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg.replaceAll('\n', ' ')),
      backgroundColor: const Color(0xFF1A237E),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }
}