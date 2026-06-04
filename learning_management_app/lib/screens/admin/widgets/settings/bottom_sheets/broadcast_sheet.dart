import 'package:flutter/material.dart';
import 'settings_sheet_helpers.dart';

class BroadcastSheet extends StatelessWidget {
  const BroadcastSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const kPrimary = Color(0xFF1A237E);
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        buildSheetHandle(),
        buildSheetHeader('Gửi thông báo hàng loạt', Icons.campaign_outlined),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  buildSheetField('Tiêu đề', 'Nhập tiêu đề thông báo...'),
                  const SizedBox(height: 12),
                  const Text('Đối tượng nhận',
                      style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                  const SizedBox(height: 6),
                  Row(children: [
                    _audienceChip('Tất cả', true, kPrimary),
                    const SizedBox(width: 8),
                    _audienceChip('Sinh viên', false, kPrimary),
                    const SizedBox(width: 8),
                    _audienceChip('Giảng viên', false, kPrimary),
                  ]),
                  const SizedBox(height: 12),
                  const Text('Nội dung',
                      style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                  const SizedBox(height: 4),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0D8F0)),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Nhập nội dung thông báo...',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFFBDBDBD)))),
                  ),
                  const SizedBox(height: 20),
                  buildSheetSubmitButton(
                      '📣  Gửi thông báo', () => Navigator.pop(context)),
                ]))),
      ]),
    );
  }

  Widget _audienceChip(String label, bool selected, Color kPrimary) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? kPrimary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? kPrimary : const Color(0xFFE0D8F0)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : const Color(0xFF424242),
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
