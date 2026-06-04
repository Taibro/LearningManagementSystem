import 'package:flutter/material.dart';
import 'settings_helpers.dart';
import 'bottom_sheets/new_semester_sheet.dart';

class SemesterCard extends StatelessWidget {
  const SemesterCard({super.key});

  @override
  Widget build(BuildContext context) {
    const kPrimary = Color(0xFF1A237E);
    return buildSettingsCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildSectionTitle('Quản lý học kỳ', Icons.school_outlined),
        const SizedBox(height: 14),
        // Current semester info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient:
                const LinearGradient(colors: [Color(0xFF0D1B6E), kPrimary]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            const Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Học kỳ hiện tại',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('HK2 - 2025-2026',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('28/01/2026 – 31/05/2026',
                      style: TextStyle(color: Colors.white60, fontSize: 11)),
                ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text('Đang diễn ra',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
        ),
        const SizedBox(height: 14),
        // Semester actions
        Row(children: [
          Expanded(
              child: buildActionBtn('Tạo HK mới', const Color(0xFF4CAF50),
                  Icons.add_circle_outline, () => _showNewSemesterSheet(context))),
          const SizedBox(width: 10),
          Expanded(
              child: buildActionBtn('Kết thúc HK', const Color(0xFFC62828),
                  Icons.stop_circle_outlined, () => _showEndSemesterDialog(context))),
        ]),
        const SizedBox(height: 10),
        // Semester history
        const Text('Lịch sử học kỳ',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242))),
        const SizedBox(height: 8),
        ...[
          {'sem': 'HK1 - 2025-2026', 'period': '08/2025 – 01/2026', 'status': 'done'},
          {'sem': 'HK2 - 2024-2025', 'period': '01/2025 – 06/2025', 'status': 'done'},
        ].map((s) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Row(children: [
                const Icon(Icons.check_circle_outline,
                    color: Color(0xFF9E9E9E), size: 16),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(s['sem']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13)),
                      Text(s['period']!,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF9E9E9E))),
                    ])),
                const Text('Kết thúc',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              ]),
            )),
      ]),
    );
  }

  void _showNewSemesterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NewSemesterSheet(),
    );
  }

  void _showEndSemesterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text('Kết thúc học kỳ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              content: const Text(
                'Xác nhận kết thúc HK2 - 2025-2026?\n\nThao tác này sẽ khoá toàn bộ việc chỉnh sửa lịch và điểm số.',
                style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Huỷ',
                        style: TextStyle(color: Color(0xFF616161)))),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC62828),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Kết thúc HK'),
                ),
              ],
            ));
  }
}
