import 'package:flutter/material.dart';
import 'package:learning_management_app/models/Schedule.dart';
import '../../data/mock_schedule_data.dart';
import '../../utils/schedule_utils.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule item;

  const ScheduleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final color = typeColor(item.type);
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Colored left accent
            Container(width: 4, color: color),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.subjectName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: kTextMain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _infoRow('Tiết :', item.tiet),
                    const SizedBox(height: 4),
                    _infoRow('Phòng :', item.phong),
                    const SizedBox(height: 4),
                    _infoRow('Giảng viên :', item.giangVien),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: kTextGrey),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kTextMain,
            ),
          ),
        ),
      ],
    );
  }
}
