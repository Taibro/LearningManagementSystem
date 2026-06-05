import 'package:flutter/material.dart';
import '../../lecturer_attendance_screen.dart';
import '../../features/qr_code_screen.dart';
import '../../features/grades_screen.dart';
import '../../features/teaching_stats_screen.dart';
import '../../features/salary_info_screen.dart';
import '../../features/lecture_materials_screen.dart';
import '../../features/schedule_proposal_screen.dart';
import '../../features/feedback_screen.dart';
import '../../features/terms_screen.dart';
import '../../features/change_password_screen.dart';
import '../../features/profile_detail_screen.dart';
import '../../features/survey_screen.dart';
import '../../features/request_pause_screen.dart';
import '../../features/request_substitute_screen.dart';
import '../../features/request_makeup_screen.dart';

class FunctionGrid extends StatefulWidget {
  const FunctionGrid({super.key});

  @override
  State<FunctionGrid> createState() => _FunctionGridState();
}

class _FunctionGridState extends State<FunctionGrid> {
  bool _isExpanded = false;

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allFeatures = [
      {'icon': Icons.how_to_reg_outlined, 'label': 'Điểm danh', 'color': const Color(0xFF6B4FA0), 'screen': LecturerAttendanceScreen()},
      {'icon': Icons.qr_code_2_rounded, 'label': 'QR Code', 'color': const Color(0xFF4CAF50), 'screen': QrCodeScreen()},
      {'icon': Icons.grade_rounded, 'label': 'Kết quả\nhọc tập', 'color': const Color(0xFF2196F3), 'screen': GradesScreen()},
      {'icon': Icons.bar_chart_rounded, 'label': 'Thống kê\ngiảng dạy', 'color': const Color(0xFFE65100), 'screen': TeachingStatsScreen()},
      {'icon': Icons.monetization_on_outlined, 'label': 'Thông tin\nlương', 'color': const Color(0xFF2E7D32), 'screen': SalaryInfoScreen()},
      {'icon': Icons.library_books_outlined, 'label': 'Tài liệu\nbài giảng', 'color': const Color(0xFF5C6BC0), 'screen': LectureMaterialsScreen()},
      {'icon': Icons.pending_actions_outlined, 'label': 'Đề xuất\nlịch dạy', 'color': const Color(0xFFE85D75), 'screen': ScheduleProposalScreen()},
      
      {'icon': Icons.badge_outlined, 'label': 'Hồ sơ\ncá nhân', 'color': const Color(0xFF5C6BC0), 'screen': ProfileDetailScreen()},
      {'icon': Icons.poll_outlined, 'label': 'Khảo sát', 'color': const Color(0xFFE85D75), 'screen': SurveyScreen()},
      {'icon': Icons.pause_circle_outline_rounded, 'label': 'Đề xuất\nngừng dạy', 'color': const Color(0xFFF5A623), 'screen': RequestPauseScreen()},
      {'icon': Icons.swap_horiz_rounded, 'label': 'Đề xuất\ndạy thay', 'color': const Color(0xFF1565C0), 'screen': RequestSubstituteScreen()},
      {'icon': Icons.add_circle_outline_rounded, 'label': 'Đề xuất\ndạy bù', 'color': const Color(0xFF4CAF50), 'screen': RequestMakeupScreen()},
      {'icon': Icons.lock_outline_rounded, 'label': 'Đổi\nmật khẩu', 'color': const Color(0xFFE53935), 'screen': ChangePasswordScreen()},
      {'icon': Icons.feedback_outlined, 'label': 'Góp ý\nứng dụng', 'color': const Color(0xFF00897B), 'screen': FeedbackScreen()},
      {'icon': Icons.policy_outlined, 'label': 'Điều khoản\nchính sách', 'color': const Color(0xFF455A64), 'screen': TermsScreen()},
    ];

    final displayedFeatures = _isExpanded ? allFeatures : allFeatures.take(7).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Chức năng',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.tune, size: 16, color: Color(0xFF616161)),
              label: const Text(
                'Tuỳ chỉnh',
                style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: displayedFeatures.length + 1,
            itemBuilder: (context, index) {
              if (index == displayedFeatures.length) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B4FA0).withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isExpanded ? Icons.expand_less_rounded : Icons.grid_view_rounded,
                          color: const Color(0xFF6B4FA0),
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _isExpanded ? 'Thu gọn' : 'Tất cả',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF424242),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final item = displayedFeatures[index];
              final color = item['color'] as Color;
              return GestureDetector(
                onTap: () {
                  if (item['screen'] != null) {
                    _navigateTo(context, item['screen'] as Widget);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'] as IconData, color: color, size: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
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
      ],
    );
  }
}
