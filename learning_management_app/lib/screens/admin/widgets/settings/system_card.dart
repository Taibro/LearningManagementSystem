import 'package:flutter/material.dart';
import 'settings_helpers.dart';
import 'bottom_sheets/room_config_sheet.dart';

class SystemCard extends StatefulWidget {
  final Function(String) onAction;
  const SystemCard({super.key, required this.onAction});

  @override
  State<SystemCard> createState() => _SystemCardState();
}

class _SystemCardState extends State<SystemCard> {
  bool _maintenanceMode = false;
  bool _allowQr = true;
  bool _allowOnline = true;
  static const _kPrimary = Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return buildSettingsCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildSectionTitle('Cài đặt hệ thống', Icons.tune_rounded),
        const SizedBox(height: 14),
        buildToggleRow(
            'Chế độ bảo trì',
            'Tắt tạm thời truy cập người dùng',
            Icons.build_outlined,
            const Color(0xFFE85D75),
            _maintenanceMode,
            (v) => setState(() => _maintenanceMode = v)),
        buildDivider(),
        buildToggleRow(
            'Cho phép điểm danh QR',
            'Sinh viên quét mã điểm danh',
            Icons.qr_code_2_rounded,
            const Color(0xFF4CAF50),
            _allowQr,
            (v) => setState(() => _allowQr = v)),
        buildDivider(),
        buildToggleRow(
            'Cho phép học trực tuyến',
            'Hiển thị lớp trực tuyến trên TKB',
            Icons.video_call_outlined,
            const Color(0xFF1565C0),
            _allowOnline,
            (v) => setState(() => _allowOnline = v)),
        buildDivider(),
        buildMenuRow(
            'Sao lưu dữ liệu',
            'Lần cuối: 14/05/2026 22:00',
            Icons.backup_outlined,
            const Color(0xFF2E7D32),
            () => widget.onAction('Đang sao lưu...')),
        buildDivider(),
        buildMenuRow(
            'Cấu hình phòng học',
            '86 phòng đang hoạt động',
            Icons.meeting_room_outlined,
            const Color(0xFFE65100),
            () => _showRoomConfig()),
        buildDivider(),
        buildMenuRow(
            'Quản lý học kỳ & năm học',
            'Thêm, xoá, cập nhật học kỳ',
            Icons.date_range_outlined,
            _kPrimary,
            () => widget.onAction('Mở quản lý học kỳ')),
      ]),
    );
  }

  void _showRoomConfig() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const RoomConfigSheet(),
    );
  }
}
