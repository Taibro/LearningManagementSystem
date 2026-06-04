import 'package:flutter/material.dart';
import 'widgets/home/home_header.dart';
import 'widgets/home/system_stats_grid.dart';
import 'widgets/home/semester_progress_card.dart';
import 'widgets/home/pending_requests_card.dart';
import 'widgets/home/quick_actions_card.dart';
import 'widgets/home/activity_feed_card.dart';

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
                    onAction: (action) => _snack(action),
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

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg.replaceAll('\n', ' ')),
      backgroundColor: const Color(0xFF1A237E),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }
}