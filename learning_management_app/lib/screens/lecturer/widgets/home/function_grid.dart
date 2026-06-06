import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../lecturer_attendance_screen.dart';
import '../../lecturer_teaching_stats_screen.dart';
import '../../lecturer_salary_screen.dart';
import '../../lecturer_materials_screen.dart';
import '../../lecturer_request_screen.dart';
import '../../lecturer_all_features_screen.dart';

class FunctionGrid extends StatelessWidget {
  const FunctionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.how_to_reg_rounded,
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
        'color': const Color(0xFF10B981),
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
        'color': const Color(0xFF3B82F6),
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
        'color': const Color(0xFFF59E0B),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerTeachingStatsScreen()),
            ),
      },
      {
        'icon': Icons.account_balance_wallet_rounded,
        'label': 'Thông tin\nlương',
        'color': const Color(0xFF2E7D32),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerSalaryScreen()),
            ),
      },
      {
        'icon': Icons.library_books_rounded,
        'label': 'Tài liệu\nbài giảng',
        'color': const Color(0xFF5C6BC0),
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const LecturerMaterialsScreen()),
            ),
      },
      {
        'icon': Icons.edit_document,
        'label': 'Đề xuất\nlịch dạy',
        'color': const Color(0xFFEC4899),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tiện ích',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
                letterSpacing: -0.3,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.tune_rounded, size: 16, color: Color(0xFF64748B)),
              label: const Text(
                'Tuỳ chỉnh',
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B4FA0).withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
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
              childAspectRatio: 0.75,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final item = features[index];
              return _buildGridItem(
                icon: item['icon'] as IconData,
                label: item['label'] as String,
                color: item['color'] as Color,
                onTap: item['onTap'] as VoidCallback,
                index: index,
              );
            },
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.15), width: 1.5),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF334155),
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).animate().scale(
      duration: 300.ms,
      delay: (50 * index).ms,
      curve: Curves.easeOutBack,
    );
  }
}
