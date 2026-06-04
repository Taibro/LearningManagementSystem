import 'package:flutter/material.dart';
import '../../data/mock_admin_schedule_data.dart';
import 'bottom_sheets/class_form_sheet.dart';
import 'bottom_sheets/change_room_sheet.dart';

class ClassListTab extends StatefulWidget {
  const ClassListTab({super.key});

  @override
  State<ClassListTab> createState() => _ClassListTabState();
}

class _ClassListTabState extends State<ClassListTab> {
  String _scheduleFilter = 'Tất cả';
  String _scheduleSearch = '';
  static const _kPrimary = Color(0xFF1A237E);

  List<Map<String, dynamic>> get _filteredClasses {
    return mockClasses.where((c) {
      final matchType = _scheduleFilter == 'Tất cả' ||
          (_scheduleFilter == 'Lý thuyết' && c['type'] == 'theory') ||
          (_scheduleFilter == 'Thực hành' && c['type'] == 'practice') ||
          (_scheduleFilter == 'Trực tuyến' && c['type'] == 'online');
      final q = _scheduleSearch.toLowerCase();
      final matchSearch = q.isEmpty ||
          (c['subject'] as String).toLowerCase().contains(q) ||
          (c['lecturer'] as String).toLowerCase().contains(q) ||
          (c['group'] as String).toLowerCase().contains(q);
      return matchType && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildClassFilter(),
      Expanded(
        child: _filteredClasses.isEmpty
            ? const Center(
                child: Text('Không tìm thấy lớp học',
                    style: TextStyle(color: Color(0xFF9E9E9E))))
            : ListView.separated(
                padding: const EdgeInsets.all(14),
                itemCount: _filteredClasses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _buildClassCard(_filteredClasses[i]),
              ),
      ),
    ]);
  }

  Widget _buildClassFilter() {
    final filters = ['Tất cả', 'Lý thuyết', 'Thực hành', 'Trực tuyến'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Tìm môn học, giảng viên, nhóm lớp...',
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
            prefixIcon:
                const Icon(Icons.search, size: 18, color: Color(0xFF9E9E9E)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE8E0F0))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: _kPrimary)),
          ),
          style: const TextStyle(fontSize: 13),
          onChanged: (v) => setState(() => _scheduleSearch = v),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: filters.map((f) {
            final sel = _scheduleFilter == f;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _scheduleFilter = f),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: sel ? _kPrimary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: sel ? _kPrimary : const Color(0xFFE0D8F0)),
                  ),
                  child: Text(f,
                      style: TextStyle(
                          fontSize: 12,
                          color: sel ? Colors.white : const Color(0xFF424242),
                          fontWeight: FontWeight.w500)),
                ),
              ),
            );
          }).toList()),
        ),
      ]),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> c) {
    Color col;
    Color bg;
    switch (c['type']) {
      case 'practice':
        col = const Color(0xFF5C6BC0);
        bg = const Color(0xFFE8EAF6);
        break;
      case 'online':
        col = const Color(0xFFE65100);
        bg = const Color(0xFFFFF3E0);
        break;
      default:
        col = const Color(0xFF2E7D32);
        bg = const Color(0xFFE8F5E9);
    }
    final enrolled = c['enrolled'] as int;
    final capacity = c['capacity'] as int;
    final ratio = enrolled / capacity;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: col, width: 4)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      padding: const EdgeInsets.all(13),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(6)),
            child: Text(
                c['type'] == 'theory'
                    ? 'LT'
                    : c['type'] == 'practice'
                        ? 'TH'
                        : 'TT',
                style: TextStyle(
                    fontSize: 10, color: col, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(c['subject'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF212121)))),
          PopupMenuButton<String>(
            onSelected: (v) => _handleClassAction(v, c),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: 'edit',
                  child: Row(children: [
                    Icon(Icons.edit_outlined, size: 16),
                    SizedBox(width: 8),
                    Text('Chỉnh sửa')
                  ])),
              const PopupMenuItem(
                  value: 'room',
                  child: Row(children: [
                    Icon(Icons.meeting_room_outlined, size: 16),
                    SizedBox(width: 8),
                    Text('Đổi phòng')
                  ])),
              const PopupMenuItem(
                  value: 'cancel',
                  child: Row(children: [
                    Icon(Icons.cancel_outlined, size: 16, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Huỷ lịch', style: TextStyle(color: Colors.red))
                  ])),
            ],
            icon: const Icon(Icons.more_vert,
                color: Color(0xFF9E9E9E), size: 20),
          ),
        ]),
        const SizedBox(height: 8),
        Wrap(spacing: 14, runSpacing: 4, children: [
          _infoChip(Icons.person_outlined, c['lecturer'] as String),
          _infoChip(Icons.group_outlined, c['group'] as String),
          _infoChip(Icons.location_on_outlined, c['room'] as String),
          _infoChip(
              Icons.access_time_outlined, '${c['day']} · ${c['session']}'),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sĩ số: $enrolled/$capacity',
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF9E9E9E))),
                      Text('${(ratio * 100).toInt()}%',
                          style: TextStyle(
                              fontSize: 11,
                              color: col,
                              fontWeight: FontWeight.bold)),
                    ]),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                      value: ratio,
                      backgroundColor: const Color(0xFFE8E8F0),
                      valueColor: AlwaysStoppedAnimation<Color>(col),
                      minHeight: 5),
                ),
              ])),
        ]),
      ]),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: const Color(0xFF9E9E9E)),
      const SizedBox(width: 3),
      Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF616161))),
    ]);
  }

  void _handleClassAction(String action, Map<String, dynamic> c) {
    if (action == 'edit') _showEditClassSheet(c);
    if (action == 'room') _showChangeRoomSheet(c);
    if (action == 'cancel') _showCancelConfirm(c);
  }

  void _showEditClassSheet(Map<String, dynamic> c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ClassFormSheet(existing: c),
    );
  }

  void _showChangeRoomSheet(Map<String, dynamic> c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChangeRoomSheet(rooms: mockRooms, currentClass: c),
    );
  }

  void _showCancelConfirm(Map<String, dynamic> c) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text('Huỷ lịch học',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              content: Text(
                  'Xác nhận huỷ lịch "${c['subject']}" - ${c['group']}?',
                  style: const TextStyle(
                      fontSize: 14, color: Color(0xFF616161))),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Không',
                        style: TextStyle(color: Color(0xFF616161)))),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC62828),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Huỷ lịch'),
                ),
              ],
            ));
  }
}
