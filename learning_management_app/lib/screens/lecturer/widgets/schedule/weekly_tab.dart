import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(7, (dayIndex) {
                final classes = kWeekSchedule[dayIndex] ?? [];
                return _buildDayRow(dayIndex, classes);
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => setState(() => _weekOffset--),
            icon: const Icon(Icons.chevron_left, color: Color(0xFF6B4FA0)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Text(
              'Tuần ${20 + _weekOffset}/04 – ${26 + _weekOffset}/04/2026',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF212121),
              ),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _weekOffset++),
            icon: const Icon(Icons.chevron_right, color: Color(0xFF6B4FA0)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => setState(() => _weekOffset = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF6B4FA0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Hôm nay',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final items = [
      {'color': const Color(0xFF4CAF50), 'label': 'Lý thuyết'},
      {'color': const Color(0xFF5C6BC0), 'label': 'Thực hành'},
      {'color': const Color(0xFFE65100), 'label': 'Trực tuyến'},
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  item['label'] as String,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF616161)),
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
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isToday
            ? Border.all(color: const Color(0xFF6B4FA0), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isToday
                  ? const Color(0xFF6B4FA0).withOpacity(0.08)
                  : const Color(0xFFF9F7FF),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Text(
                  kWeekDays[dayIndex],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isToday
                        ? const Color(0xFF6B4FA0)
                        : const Color(0xFF424242),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  kWeekDates[dayIndex],
                  style: TextStyle(
                    fontSize: 12,
                    color: isToday
                        ? const Color(0xFF6B4FA0)
                        : Colors.grey[500],
                  ),
                ),
                if (isToday) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B4FA0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Hôm nay',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  '${classes.length} buổi',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (classes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Không có lịch dạy',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: classes
                    .map((cls) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
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
        color = const Color(0xFF5C6BC0);
        bgColor = const Color(0xFFE8EAF6);
        break;
      case 'online':
        color = const Color(0xFFE65100);
        bgColor = const Color(0xFFFFF3E0);
        break;
      default:
        color = const Color(0xFF2E7D32);
        bgColor = const Color(0xFFE8F5E9);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cls['subject'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cls['code'],
                  style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 11, color: color),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        cls['room'],
                        style: TextStyle(
                            fontSize: 11, color: color.withOpacity(0.9)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              cls['session'],
              style: TextStyle(
                  fontSize: 11, color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
