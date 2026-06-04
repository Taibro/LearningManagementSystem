import 'package:flutter/material.dart';
import '../../data/mock_home_data.dart';

class TodayClasses extends StatelessWidget {
  const TodayClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Lịch dạy hôm nay',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            Text(
              'Thứ 2, 28/04/2026',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...kTodayClasses.map((cls) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildClassCard(cls),
            )),
      ],
    );
  }

  Widget _buildClassCard(Map<String, dynamic> cls) {
    Color accentColor;
    Color bgColor;
    IconData typeIcon;
    String typeLabel;

    switch (cls['type']) {
      case 'practice':
        accentColor = const Color(0xFF5C6BC0);
        bgColor = const Color(0xFFE8EAF6);
        typeIcon = Icons.computer_outlined;
        typeLabel = 'Thực hành';
        break;
      case 'online':
        accentColor = const Color(0xFFE65100);
        bgColor = const Color(0xFFFFF3E0);
        typeIcon = Icons.video_call_outlined;
        typeLabel = 'Trực tuyến';
        break;
      default:
        accentColor = const Color(0xFF2E7D32);
        bgColor = const Color(0xFFE8F5E9);
        typeIcon = Icons.menu_book_outlined;
        typeLabel = 'Lý thuyết';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(typeIcon, color: accentColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cls['subject'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  cls['classCode'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 13, color: accentColor),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        cls['room'],
                        style: TextStyle(
                          fontSize: 12,
                          color: accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  typeLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cls['session'],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                cls['time'],
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B4FA0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
