import 'package:flutter/material.dart';
import '../../data/mock_admin_reports_data.dart';
import 'reports_helpers.dart';

class RequestsTab extends StatelessWidget {
  const RequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(
            children: mockRequestsByStatus.map((s) {
          final col = s['color'] as Color;
          return Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [col, col.withOpacity(0.8)]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Text('${s['count']}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(s['label'] as String, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.white70)),
                    ]),
                  )));
        }).toList()),
        const SizedBox(height: 14),
        buildSectionCard(
          'Theo loại đề xuất',
          Icons.category_outlined,
          Column(
            children: mockRequestsByType.map((t) {
              final col = t['color'] as Color;
              final pct = (t['approved'] as int) / (t['count'] as int);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(t['label'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        Text('${t['approved']}/${t['count']} duyệt', style: TextStyle(fontSize: 12, color: col, fontWeight: FontWeight.w600)),
                      ]),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: pct,
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
          'Lịch sử quyết định',
          Icons.history_rounded,
          Column(
            children: mockRecentDecisions.map((d) {
              Color col;
              String label;
              IconData icon;
              switch (d['status']) {
                case 'approved':
                  col = const Color(0xFF4CAF50);
                  label = 'Đã duyệt';
                  icon = Icons.check_circle_outline;
                  break;
                case 'rejected':
                  col = const Color(0xFFC62828);
                  label = 'Từ chối';
                  icon = Icons.cancel_outlined;
                  break;
                default:
                  col = const Color(0xFFE65100);
                  label = 'Chờ duyệt';
                  icon = Icons.pending_outlined;
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFFF9F9FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEEEEEE))),
                child: Row(children: [
                  Icon(icon, color: col, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(d['type'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    Text('${d['from']}  ·  ${d['date']}', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                  ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                    child: Text(label, style: TextStyle(fontSize: 11, color: col, fontWeight: FontWeight.w600)),
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
