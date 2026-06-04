import 'package:flutter/material.dart';

Widget buildHomeCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3))
      ],
    ),
    child: child,
  );
}

Widget buildSectionTitle(String title, IconData icon) {
  const kPrimary = Color(0xFF1A237E);
  return Row(children: [
    Icon(icon, color: kPrimary, size: 18),
    const SizedBox(width: 8),
    Text(title,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121))),
  ]);
}
