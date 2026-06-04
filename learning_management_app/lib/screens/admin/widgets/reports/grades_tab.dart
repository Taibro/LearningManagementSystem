import 'package:flutter/material.dart';
import '../../data/mock_admin_reports_data.dart';
import 'reports_helpers.dart';

class GradesTab extends StatelessWidget {
  const GradesTab({super.key});

  @override
  Widget build(BuildContext context) {
    const kPrimary = Color(0xFF1A237E);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: [
          buildSummaryCard('7.4', 'Điểm TB toàn trường', kPrimary),
          const SizedBox(width: 8),
          buildSummaryCard('92%', 'Tỉ lệ đạt', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          buildSummaryCard('1195', 'Tổng sinh viên', const Color(0xFFE65100)),
        ]),
        const SizedBox(height: 14),
        buildSectionCard(
          'Phân bố kết quả học tập',
          Icons.bar_chart_rounded,
          Column(
            children: mockDistribution.map((d) {
              final col = d['color'] as Color;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(d['label'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF424242))),
                        Text('${d['count']} SV  (${((d['pct'] as double) * 100).toInt()}%)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: col)),
                      ]),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: d['pct'] as double,
                          backgroundColor: const Color(0xFFE8E8F0),
                          valueColor: AlwaysStoppedAnimation<Color>(col),
                          minHeight: 7,
                        ),
                      ),
                    ]),
                  ),
                ]),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        buildSectionCard(
          'Lớp có điểm TB cao nhất',
          Icons.emoji_events_outlined,
          Column(
            children: mockTopClasses.asMap().entries.map((e) {
              final idx = e.key;
              final c = e.value;
              final medals = ['🥇', '🥈', '🥉'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  Text(medals[idx], style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${c['class']} – ${c['subject']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('Đạt: ${c['passed']}%', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: kPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                    child: Text('ĐTB: ${c['avg']}', style: const TextStyle(fontSize: 13, color: kPrimary, fontWeight: FontWeight.bold)),
                  ),
                ]),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
