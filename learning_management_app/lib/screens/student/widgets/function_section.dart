import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../screens/student/academic_result_screen.dart';
import '../../../screens/student/achievement_screen.dart';
import '../../../screens/student/all_features_screen.dart';
import '../../../screens/student/attendance_stats_screen.dart';
import '../../../screens/student/curriculum_screen.dart';
import '../../../screens/student/customize_features_screen.dart';
import '../../../screens/student/receipt_screen.dart';
import '../../../screens/student/schedule_screen.dart';
import '../../../screens/student/features_screens/student_teacher_list_screen.dart';
import 'payment_bottom_sheet.dart';

class FunctionSection extends StatefulWidget {
  const FunctionSection({super.key});

  @override
  State<FunctionSection> createState() => _FunctionSectionState();
}

class _FunctionSectionState extends State<FunctionSection> {
  List<Map<String, dynamic>> _displayFeatures = [];

  final Map<String, Map<String, dynamic>> _allFeaturesMap = {
    'Xem điểm': {
      'icon': Icons.grade_rounded,
      'label': 'Xem điểm',
      'colors': [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const AcademicResultScreen())),
    },
    'Thành tích': {
      'icon': Icons.star_rounded,
      'label': 'Thành tích',
      'colors': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementScreen())),
    },
    'Thanh toán học phí': {
      'icon': Icons.monetization_on_outlined,
      'label': 'Thanh toán',
      'colors': [const Color(0xFF10B981), const Color(0xFF059669)],
      'onTap': (context) => PaymentBottomSheet.show(context),
    },
    'Phiếu thu tổng hợp': {
      'icon': Icons.receipt_long_outlined,
      'label': 'Phiếu thu',
      'colors': [const Color(0xFF06B6D4), const Color(0xFF0891B2)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReceiptScreen())),
    },
    'Thống kê điểm danh': {
      'icon': Icons.how_to_reg_outlined,
      'label': 'Điểm danh',
      'colors': [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceStatsScreen())),
    },
    'Chương trình khung': {
      'icon': Icons.menu_book_rounded,
      'label': 'Chương trình',
      'colors': [const Color(0xFFEF4444), const Color(0xFFDC2626)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const CurriculumScreen())),
    },
    'Lịch học/ lịch thi': {
      'icon': Icons.calendar_month_outlined,
      'label': 'Lịch học',
      'colors': [const Color(0xFFF97316), const Color(0xFFEA580C)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen())),
    },
    'Trò chuyện': {
      'icon': Icons.chat_rounded,
      'label': 'Trò chuyện',
      'colors': [const Color(0xFFE11D48), const Color(0xFFBE123C)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentTeacherListScreen())),
    },
    // Khảo sát, Tin tức, Rèn luyện can be added similarly if needed
  };

  @override
  void initState() {
    super.initState();
    _loadFeatures();
  }

  Future<void> _loadFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    final savedHomeLabels = prefs.getStringList('student_home_features');
    
    List<Map<String, dynamic>> features = [];
    if (savedHomeLabels != null) {
      for (var label in savedHomeLabels) {
        if (_allFeaturesMap.containsKey(label)) {
          features.add(_allFeaturesMap[label]!);
        }
      }
    } else {
      // Defaults
      final defaultLabels = ['Xem điểm', 'Thành tích', 'Thanh toán học phí', 'Phiếu thu tổng hợp', 'Thống kê điểm danh', 'Chương trình khung', 'Lịch học/ lịch thi'];
      for (var label in defaultLabels) {
        if (_allFeaturesMap.containsKey(label)) {
          features.add(_allFeaturesMap[label]!);
        }
      }
    }
    
    // Always append "Tất cả" at the end, regardless of user customization
    features.add({
      'icon': Icons.widgets_rounded,
      'label': 'Tất cả',
      'colors': [const Color(0xFF64748B), const Color(0xFF475569)],
      'onTap': (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllFeaturesScreen())),
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
            Text(
              'Tiện ích sinh viên',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomizeFeaturesScreen()),
                );
                // Reload when returning from customize screen
                _loadFeatures();
              },
              icon: const Icon(Icons.tune_rounded, size: 16, color: Color(0xFF64748B)),
              label: Text(
                'Tuỳ chỉnh',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                backgroundColor: const Color(0xFFF1F5F9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ).animate().fade(duration: 500.ms).slideX(begin: -0.1, end: 0),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F46E5).withOpacity(0.04),
                blurRadius: 24,
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
              mainAxisSpacing: 24,
              childAspectRatio: 0.75,
            ),
            itemCount: _displayFeatures.length,
            itemBuilder: (context, index) {
              final item = _displayFeatures[index];
              final colors = item['colors'] as List<Color>;
              final onTap = item['onTap'] as Function(BuildContext);
              return GestureDetector(
                onTap: () => onTap(context),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors[0].withOpacity(0.15), colors[1].withOpacity(0.05)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: colors[0].withOpacity(0.2), width: 1.5),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: colors[0],
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['label'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ).animate().fade(delay: (index * 50).ms, duration: 400.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
            },
          ),
        ),
      ],
    );
  }
}
