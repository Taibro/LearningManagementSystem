import 'package:flutter/material.dart';
import '../../data/mock_admin_users_data.dart';
import 'users_helpers.dart';
import 'bottom_sheets/user_detail_sheet.dart';
import 'bottom_sheets/user_form_sheet.dart';

class StudentsTab extends StatefulWidget {
  const StudentsTab({super.key});

  @override
  State<StudentsTab> createState() => _StudentsTabState();
}

class _StudentsTabState extends State<StudentsTab> {
  String _studentSearch = '';
  String _studentFilter = 'Tất cả';
  static const _kPrimary = Color(0xFF1A237E);

  List<Map<String, dynamic>> get _filteredStudents => mockStudents.where((s) {
        final q = _studentSearch.toLowerCase();
        final matchSearch = q.isEmpty ||
            (s['name'] as String).toLowerCase().contains(q) ||
            (s['mssv'] as String).contains(q);
        final matchFilter = _studentFilter == 'Tất cả' ||
            (_studentFilter == 'Hoạt động' && s['status'] == 'active') ||
            (_studentFilter == 'Cảnh báo' && s['status'] == 'warning') ||
            (_studentFilter == 'Khoá' && s['status'] == 'locked');
        return matchSearch && matchFilter;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final filters = ['Tất cả', 'Hoạt động', 'Cảnh báo', 'Khoá'];
    return Column(children: [
      buildSearchBar(
          'Tìm sinh viên, MSSV...', (v) => setState(() => _studentSearch = v)),
      buildFilterRow(
          filters, _studentFilter, (f) => setState(() => _studentFilter = f)),
      Expanded(
        child: _filteredStudents.isEmpty
            ? const Center(
                child: Text('Không tìm thấy sinh viên',
                    style: TextStyle(color: Color(0xFF9E9E9E))))
            : ListView.separated(
                padding: const EdgeInsets.all(14),
                itemCount: _filteredStudents.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _studentCard(_filteredStudents[i]),
              ),
      ),
    ]);
  }

  Widget _studentCard(Map<String, dynamic> s) {
    Color statusColor;
    String statusLabel;
    switch (s['status']) {
      case 'warning':
        statusColor = const Color(0xFFE65100);
        statusLabel = 'Cảnh báo';
        break;
      case 'locked':
        statusColor = const Color(0xFFC62828);
        statusLabel = 'Bị khoá';
        break;
      default:
        statusColor = const Color(0xFF4CAF50);
        statusLabel = 'Hoạt động';
    }
    final gpa = s['gpa'] as double;
    final gpaColor = gpa >= 3.2
        ? const Color(0xFF2E7D32)
        : gpa >= 2.0
            ? const Color(0xFFE65100)
            : const Color(0xFFC62828);

    return GestureDetector(
      onTap: () => _showUserDetailSheet(s),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(children: [
          buildAvatarWidget(
              (s['name'] as String).split(' ').last.substring(0, 1),
              [_kPrimary.withOpacity(0.7), _kPrimary]),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(s['name'] as String,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text('${s['mssv']}  ·  ${s['class']}  ·  ${s['major']}',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9E9E9E))),
                const SizedBox(height: 6),
                Row(children: [
                  buildChipWidget(statusLabel, statusColor),
                  const SizedBox(width: 8),
                  buildChipWidget('GPA: $gpa', gpaColor),
                ]),
              ])),
          PopupMenuButton<String>(
            onSelected: (v) => _handleAction(v, s),
            itemBuilder: (_) => [
              buildPopupItem('detail', Icons.info_outline, 'Xem chi tiết', null),
              buildPopupItem('edit', Icons.edit_outlined, 'Chỉnh sửa', null),
              buildPopupItem('reset', Icons.lock_reset, 'Đặt lại MK', null),
              buildPopupItem('lock', Icons.block, 'Khoá TK', Colors.red),
            ],
            icon: const Icon(Icons.more_vert,
                color: Color(0xFF9E9E9E), size: 20),
          ),
        ]),
      ),
    );
  }

  void _handleAction(String action, Map<String, dynamic> user) {
    if (action == 'detail') {
      _showUserDetailSheet(user);
    } else if (action == 'edit') {
      _showUserFormSheet(user);
    } else {
      _snack('$action: ${user['name']}');
    }
  }

  void _showUserDetailSheet(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UserDetailSheet(user: user, type: 'student'),
    );
  }

  void _showUserFormSheet(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UserFormSheet(user: user, type: 'student'),
    );
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(msg),
            backgroundColor: _kPrimary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2)),
      );
}
