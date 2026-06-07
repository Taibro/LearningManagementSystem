import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/mock_admin_reports_data.dart';
import 'reports_helpers.dart';

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(children: [
        // Summary
        Row(children: [
          buildSummaryCard('96.2%', 'Tỉ lệ đi học TB', const Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          buildSummaryCard('5', 'Sinh viên cảnh báo', const Color(0xFFE85D75)),
          const SizedBox(width: 8),
          buildSummaryCard('312', 'Buổi đã điểm danh', const Color(0xFF3F51B5)),
        ]).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 20),
        // By class
        buildSectionCard(
          'Tỉ lệ điểm danh theo lớp học phần',
          Icons.class_outlined,
          Column(
            children: mockClassStats.asMap().entries.map((entry) {
              final idx = entry.key;
              final s = entry.value;
              final pct = (s['present'] as int) / (s['total'] as int);
              final col = pct >= 0.95
                  ? const Color(0xFF4CAF50)
                  : pct >= 0.85
                      ? const Color(0xFFE65100)
                      : const Color(0xFFC62828);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: col.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: col.withOpacity(0.1)),
                ),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${s['class']} – ${s['subject']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                      const SizedBox(height: 2),
                      Text(s['lecturer'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('${(pct * 100).toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: col)),
                      Text('${s['present']}/${s['total']} SV', style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    ]),
                  ]),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: col.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(col),
                      minHeight: 8,
                    ),
                  ),
                ]),
              ).animate().fade(delay: (200 + idx * 100).ms).slideX(begin: 0.1, end: 0);
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        // Warning students
        buildSectionCard(
          'Sinh viên vắng quá 20%',
          Icons.warning_amber_rounded,
          Column(
            children: mockWarningStudents.asMap().entries.map((entry) {
              final idx = entry.key;
              final s = entry.value;
              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC62828).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC62828).withOpacity(0.15)),
                  ),
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: const Color(0xFFC62828).withOpacity(0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFC62828), size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1E293B))),
                      const SizedBox(height: 2),
                      Text('${s['mssv']}  ·  Vắng ${s['absent']}/${s['total']} buổi', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    ])),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFFC62828), borderRadius: BorderRadius.circular(20), boxShadow: [
                        BoxShadow(color: const Color(0xFFC62828).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))
                      ]),
                      child: Text('${s['pct']}%', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
