import 'package:flutter/material.dart';
import 'widgets/settings/admin_profile_card.dart';
import 'widgets/settings/semester_card.dart';
import 'widgets/settings/system_card.dart';
import 'widgets/settings/notification_card.dart';
import 'widgets/settings/announcement_card.dart';
import 'widgets/settings/account_card.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});
  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  static const _kPrimary = Color(0xFF1A237E);
  static const _kBg = Color(0xFFF0F2FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        _buildHeader(),
        Expanded(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const AdminProfileCard(),
            const SizedBox(height: 14),
            const SemesterCard(),
            const SizedBox(height: 14),
            SystemCard(onAction: (msg) => _snack(msg)),
            const SizedBox(height: 14),
            const NotificationCard(),
            const SizedBox(height: 14),
            const AnnouncementCard(),
            const SizedBox(height: 14),
            AccountCard(onAction: (msg) => _snack(msg)),
            const SizedBox(height: 24),
            const Text('HUIT E-Office Admin · v2.1.0',
                style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
            const SizedBox(height: 24),
          ]),
        )),
      ]),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B6E), _kPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 14,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: const Row(children: [
        Icon(Icons.settings_rounded, color: Colors.white, size: 22),
        SizedBox(width: 10),
        Text('Cài đặt hệ thống',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
      ]),
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