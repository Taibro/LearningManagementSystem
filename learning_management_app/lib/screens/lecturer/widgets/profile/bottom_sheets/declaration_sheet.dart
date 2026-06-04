import 'package:flutter/material.dart';
import 'shared_sheet_helpers.dart';

class DeclarationSheet extends StatelessWidget {
  const DeclarationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          buildSheetHandle(),
          buildSheetHeader('Khai báo thông tin',
              'HK2 - 2025/2026', const Color(0xFFE65100)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Họ và tên', 'Nguyễn Văn A', readOnly: true),
                  const SizedBox(height: 12),
                  _buildInfoRow('Mã giảng viên', 'GV001', readOnly: true),
                  const SizedBox(height: 12),
                  _buildInfoRow('Khoa / Bộ môn', 'Công nghệ thông tin', readOnly: true),
                  const SizedBox(height: 12),
                  _buildInfoRow('Học kỳ khai báo', 'HK2 - 2025-2026'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Số tiết dạy dự kiến', '120'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Số lớp phụ trách', '5'),
                  const SizedBox(height: 12),
                  const Text('Ghi chú',
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFF616161))),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0D8F0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Không có ghi chú đặc biệt.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('💾  Lưu khai báo',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: Color(0xFF616161))),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: readOnly ? const Color(0xFFF9F7FF) : Colors.white,
            border: Border.all(color: const Color(0xFFE0D8F0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value,
              style: TextStyle(
                  fontSize: 13,
                  color: readOnly
                      ? const Color(0xFF9E9E9E)
                      : const Color(0xFF212121))),
        ),
      ],
    );
  }
}
