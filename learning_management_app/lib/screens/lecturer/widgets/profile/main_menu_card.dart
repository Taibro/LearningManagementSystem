import 'package:flutter/material.dart';
import '../../features/profile_detail_screen.dart';
import '../../features/salary_info_screen.dart';
import '../../features/teaching_stats_screen.dart';
import '../../features/lecture_materials_screen.dart';
import '../../features/survey_screen.dart';
import 'bottom_sheets/declaration_sheet.dart';
import 'bottom_sheets/statistics_sheet.dart';
import 'bottom_sheets/salary_sheet.dart';
import '../../lecturer_personal_profile_screen.dart';
import '../../lecturer_materials_screen.dart';
import '../../lecturer_survey_screen.dart';
import '../../features/profile_detail_screen.dart';
import '../../features/salary_info_screen.dart';
import '../../features/teaching_stats_screen.dart';
import '../../features/lecture_materials_screen.dart';
import '../../features/survey_screen.dart';

class MainMenuCard extends StatelessWidget {
  const MainMenuCard({super.key});

  void _showSalarySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SalarySheet(),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Khai báo thông tin (Declaration) still uses the bottom sheet if no screen was requested, 
  // but to be uniform, the user wanted to sync perfectly. 
  // Let's keep Declaration as bottom sheet for now or create a screen? 
  // The user requested to "hoàn thành giao diện" for ones in home. 
  // Khai báo thông tin is not in the Home quick actions list that user gave.
  void _showDeclarationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DeclarationSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.badge_outlined,
            iconBgColor: const Color(0xFFE8EAF6),
            iconColor: const Color(0xFF5C6BC0),
            label: 'Hồ sơ cá nhân',
            subtitle: 'Thông tin giảng viên',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerPersonalProfileScreen()),
            ),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.monetization_on_outlined,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            label: 'Thông tin lương',
            subtitle: 'Xem bảng lương theo tháng',
            onTap: () => _navigateTo(context, const SalaryInfoScreen()),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.assignment_outlined,
            iconBgColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            label: 'Khai báo thông tin',
            subtitle: 'Cập nhật thông tin giảng dạy HK',
            onTap: () => _showDeclarationSheet(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.library_books_outlined,
            iconBgColor: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF6B4FA0),
            label: 'Quản lý tài liệu bài giảng',
            subtitle: 'Tải lên và quản lý giáo án',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerMaterialsScreen()),
            ),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.bar_chart_rounded,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            label: 'Thống kê thực giảng, coi thi',
            subtitle: 'Tổng hợp giờ giảng, giờ coi thi',
            onTap: () => _navigateTo(context, const TeachingStatsScreen()),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.poll_outlined,
            iconBgColor: const Color(0xFFFCE4EC),
            iconColor: const Color(0xFFE85D75),
            label: 'Khảo sát',
            subtitle: 'Lấy ý kiến sinh viên về môn học',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerSurveyScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => const Divider(
      height: 1, indent: 68, color: Color(0xFFF0F0F0));
}
