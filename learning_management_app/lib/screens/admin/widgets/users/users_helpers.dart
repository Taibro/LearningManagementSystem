import 'package:flutter/material.dart';

Widget buildSearchBar(String hint, ValueChanged<String> onChanged) {
  const kPrimary = Color(0xFF1A237E);
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
    child: TextField(
      decoration: InputDecoration(
        hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
        prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF9E9E9E)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kPrimary)),
      ),
      style: const TextStyle(fontSize: 13),
      onChanged: onChanged,
    ),
  );
}

Widget buildFilterRow(List<String> filters, String selected, ValueChanged<String> onTap) {
  const kPrimary = Color(0xFF1A237E);
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: filters.map((f) {
        final sel = selected == f;
        return Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(
          onTap: () => onTap(f),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: sel ? kPrimary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: sel ? kPrimary : const Color(0xFFE0D8F0)),
            ),
            child: Text(f, style: TextStyle(fontSize: 12, color: sel ? Colors.white : const Color(0xFF424242), fontWeight: FontWeight.w500)),
          ),
        ));
      }).toList()),
    ),
  );
}

Widget buildAvatarWidget(String letter, List<Color> colors) {
  return Container(
    width: 46, height: 46,
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
    child: Center(child: Text(letter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
  );
}

Widget buildChipWidget(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
  );
}

PopupMenuItem<String> buildPopupItem(String value, IconData icon, String label, Color? color) {
  return PopupMenuItem(value: value, child: Row(children: [
    Icon(icon, size: 16, color: color),
    const SizedBox(width: 8),
    Text(label, style: TextStyle(color: color)),
  ]));
}
