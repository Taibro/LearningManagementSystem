import 'package:flutter/material.dart';
import '../../data/mock_admin_reports_data.dart';
import 'reports_helpers.dart';

class TeachingTab extends StatelessWidget {
  const TeachingTab({super.key});

  @override
  Widget build(BuildContext context) {
    const kPrimary = Color(0xFF1A237E);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: [
          buildSummaryCard('342/450', 'Tiết đã dạy / KH', kPrimary),
          const SizedBox(width: 8),
          buildSummaryCard('27', 'Tiết vượt KH', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          buildSummaryCard('10', 'Buổi coi thi', const Color(0xFFE65100)),
        ]),
        const SizedBox(height: 14),
        buildSectionCard(
          'Thống kê giảng viên',
          Icons.person_outlined,
          Column(children: [
            // Table header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(color: kPrimary.withOpacity(0.06), borderRadius: BorderRadius.circular(8)),
              child: const Row(children: [
                Expanded(flex: 3, child: Text('Giảng viên', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kPrimary))),
                SizedBox(width: 50, child: Text('KH', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kPrimary))),
                SizedBox(width: 50, child: Text('Thực', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kPrimary))),
                SizedBox(width: 50, child: Text('Vượt', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kPrimary))),
              ]),
            ),
            const SizedBox(height: 8),
            ...mockLecturerStats.asMap().entries.map((e) {
              final idx = e.key;
              final l = e.value;
              final pct = (l['done'] as int) / (l['planned'] as int);
              final col = pct >= 1.0
                  ? const Color(0xFF4CAF50)
                  : pct >= 0.7
                      ? kPrimary
                      : const Color(0xFFE65100);
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: idx.isEven ? const Color(0xFFF9F9FF) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        flex: 3,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(l['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                          Text(l['code'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
                        ])),
                    SizedBox(width: 50, child: Text('${l['planned']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                    SizedBox(
                        width: 50,
                        child: Text('${l['done']}', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: col))),
                    SizedBox(
                        width: 50,
                        child: Text(
                          (l['extra'] as int) > 0 ? '+${l['extra']}' : '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: (l['extra'] as int) > 0 ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E)),
                        )),
                  ]),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct.clamp(0.0, 1.0),
                      backgroundColor: const Color(0xFFE8E8F0),
                      valueColor: AlwaysStoppedAnimation<Color>(col),
                      minHeight: 5,
                    ),
                  ),
                ]),
              );
            }).toList(),
          ]),
        ),
      ]),
    );
  }
}
