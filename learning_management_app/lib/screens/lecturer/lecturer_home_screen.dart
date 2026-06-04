import 'package:flutter/material.dart';
import 'widgets/home/home_header.dart';
import 'widgets/home/stats_row.dart';
import 'widgets/home/today_classes.dart';
import 'widgets/home/function_grid.dart';
import 'widgets/home/recent_notifications.dart';

class LecturerHomeScreen extends StatelessWidget {
  const LecturerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  StatsRow(),
                  SizedBox(height: 20),
                  TodayClasses(),
                  SizedBox(height: 20),
                  FunctionGrid(),
                  SizedBox(height: 20),
                  RecentNotifications(),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}