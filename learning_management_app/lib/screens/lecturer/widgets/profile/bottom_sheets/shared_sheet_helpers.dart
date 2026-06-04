import 'package:flutter/material.dart';

Widget buildSheetHandle() {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D8F0),
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}

Widget buildSheetHeader(String title, String subtitle, Color color) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.info_outline, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF212121))),
            Text(subtitle,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          ],
        ),
      ],
    ),
  );
}
