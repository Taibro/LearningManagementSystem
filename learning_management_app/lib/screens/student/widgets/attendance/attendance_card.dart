import 'package:flutter/material.dart';
import 'package:learning_management_app/core/enum/AttendanceStatus.dart';
import 'package:learning_management_app/models/Attendance.dart';
import 'attendance_method_sheet.dart';

class AttendanceCard extends StatelessWidget {
  final Attendance item;
  final VoidCallback onAttendanceSuccess;

  const AttendanceCard({
    super.key,
    required this.item,
    required this.onAttendanceSuccess,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    switch (item.status) {
      case AttendanceStatus.chuaDiemDanh:
        statusColor = const Color(0xFFE65100);
        statusText = 'Chưa điểm danh';
        break;
      case AttendanceStatus.daDiemDanh:
        statusColor = const Color(0xFF2E7D32);
        statusText = 'Đã điểm danh';
        break;
      case AttendanceStatus.vang:
        statusColor = const Color(0xFFC62828);
        statusText = 'Vắng';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.subjectName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 10),
          _infoRow('Tiết :', item.tiet),
          const SizedBox(height: 5),
          _infoRow('Lớp :', item.lop),
          const SizedBox(height: 5),
          _infoRow('Phòng :', item.phong),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (item.status == AttendanceStatus.chuaDiemDanh)
                ElevatedButton(
                  onPressed: () => _openAttendanceSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Điểm danh',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.status == AttendanceStatus.daDiemDanh
                        ? '✓ Hoàn thành'
                        : '✗ Vắng',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ],
    );
  }

  void _openAttendanceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          AttendanceMethodSheet(item: item, onSuccess: onAttendanceSuccess),
    );
  }
}
