import 'package:flutter/material.dart';
import '../../../screens/student/academic_result_screen.dart';
import '../../../screens/student/achievement_screen.dart';
import '../../../screens/student/all_features_screen.dart';
import '../../../screens/student/attendance_stats_screen.dart';
import '../../../screens/student/curriculum_screen.dart';
import '../../../screens/student/customize_features_screen.dart';
import '../../../screens/student/receipt_screen.dart';
import '../../../screens/student/schedule_screen.dart';
import 'payment_bottom_sheet.dart';

class FunctionSection extends StatelessWidget {
  const FunctionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.grade_rounded,
        'label': 'Xem điểm',
        'color': const Color(0xFF1565C0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AcademicResultScreen()),
            ),
      },
      {
        'icon': Icons.star_rounded,
        'label': 'Thành tích',
        'color': const Color(0xFFE65100),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AchievementScreen()),
            ),
      },
      {
        'icon': Icons.monetization_on_outlined,
        'label': 'Thanh toán\nhọc phí',
        'color': const Color(0xFF2E7D32),
        'onTap': () => PaymentBottomSheet.show(context),
      },
      {
        'icon': Icons.receipt_long_outlined,
        'label': 'Phiếu thu\ntổng hợp',
        'color': const Color(0xFF00695C),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReceiptScreen()),
            ),
      },
      {
        'icon': Icons.how_to_reg_outlined,
        'label': 'Thống kê\nđiểm danh',
        'color': const Color(0xFF1565C0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AttendanceStatsScreen()),
            ),
      },
      {
        'icon': Icons.menu_book_rounded,
        'label': 'Chương trình\nkhung',
        'color': const Color(0xFFC62828),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CurriculumScreen()),
            ),
      },
      {
        'icon': Icons.calendar_month_outlined,
        'label': 'Lịch học/\nlịch thi',
        'color': const Color(0xFFE65100),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ScheduleScreen()),
            ),
      },
      {
        'icon': Icons.grid_view_rounded,
        'label': 'Tất cả',
        'color': const Color(0xFF1565C0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AllFeaturesScreen()),
            ),
      },
    ];

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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomizeFeaturesScreen()),
              ),
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
        Container(
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
            itemCount: features.length,
            itemBuilder: (context, index) {
              final item = features[index];
              final color = item['color'] as Color;
              final onTap = item['onTap'] as VoidCallback;
              return GestureDetector(
                onTap: onTap,
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
                      child: Icon(
                        item['icon'] as IconData,
                        color: color,
                        size: 28,
                      ),
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
