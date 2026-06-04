import 'package:flutter/material.dart';
import 'widgets/profile/profile_header.dart';
import 'widgets/profile/semester_card.dart';
import 'widgets/profile/main_menu_card.dart';
import 'widgets/profile/request_menu_card.dart';
import 'widgets/profile/settings_card.dart';

class LecturerProfileScreen extends StatelessWidget {
  const LecturerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: Column(
        children: [
          const ProfileHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(height: 16),
                  SemesterCard(),
                  SizedBox(height: 12),
                  MainMenuCard(),
                  SizedBox(height: 12),
                  RequestMenuCard(),
                  SizedBox(height: 12),
                  SettingsCard(),
                  SizedBox(height: 24),
                  Text(
                    'HUIT E-Office · Phiên bản 2.1.0',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}