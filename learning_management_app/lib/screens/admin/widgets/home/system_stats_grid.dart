import 'package:flutter/material.dart';
import '../../../../models/admin/dashboard_stats.dart';

class SystemStatsGrid extends StatelessWidget {
  final DashboardStats stats;
  const SystemStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final cards = [
      {'label': 'Sinh viên',   'value': '${stats.totalStudents ?? 0}', 'icon': Icons.school_outlined,       'color': const Color(0xFF1A237E)},
      {'label': 'Giảng viên',  'value': '${stats.totalTeachers ?? 0}',   'icon': Icons.person_outlined,        'color': const Color(0xFF2E7D32)},
      {'label': 'Lớp học phần','value': '${stats.totalClasses ?? 0}',   'icon': Icons.class_outlined,         'color': const Color(0xFFE65100)},
      {'label': 'Vắng hôm nay',   'value': '${stats.todayAbsences ?? 0}',    'icon': Icons.meeting_room_outlined,  'color': const Color(0xFFE85D75)},
    ];
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.8,
      ),
      itemCount: cards.length,
      itemBuilder: (_, i) {
        final c = cards[i];
        final col = c['color'] as Color;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: col.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(c['icon'] as IconData, color: col, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(c['value'] as String, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: col)),
                Text(c['label'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
              ],
            )),
          ]),
        );
      },
    );
  }
}
