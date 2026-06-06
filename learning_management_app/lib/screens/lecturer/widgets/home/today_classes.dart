import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/mock_home_data.dart';

class TodayClasses extends StatelessWidget {
  const TodayClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Lịch dạy hôm nay',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
                letterSpacing: -0.3,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
            Text(
              'Thứ 2, 28/04/2026',
              style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
          ],
        ),
        const SizedBox(height: 16),
        ...kTodayClasses.asMap().entries.map((entry) {
          final index = entry.key;
          final cls = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildClassCard(cls)
                .animate()
                .fadeIn(duration: 400.ms, delay: (100 * index).ms)
                .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuart),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildClassCard(Map<String, dynamic> cls) {
    Color accentColor;
    Color bgColor;
    IconData typeIcon;
    String typeLabel;

    switch (cls['type']) {
      case 'practice':
        accentColor = const Color(0xFF4F46E5);
        bgColor = const Color(0xFF4F46E5).withOpacity(0.08);
        typeIcon = Icons.computer_outlined;
        typeLabel = 'Thực hành';
        break;
      case 'online':
        accentColor = const Color(0xFFE85D75);
        bgColor = const Color(0xFFE85D75).withOpacity(0.08);
        typeIcon = Icons.video_call_outlined;
        typeLabel = 'Trực tuyến';
        break;
      default:
        accentColor = const Color(0xFF10B981);
        bgColor = const Color(0xFF10B981).withOpacity(0.08);
        typeIcon = Icons.menu_book_outlined;
        typeLabel = 'Lý thuyết';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 5,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: accentColor.withOpacity(0.1), width: 1),
                        ),
                        child: Icon(typeIcon, color: accentColor, size: 26),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cls['subject'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Color(0xFF1E293B),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cls['classCode'],
                              style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.location_on_rounded, size: 12, color: accentColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        cls['room'],
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: accentColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    typeLabel,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cls['session'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cls['time'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B4FA0),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Material(
                            color: const Color(0xFF6B4FA0),
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(8),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                child: Text(
                                  'Vào điểm danh',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
