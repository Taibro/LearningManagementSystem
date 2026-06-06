import 'package:flutter/material.dart';
import 'lecturer_attendance_screen.dart';
import 'lecturer_teaching_stats_screen.dart';
import 'lecturer_salary_screen.dart';
import 'lecturer_materials_screen.dart';
import 'lecturer_request_screen.dart';
import 'lecturer_personal_profile_screen.dart';
import 'lecturer_survey_screen.dart';
import 'lecturer_schedule_screen.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

class LecturerAllFeaturesScreen extends StatelessWidget {
  const LecturerAllFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      _Feature(
        icon: Icons.how_to_reg_outlined,
        label: 'Điểm danh',
        color: _kPrimary,
        bgColor: const Color(0xFFEDE7F6),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerAttendanceScreen(initialTabIndex: 0)),
        ),
      ),
      _Feature(
        icon: Icons.qr_code_2_rounded,
        label: 'QR Code',
        color: const Color(0xFF4CAF50),
        bgColor: const Color(0xFFE8F5E9),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerAttendanceScreen(initialTabIndex: 1)),
        ),
      ),
      _Feature(
        icon: Icons.grade_rounded,
        label: 'Kết quả\nhọc tập',
        color: const Color(0xFF2196F3),
        bgColor: const Color(0xFFE3F2FD),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerAttendanceScreen(initialTabIndex: 2)),
        ),
      ),
      _Feature(
        icon: Icons.bar_chart_rounded,
        label: 'Thống kê\ngiảng dạy',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerTeachingStatsScreen()),
        ),
      ),
      _Feature(
        icon: Icons.monetization_on_outlined,
        label: 'Thông tin\nlương',
        color: const Color(0xFF2E7D32),
        bgColor: const Color(0xFFE8F5E9),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerSalaryScreen()),
        ),
      ),
      _Feature(
        icon: Icons.library_books_outlined,
        label: 'Tài liệu\nbài giảng',
        color: const Color(0xFF5C6BC0),
        bgColor: const Color(0xFFE8EAF6),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerMaterialsScreen()),
        ),
      ),
      _Feature(
        icon: Icons.pending_actions_outlined,
        label: 'Đề xuất\nlịch dạy',
        color: const Color(0xFFE85D75),
        bgColor: const Color(0xFFFCE4EC),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerRequestScreen()),
        ),
      ),
      _Feature(
        icon: Icons.badge_outlined,
        label: 'Hồ sơ\ncá nhân',
        color: const Color(0xFF5C6BC0),
        bgColor: const Color(0xFFE8EAF6),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerPersonalProfileScreen()),
        ),
      ),
      _Feature(
        icon: Icons.poll_outlined,
        label: 'Khảo sát',
        color: const Color(0xFFE85D75),
        bgColor: const Color(0xFFFCE4EC),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerSurveyScreen()),
        ),
      ),
      _Feature(
        icon: Icons.calendar_today_outlined,
        label: 'Lịch dạy',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const LecturerScheduleScreen()),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const LecturerCustomAppBar(title: 'Tất cả tính năng'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: features.length,
                  itemBuilder: (_, i) {
                    final f = features[i];
                    return GestureDetector(
                      onTap: f.onTap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: f.bgColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(f.icon, color: f.color, size: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            f.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF424242),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _Feature {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _Feature({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });
}
