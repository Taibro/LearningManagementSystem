import 'package:flutter/material.dart';
import 'settings_sheet_helpers.dart';

class NewSemesterSheet extends StatelessWidget {
  const NewSemesterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        buildSheetHandle(),
        buildSheetHeader('Tạo học kỳ mới', Icons.add_circle_outline),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildSheetField('Tên học kỳ', 'VD: HK1 - 2026-2027')),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildSheetField('Ngày bắt đầu', '01/08/2026')),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildSheetField('Ngày kết thúc', '15/01/2027')),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildSheetField('Năm học', '2026-2027')),
                  const SizedBox(height: 8),
                  buildSheetSubmitButton(
                      'Tạo học kỳ', () => Navigator.pop(context)),
                ]))),
      ]),
    );
  }
}
