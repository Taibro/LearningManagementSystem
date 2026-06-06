import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/mock_schedule_data.dart';

class WeeklyTab extends StatefulWidget {
  const WeeklyTab({super.key});

  @override
  State<WeeklyTab> createState() => _WeeklyTabState();
}

class _WeeklyTabState extends State<WeeklyTab> {
  int _weekOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWeekNavigator(),
        _buildLegend(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
            child: Column(
              children: List.generate(7, (dayIndex) {
                final classes = kWeekSchedule[dayIndex] ?? [];
                return _buildDayRow(dayIndex, classes)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (50 * dayIndex).ms)
                    .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuart);
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekNavigator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _weekOffset--),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.chevron_left_rounded, color: Color(0xFF6B4FA0), size: 24),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Tuần ${20 + _weekOffset}/04 – ${26 + _weekOffset}/04/2026',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF1E293B),
                letterSpacing: -0.2,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _weekOffset++),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.chevron_right_rounded, color: Color(0xFF6B4FA0), size: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: const Color(0xFF6B4FA0).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => setState(() => _weekOffset = 0),
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(
                  'Hôm nay',
                  style: TextStyle(
                    color: Color(0xFF6B4FA0),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final items = [
      {'color': const Color(0xFF10B981), 'label': 'Lý thuyết'},
      {'color': const Color(0xFF3B82F6), 'label': 'Thực hành'},
      {'color': const Color(0xFFF59E0B), 'label': 'Trực tuyến'},
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  item['label'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayRow(int dayIndex, List<Map<String, dynamic>> classes) {
    final isToday = dayIndex == 0; // Monday = today (demo)
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isToday ? const Color(0xFF6B4FA0) : const Color(0xFFF1F5F9),
          width: isToday ? 2 : 1.5,
        ),
        boxShadow: [
          if (isToday)
            BoxShadow(
              color: const Color(0xFF6B4FA0).withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isToday
                  ? const Color(0xFF6B4FA0).withOpacity(0.08)
                  : const Color(0xFFF8FAFC),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Text(
                  kWeekDays[dayIndex],
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: isToday ? const Color(0xFF6B4FA0) : const Color(0xFF1E293B),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  kWeekDates[dayIndex],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isToday ? const Color(0xFF6B4FA0).withOpacity(0.8) : const Color(0xFF64748B),
                  ),
                ),
                if (isToday) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B4FA0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Hôm nay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  '${classes.length} buổi',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (classes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Không có lịch dạy',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: classes
                    .map((cls) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildScheduleChip(cls),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleChip(Map<String, dynamic> cls) {
    Color color;
    Color bgColor;
    switch (cls['type']) {
      case 'practice':
        color = const Color(0xFF3B82F6);
        bgColor = const Color(0xFF3B82F6).withOpacity(0.08);
        break;
      case 'online':
        color = const Color(0xFFF59E0B);
        bgColor = const Color(0xFFF59E0B).withOpacity(0.08);
        break;
      default:
        color = const Color(0xFF10B981);
        bgColor = const Color(0xFF10B981).withOpacity(0.08);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cls['subject'],
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: color.withOpacity(0.9),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cls['code'],
                    style: TextStyle(
                      fontSize: 12,
                      color: color.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: 14, color: color),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          cls['room'],
                          style: TextStyle(
                            fontSize: 12,
                            color: color.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                cls['session'],
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
