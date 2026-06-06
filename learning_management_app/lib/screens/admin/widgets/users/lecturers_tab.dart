import 'package:flutter/material.dart';
import '../../data/mock_admin_users_data.dart';
import 'users_helpers.dart';
import 'bottom_sheets/user_detail_sheet.dart';
import 'bottom_sheets/user_form_sheet.dart';

class LecturersTab extends StatefulWidget {
  const LecturersTab({super.key});

  @override
  State<LecturersTab> createState() => _LecturersTabState();
}

class _LecturersTabState extends State<LecturersTab> {
  String _lecturerSearch = '';
  String _lecturerFilter = 'Tất cả';
  static const _kPrimary = Color(0xFF1A237E);

  List<Map<String, dynamic>> get _filteredLecturers => mockLecturers.where((l) {
        final q = _lecturerSearch.toLowerCase();
        final matchSearch = q.isEmpty ||
            (l['name'] as String).toLowerCase().contains(q) ||
            (l['code'] as String).toLowerCase().contains(q);
        final matchFilter = _lecturerFilter == 'Tất cả' ||
            (_lecturerFilter == 'Hoạt động' && l['status'] == 'active') ||
            (_lecturerFilter == 'Nghỉ' && l['status'] == 'inactive');
        return matchSearch && matchFilter;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final filters = ['Tất cả', 'Hoạt động', 'Nghỉ'];
    return Column(children: [
      buildSearchBar(
          'Tìm giảng viên, mã GV...', (v) => setState(() => _lecturerSearch = v)),
      buildFilterRow(
          filters, _lecturerFilter, (f) => setState(() => _lecturerFilter = f)),
      Expanded(
        child: _filteredLecturers.isEmpty
            ? const Center(
                child: Text('Không tìm thấy giảng viên',
                    style: TextStyle(color: Color(0xFF9E9E9E))))
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: _filteredLecturers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _lecturerCard(_filteredLecturers[i]),
              ),
      ),
    ]);
  }

  Widget _lecturerCard(Map<String, dynamic> l) {
    final isActive = l['status'] == 'active';
    final statusColor = isActive ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E);
    return GestureDetector(
      onTap: () => _showUserDetailSheet(l),
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
              (l['name'] as String).split(' ').last.substring(0, 1),
              [const Color(0xFF00695C), const Color(0xFF2E7D32)]),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Text(l['name'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(l['code'] as String,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E))),
                ]),
                const SizedBox(height: 2),
                Text('${l['degree']}  ·  ${l['rank']}  ·  ${l['department']}',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9E9E9E))),
                const SizedBox(height: 6),
                Row(children: [
                  buildChipWidget(isActive ? 'Đang dạy' : 'Nghỉ', statusColor),
                  const SizedBox(width: 8),
                  Icon(Icons.class_outlined, size: 12, color: Colors.grey[500]),
                  const SizedBox(width: 3),
                  Text('${l['classes']} lớp',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E))),
                ]),
              ])),
          PopupMenuButton<String>(
            onSelected: (v) => _handleAction(v, l),
            itemBuilder: (_) => [
              buildPopupItem('detail', Icons.info_outline, 'Xem chi tiết', null),
              buildPopupItem('edit', Icons.edit_outlined, 'Chỉnh sửa', null),
              buildPopupItem('classes', Icons.class_outlined, 'Phân công lớp', null),
              buildPopupItem('reset', Icons.lock_reset, 'Đặt lại MK', null),
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
      builder: (_) => UserDetailSheet(user: user, type: 'lecturer'),
    );
  }

  void _showUserFormSheet(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UserFormSheet(user: user, type: 'lecturer'),
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
