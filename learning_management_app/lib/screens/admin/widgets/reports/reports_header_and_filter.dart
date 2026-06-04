import 'package:flutter/material.dart';

class ReportsHeaderAndFilter extends StatefulWidget {
  final VoidCallback onExport;
  const ReportsHeaderAndFilter({super.key, required this.onExport});

  @override
  State<ReportsHeaderAndFilter> createState() => _ReportsHeaderAndFilterState();
}

class _ReportsHeaderAndFilterState extends State<ReportsHeaderAndFilter> {
  static const _kPrimary = Color(0xFF1A237E);
  String _selectedSemester = 'HK2 - 2025-2026';
  String _selectedDept = 'Tất cả khoa';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildHeader(context),
      _buildFilter(),
    ]);
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF0D1B6E), _kPrimary], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 14),
      child: Row(children: [
        const Icon(Icons.bar_chart_rounded, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        const Text('Báo cáo & Thống kê', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        GestureDetector(
          onTap: widget.onExport,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: const Row(children: [
              Icon(Icons.download_outlined, color: Colors.white, size: 16),
              SizedBox(width: 5),
              Text('Xuất', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildFilter() {
    final semesters = ['HK2 - 2025-2026', 'HK1 - 2025-2026', 'HK2 - 2024-2025'];
    final depts = ['Tất cả khoa', 'Khoa CNTT', 'Khoa HTTT', 'Khoa KHMT'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(children: [
        Expanded(child: _dropdownField('Học kỳ', semesters, _selectedSemester, (v) => setState(() => _selectedSemester = v!))),
        const SizedBox(width: 10),
        Expanded(child: _dropdownField('Khoa', depts, _selectedDept, (v) => setState(() => _selectedDept = v!))),
      ]),
    );
  }

  Widget _dropdownField(String label, List<String> items, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0D8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0D8F0))),
      ),
      isExpanded: true,
      style: const TextStyle(fontSize: 12, color: Color(0xFF212121)),
      icon: const Icon(Icons.keyboard_arrow_down, color: _kPrimary, size: 18),
    );
  }
}
