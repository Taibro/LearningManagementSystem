import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/mock_admin_reports_data.dart';
import 'reports_helpers.dart';

class GradesTab extends StatelessWidget {
  const GradesTab({super.key});

  @override
  Widget build(BuildContext context) {
    const kPrimary = Color(0xFF3F51B5);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(children: [
        Row(children: [
          buildSummaryCard('7.4', 'Điểm TB toàn trường', kPrimary),
          const SizedBox(width: 8),
          buildSummaryCard('92%', 'Tỉ lệ đạt', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          buildSummaryCard('1195', 'Tổng sinh viên', const Color(0xFFE65100)),
        ]).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 20),
        buildSectionCard(
          'Phân bố kết quả học tập',
          Icons.bar_chart_rounded,
          Column(
            children: mockDistribution.asMap().entries.map((entry) {
              final idx = entry.key;
              final d = entry.value;
              final col = d['color'] as Color;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: col.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: col.withOpacity(0.1)),
                ),
                child: Row(children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: col.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text(d['label'].toString().substring(0, 1), style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 16))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(d['label'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                        Text('${d['count']} SV  (${((d['pct'] as double) * 100).toInt()}%)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: col)),
                      ]),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: d['pct'] as double,
                          backgroundColor: col.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(col),
                          minHeight: 8,
                        ),
                      ),
                    ]),
                  ),
                ]),
              ).animate().fade(delay: (200 + idx * 100).ms).slideX(begin: 0.1, end: 0);
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        buildSectionCard(
          'Lớp có điểm TB cao nhất',
          Icons.emoji_events_rounded,
          Column(
            children: mockTopClasses.asMap().entries.map((e) {
              final idx = e.key;
              final c = e.value;
              final medals = ['🥇', '🥈', '🥉'];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kPrimary.withOpacity(0.08)),
                ),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
                    ),
                    child: Text(medals[idx], style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${c['class']} – ${c['subject']}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1E293B))),
                      const SizedBox(height: 2),
                      Text('Đạt: ${c['passed']}%', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: Text('ĐTB: ${c['avg']}', style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ]),
              ).animate().fade(delay: (400 + idx * 100).ms).slideY(begin: 0.1, end: 0);
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
