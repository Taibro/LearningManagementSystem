import 'package:flutter/material.dart';
import 'package:learning_management_app/core/enum/AttendanceStatus.dart';
import 'package:learning_management_app/models/Attendance.dart';
import 'widgets/attendance/attendance_card.dart';
import 'widgets/shared/custom_app_bar.dart';
import 'widgets/shared/mesh_background.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Attendance> _items = [
    Attendance(
      subjectName: 'Thực hành quản trị hệ thống mạng',
      tiet: '1→6',
      lop: '14DHTH05',
      phong: 'A205 - Phòng máy tính - 140 Lê Trọng Tấn',
    ),
    Attendance(
      subjectName: 'Lập trình di động',
      tiet: '7→11',
      lop: '14DHTH10',
      phong: 'A104 - Phòng máy tính - 140 Lê Trọng Tấn',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: MeshBackground(
        child: Column(
          children: [
            const CustomAppBar(title: 'Điểm danh'),
            Expanded(
              child: _items.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (_, i) => AttendanceCard(
                        item: _items[i],
                        onAttendanceSuccess: () {
                          setState(() {
                            _items[i].status = AttendanceStatus.daDiemDanh;
                          });
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text(
        'Không có môn học cần điểm danh',
        style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
      ),
    );
  }
}
