import 'package:flutter/material.dart';
import 'settings_sheet_helpers.dart';

class RoomConfigSheet extends StatelessWidget {
  const RoomConfigSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        buildSheetHandle(),
        buildSheetHeader('Cấu hình phòng học', Icons.meeting_room_outlined),
        Expanded(
            child: ListView(padding: const EdgeInsets.all(16), children: [
          ...[
            {'id': 'A101', 'cap': '60', 'status': 'Hoạt động'},
            {'id': 'A107', 'cap': '30', 'status': 'Hoạt động'},
            {'id': 'A202', 'cap': '60', 'status': 'Hoạt động'},
            {'id': 'B407', 'cap': '50', 'status': 'Bảo trì'},
          ].map((r) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: Row(children: [
                  const Icon(Icons.meeting_room_outlined,
                      color: Color(0xFF1A237E), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Phòng ${r['id']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('Sức chứa: ${r['cap']}  ·  ${r['status']}',
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF9E9E9E))),
                      ])),
                  Icon(Icons.edit_outlined,
                      color: Colors.grey[400], size: 18),
                ]),
              )),
          const SizedBox(height: 8),
          buildSheetSubmitButton(
              '+ Thêm phòng học', () => Navigator.pop(context)),
        ])),
      ]),
    );
  }
}
