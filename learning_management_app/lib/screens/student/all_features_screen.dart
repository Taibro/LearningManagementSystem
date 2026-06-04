import 'package:flutter/material.dart';
import 'academic_result_screen.dart';
import 'achievement_screen.dart';
import 'attendance_stats_screen.dart';
import 'curriculum_screen.dart';
import 'receipt_screen.dart';
import 'schedule_screen.dart';
import 'widgets/payment_bottom_sheet.dart';
import 'widgets/shared/custom_app_bar.dart';

const Color _kBg = Color(0xFFF0F4FF);

class AllFeaturesScreen extends StatelessWidget {
  const AllFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      _Feature(
        icon: Icons.grade_rounded,
        label: 'Xem điểm',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AcademicResultScreen()),
        ),
      ),
      _Feature(
        icon: Icons.monetization_on_outlined,
        label: 'Thanh toán\nhọc phí',
        color: const Color(0xFF2E7D32),
        bgColor: const Color(0xFFE8F5E9),
        onTap: () {
          Navigator.pop(context);
          PaymentBottomSheet.show(context);
        },
      ),
      _Feature(
        icon: Icons.star_rounded,
        label: 'Thành tích',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AchievementScreen()),
        ),
      ),
      _Feature(
        icon: Icons.receipt_long_outlined,
        label: 'Phiếu thu\ntổng hợp',
        color: const Color(0xFF00695C),
        bgColor: const Color(0xFFE0F2F1),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ReceiptScreen()),
        ),
      ),
      _Feature(
        icon: Icons.menu_book_rounded,
        label: 'Chương trình\nkhung',
        color: const Color(0xFFC62828),
        bgColor: const Color(0xFFFFEBEE),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CurriculumScreen()),
        ),
      ),
      _Feature(
        icon: Icons.calendar_month_outlined,
        label: 'Lịch học/\nlịch thi',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ScheduleScreen()),
        ),
      ),
      _Feature(
        icon: Icons.how_to_reg_outlined,
        label: 'Thống kê\nđiểm danh',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AttendanceStatsScreen()),
        ),
      ),
      _Feature(
        icon: Icons.emoji_events_outlined,
        label: 'Rèn luyện',
        color: const Color(0xFFC62828),
        bgColor: const Color(0xFFFFEBEE),
        onTap: () {},
      ),
      _Feature(
        icon: Icons.article_outlined,
        label: 'Tin tức',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
        onTap: () {},
      ),
      _Feature(
        icon: Icons.poll_outlined,
        label: 'Khảo sát',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
        onTap: () {},
      ),
    ];

    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Tất cả tính năng',
            isGradient: true,
            paddingBottom: 24,
            fontSize: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
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
