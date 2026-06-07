import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../lecturer_attendance_screen.dart';
import '../../lecturer_teaching_stats_screen.dart';
import '../../lecturer_salary_screen.dart';
import '../../lecturer_materials_screen.dart';
import '../../lecturer_request_screen.dart';
import '../../lecturer_all_features_screen.dart';
import '../../lecturer_customize_features_screen.dart';
import '../../features_screens/lecturer_chat_list_screen.dart';

class FunctionGrid extends StatefulWidget {
  const FunctionGrid({super.key});

  @override
  State<FunctionGrid> createState() => _FunctionGridState();
}

class _FunctionGridState extends State<FunctionGrid> {
  List<Map<String, dynamic>> _displayFeatures = [];

  final Map<String, Map<String, dynamic>> _allFeaturesMap = {
    'Điểm danh': {
      'icon': Icons.how_to_reg_rounded,
      'label': 'Điểm danh',
      'color': const Color(0xFF6B4FA0),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerAttendanceScreen(initialTabIndex: 0))),
    },
    'QR Code': {
      'icon': Icons.qr_code_2_rounded,
      'label': 'QR Code',
      'color': const Color(0xFF10B981),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerAttendanceScreen(initialTabIndex: 1))),
    },
    'Kết quả\nhọc tập': {
      'icon': Icons.grade_rounded,
      'label': 'Kết quả\nhọc tập',
      'color': const Color(0xFF3B82F6),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerAttendanceScreen(initialTabIndex: 2))),
    },
    'Thống kê\ngiảng dạy': {
      'icon': Icons.bar_chart_rounded,
      'label': 'Thống kê\ngiảng dạy',
      'color': const Color(0xFFF59E0B),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerTeachingStatsScreen())),
    },
    'Thông tin\nlương': {
      'icon': Icons.account_balance_wallet_rounded,
      'label': 'Thông tin\nlương',
      'color': const Color(0xFF2E7D32),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerSalaryScreen())),
    },
    'Tài liệu\nbài giảng': {
      'icon': Icons.library_books_rounded,
      'label': 'Tài liệu\nbài giảng',
      'color': const Color(0xFF5C6BC0),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerMaterialsScreen())),
    },
    'Đề xuất\nlịch dạy': {
      'icon': Icons.edit_document,
      'label': 'Đề xuất\nlịch dạy',
      'color': const Color(0xFFEC4899),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerRequestScreen())),
    },
    'Trò chuyện': {
      'icon': Icons.chat_rounded,
      'label': 'Trò chuyện',
      'color': const Color(0xFFE11D48),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerChatListScreen())),
    },
  };

  @override
  void initState() {
    super.initState();
    _loadFeatures();
  }

  Future<void> _loadFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    final savedHomeLabels = prefs.getStringList('lecturer_home_features');
    
    List<Map<String, dynamic>> features = [];
    if (savedHomeLabels != null) {
      for (var label in savedHomeLabels) {
        if (_allFeaturesMap.containsKey(label)) {
          features.add(_allFeaturesMap[label]!);
        }
      }
    } else {
      // Defaults
      final defaultLabels = ['Điểm danh', 'QR Code', 'Kết quả\nhọc tập', 'Thống kê\ngiảng dạy', 'Thông tin\nlương', 'Tài liệu\nbài giảng', 'Đề xuất\nlịch dạy'];
      for (var label in defaultLabels) {
        if (_allFeaturesMap.containsKey(label)) {
          features.add(_allFeaturesMap[label]!);
        }
      }
    }
    
    // Always append "Tất cả" at the end
    features.add({
      'icon': Icons.grid_view_rounded,
      'label': 'Tất cả',
      'color': const Color(0xFF6B4FA0),
      'onTap': (BuildContext ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LecturerAllFeaturesScreen())),
    });

    setState(() {
      _displayFeatures = features;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LecturerCustomizeFeaturesScreen()),
                );
                _loadFeatures();
              },
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
          child: _displayFeatures.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: _displayFeatures.length,
            itemBuilder: (context, index) {
              final item = _displayFeatures[index];
              return _buildGridItem(
                context: context,
                icon: item['icon'] as IconData,
                label: item['label'] as String,
                color: item['color'] as Color,
                onTap: () {
                  final fn = item['onTap'] as Function(BuildContext);
                  fn(context);
                },
                index: index,
              );
            },
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildGridItem({
    required BuildContext context,
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
