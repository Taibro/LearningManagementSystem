import 'package:flutter/material.dart';
import '../../data/mock_admin_reports_data.dart';
import 'reports_helpers.dart';

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        // Summary
        Row(children: [
          buildSummaryCard('96.2%', 'Tỉ lệ đi học TB', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          buildSummaryCard('5', 'Sinh viên cảnh báo', const Color(0xFFE85D75)),
          const SizedBox(width: 8),
          buildSummaryCard('312', 'Buổi đã điểm danh', const Color(0xFF1A237E)),
        ]),
        const SizedBox(height: 14),
        // By class
        buildSectionCard(
          'Tỉ lệ điểm danh theo lớp học phần',
          Icons.class_outlined,
          Column(
            children: mockClassStats.map((s) {
              final pct = (s['present'] as int) / (s['total'] as int);
              final col = pct >= 0.95
                  ? const Color(0xFF4CAF50)
                  : pct >= 0.85
                      ? const Color(0xFFE65100)
                      : const Color(0xFFC62828);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${s['class']} – ${s['subject']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text(s['lecturer'] as String, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('${(pct * 100).toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: col)),
                      Text('${s['present']}/${s['total']} SV', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                    ]),
                  ]),
                  const SizedBox(height: 6),
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
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        // Warning students
        buildSectionCard(
          'Sinh viên vắng quá 20%',
          Icons.warning_amber_outlined,
          Column(
            children: mockWarningStudents.map((s) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    const Icon(Icons.warning_amber_rounded, color: Color(0xFFC62828), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('${s['mssv']}  ·  Vắng ${s['absent']}/${s['total']} buổi', style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                    ])),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFC62828), borderRadius: BorderRadius.circular(20)),
                      child: Text('${s['pct']}%', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ]),
                )).toList(),
          ),
        ),
      ]),
    );
  }
}
