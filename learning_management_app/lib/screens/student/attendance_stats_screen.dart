import 'package:flutter/material.dart';
import 'data/mock_extra_data.dart';
import 'widgets/shared/custom_app_bar.dart';

const Color _kPrimary = Color(0xFF1565C0);
const Color _kBg = Color(0xFFF0F4FF);

class AttendanceStatsScreen extends StatefulWidget {
  const AttendanceStatsScreen({super.key});

  @override
  State<AttendanceStatsScreen> createState() => _AttendanceStatsScreenState();
}

class _AttendanceStatsScreenState extends State<AttendanceStatsScreen> {
  // Track which semester is expanded (-1 = none)
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    // Expand the last semester by default
    _expandedIndex = kAttendanceStats.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(title: 'Thống kê điểm danh'),
          // Table header
          _buildTableHeader(),
          // Body
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: kAttendanceStats.length,
              itemBuilder: (_, i) => _SemesterSection(
                semester: kAttendanceStats[i],
                isExpanded: _expandedIndex == i,
                onToggle: () {
                  setState(() {
                    _expandedIndex = _expandedIndex == i ? -1 : i;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildTableHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text('Mã môn',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF616161))),
          ),
          Expanded(
            child: Center(
              child: Text('Tên môn',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF616161))),
            ),
          ),
          SizedBox(
            width: 42,
            child: Center(
              child: Text('DVHT',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF616161))),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text('CP',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF616161))),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text('KP',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF616161))),
            ),
          ),
        ],
      ),
    );
  }
}

class _SemesterSection extends StatelessWidget {
  final AttendanceStatSemester semester;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _SemesterSection({
    required this.semester,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Semester header row
        GestureDetector(
          onTap: onToggle,
          child: Container(
            color: isExpanded ? _kPrimary : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  isExpanded
                      ? Icons.arrow_drop_down_circle
                      : Icons.arrow_right_rounded,
                  color: isExpanded ? Colors.white : const Color(0xFF757575),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    semester.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isExpanded ? Colors.white : const Color(0xFF212121),
                    ),
                  ),
                ),
                SizedBox(
                  width: 42,
                  child: Center(
                    child: Text(
                      '${semester.totalDvht}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isExpanded ? Colors.white : _kPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      '${semester.totalCp}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isExpanded ? Colors.white : const Color(0xFF212121),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      '${semester.totalKp}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isExpanded
                            ? Colors.white
                            : semester.totalKp > 0
                                ? const Color(0xFFE65100)
                                : const Color(0xFF212121),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),
        // Subject rows (if expanded)
        if (isExpanded)
          ...semester.subjects.asMap().entries.map((entry) {
            final idx = entry.key;
            final sub = entry.value;
            final isEven = idx.isEven;
            return Container(
              color: isEven ? Colors.white : const Color(0xFFF5F8FF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      sub.maMon,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        sub.tenMon,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 42,
                    child: Center(
                      child: Text(
                        '${sub.dvht}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '${sub.cp}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '${sub.kp}',
                        style: TextStyle(
                          fontSize: 12,
                          color: sub.kp > 0
                              ? const Color(0xFFE65100)
                              : const Color(0xFF424242),
                          fontWeight:
                              sub.kp > 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }
}
