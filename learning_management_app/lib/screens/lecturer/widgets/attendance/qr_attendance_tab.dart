import 'package:flutter/material.dart';
import 'dart:async';
import '../../data/mock_attendance_data.dart';

class QrAttendanceTab extends StatefulWidget {
  const QrAttendanceTab({super.key});

  @override
  State<QrAttendanceTab> createState() => _QrAttendanceTabState();
}

class _QrAttendanceTabState extends State<QrAttendanceTab> {
  final ValueNotifier<int> _qrSeconds = ValueNotifier<int>(900); // 15 min
  Timer? _qrTimer;

  @override
  void dispose() {
    _qrTimer?.cancel();
    _qrSeconds.dispose();
    super.dispose();
  }

  void _startQrTimer() {
    _qrTimer?.cancel();
    _qrSeconds.value = 900;
    _qrTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_qrSeconds.value > 0) {
        _qrSeconds.value--;
      } else {
        _qrTimer?.cancel();
      }
    });
  }

  String _formatQrTime(int s) =>
      '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildQrForm(),
          const SizedBox(height: 16),
          _buildQrScannedList(),
        ],
      ),
    );
  }

  Widget _buildQrForm() {
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
          const Text(
            'Tạo mã QR điểm danh',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          const Text('Lớp học phần',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('010110195604 - 14DHTH04',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF6B4FA0), size: 18),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text('Thời gian hiệu lực (phút)',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('15 phút', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 10),
          const Text('Buổi học',
              style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0D8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Buổi sáng - 28/04/2026',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF6B4FA0), size: 18),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              _startQrTimer();
              _showQrBottomSheet(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text('Tạo mã QR',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQrBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: _buildBottomSheetContent(),
        );
      },
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Mã QR Điểm danh',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A3570),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F7FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF6B4FA0), width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.qr_code_2_rounded,
                    size: 160, color: Color(0xFF6B4FA0)),
                const SizedBox(height: 8),
                Text(
                  'HUIT-14DHTH04-${DateTime.now().millisecondsSinceEpoch % 99999}',
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF9E9E9E)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder<int>(
            valueListenable: _qrSeconds,
            builder: (context, seconds, child) {
              return Column(
                children: [
                  Text(
                    _formatQrTime(seconds),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B4FA0),
                    ),
                  ),
                  const Text('Thời gian còn lại',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: seconds / 900,
                      backgroundColor: const Color(0xFFE0D8F0),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Color(0xFF6B4FA0)),
                      minHeight: 8,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, size: 20),
                  label: const Text('Tải về'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6B4FA0),
                    side: const BorderSide(color: Color(0xFF6B4FA0)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_rounded, size: 20),
                  label: const Text('Chia sẻ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B4FA0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                _startQrTimer();
              },
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: const Text('Làm mới QR'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6B4FA0),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrScannedList() {
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
          const Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              'Sinh viên đã điểm danh QR hôm nay',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ...kQrScanned.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: s['late']
                              ? const Color(0xFFFFEBEE)
                              : const Color(0xFFE8F5E9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          s['late']
                              ? Icons.access_time_rounded
                              : Icons.check_circle_outline,
                          color: s['late']
                              ? const Color(0xFFC62828)
                              : const Color(0xFF4CAF50),
                          size: 18,
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
                            Text(s['mssv'],
                                style: const TextStyle(
                                    fontSize: 11, color: Color(0xFF9E9E9E))),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(s['time'],
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: s['late']
                                  ? const Color(0xFFFFEBEE)
                                  : const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              s['late'] ? '! Trễ' : '✓ Đúng giờ',
                              style: TextStyle(
                                fontSize: 10,
                                color: s['late']
                                    ? const Color(0xFFC62828)
                                    : const Color(0xFF2E7D32),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (i < kQrScanned.length - 1)
                  const Divider(height: 1, indent: 60, color: Color(0xFFF0F0F0)),
              ],
            );
          }),
        ],
      ),
    );
  }
}
