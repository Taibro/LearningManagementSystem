import 'package:flutter/material.dart';
import '../../data/mock_attendance_data.dart';

class ManualAttendanceTab extends StatefulWidget {
  const ManualAttendanceTab({super.key});

  @override
  State<ManualAttendanceTab> createState() => _ManualAttendanceTabState();
}

class _ManualAttendanceTabState extends State<ManualAttendanceTab> {
  String _selectedSemester = 'HK2 - 2025-2026';
  String _selectedClass = '010110195604 - 14DHTH04';
  String _searchQuery = '';
  final TextEditingController _commentController =
      TextEditingController(text: 'Lớp học nghiêm túc, đúng giờ.');

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final present = kStudents.where((s) => s['status'] == 0).length;
    final excused = kStudents.where((s) => s['status'] == 1).length;
    final absent = kStudents.where((s) => s['status'] == 2).length;

    final filtered = _searchQuery.isEmpty
        ? kStudents
        : kStudents
            .where((s) =>
                (s['name'] as String)
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ||
                (s['mssv'] as String)
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
            .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter card
          _buildFilterCard(),
          const SizedBox(height: 14),
          // Stats
          Row(
            children: [
              _buildStatChip('Sĩ số', '${kStudents.length}',
                  const Color(0xFF6B4FA0)),
              const SizedBox(width: 8),
              _buildStatChip(
                  'Có mặt', '$present', const Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              _buildStatChip(
                  'Vắng có phép', '$excused', const Color(0xFFE65100)),
              const SizedBox(width: 8),
              _buildStatChip(
                  'Vắng không phép', '$absent', const Color(0xFFC62828)),
            ],
          ),
          const SizedBox(height: 14),
          // Comment
          _buildCommentCard(),
          const SizedBox(height: 14),
          // Student list
          _buildStudentList(filtered),
        ],
      ),
    );
  }

  Widget _buildFilterCard() {
    final semesters = ['HK2 - 2025-2026', 'HK1 - 2025-2026'];
    final classes = [
      '010110195604 - 14DHTH04',
      '010110195603 - 14DHTH03',
      '010110195602 - 14DHTH02',
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown('Học kỳ', semesters, _selectedSemester,
                    (v) => setState(() => _selectedSemester = v!)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdown('Lớp học phần', classes, _selectedClass,
                    (v) => setState(() => _selectedClass = v!)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sinh viên...',
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
              prefixIcon:
                  const Icon(Icons.search, size: 18, color: Color(0xFF9E9E9E)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF6B4FA0)),
              ),
            ),
            style: const TextStyle(fontSize: 13),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String value,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: Color(0xFF616161))),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
            ),
          ),
          isExpanded: true,
          style: const TextStyle(fontSize: 12, color: Color(0xFF212121)),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF6B4FA0), size: 18),
        ),
      ],
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 9, height: 1.2)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nhận xét lớp',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242))),
          const SizedBox(height: 8),
          TextField(
            controller: _commentController,
            maxLines: 2,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0D8F0)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildActionBtn('Lưu điểm danh', const Color(0xFF6B4FA0),
                    Icons.save_outlined),
                const SizedBox(width: 8),
                _buildActionBtn('Xuất Excel', const Color(0xFF2E7D32),
                    Icons.table_chart_outlined),
                const SizedBox(width: 8),
                _buildActionBtn('Đồng bộ', const Color(0xFFC62828),
                    Icons.sync_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color, IconData icon) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(label), backgroundColor: const Color(0xFF6B4FA0)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 15),
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentList(List<Map<String, dynamic>> list) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Danh sách sinh viên (${list.length})',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121)),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ...list.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return Column(
              children: [
                _buildStudentRow(i, s),
                if (i < list.length - 1)
                  const Divider(height: 1, indent: 16, color: Color(0xFFF0F0F0)),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStudentRow(int index, Map<String, dynamic> s) {
    final labels = ['Có mặt', 'Vắng phép', 'Vắng'];
    final colors = [
      const Color(0xFF4CAF50),
      const Color(0xFFE65100),
      const Color(0xFFC62828),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFEDE7F6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B4FA0)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name'],
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text('${s['mssv']} · ${s['class']}',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9E9E9E))),
              ],
            ),
          ),
          // Status toggle
          GestureDetector(
            onTap: () {
              setState(() {
                s['status'] = (s['status'] + 1) % 3;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: colors[s['status'] as int].withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: colors[s['status'] as int].withOpacity(0.4)),
              ),
              child: Text(
                labels[s['status'] as int],
                style: TextStyle(
                  fontSize: 11,
                  color: colors[s['status'] as int],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
