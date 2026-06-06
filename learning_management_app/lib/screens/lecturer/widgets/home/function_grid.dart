import 'package:flutter/material.dart';
import '../../lecturer_attendance_screen.dart';
import '../../lecturer_teaching_stats_screen.dart';
import '../../lecturer_salary_screen.dart';
import '../../lecturer_materials_screen.dart';
import '../../lecturer_request_screen.dart';
import '../../lecturer_all_features_screen.dart';

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

    final features = [
      {
        'icon': Icons.how_to_reg_outlined,
        'label': 'Điểm danh',
        'color': const Color(0xFF6B4FA0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      const LecturerAttendanceScreen(initialTabIndex: 0)),
            ),
      },
      {
        'icon': Icons.qr_code_2_rounded,
        'label': 'QR Code',
        'color': const Color(0xFF4CAF50),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      const LecturerAttendanceScreen(initialTabIndex: 1)),
            ),
      },
      {
        'icon': Icons.grade_rounded,
        'label': 'Kết quả\nhọc tập',
        'color': const Color(0xFF2196F3),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      const LecturerAttendanceScreen(initialTabIndex: 2)),
            ),
      },
      {
        'icon': Icons.bar_chart_rounded,
        'label': 'Thống kê\ngiảng dạy',
        'color': const Color(0xFFE65100),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerTeachingStatsScreen()),
            ),
      },
      {
        'icon': Icons.monetization_on_outlined,
        'label': 'Thông tin\nlương',
        'color': const Color(0xFF2E7D32),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerSalaryScreen()),
            ),
      },
      {
        'icon': Icons.library_books_outlined,
        'label': 'Tài liệu\nbài giảng',
        'color': const Color(0xFF5C6BC0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerMaterialsScreen()),
            ),
      },
      {
        'icon': Icons.pending_actions_outlined,
        'label': 'Đề xuất\nlịch dạy',
        'color': const Color(0xFFE85D75),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerRequestScreen()),
            ),
      },
      {
        'icon': Icons.grid_view_rounded,
        'label': 'Tất cả',
        'color': const Color(0xFF6B4FA0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerAllFeaturesScreen()),
            ),
      },

    ];
    final displayedFeatures = _isExpanded ? features : features.take(7).toList();

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
