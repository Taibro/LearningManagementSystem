import 'package:flutter/material.dart';
import 'data/mock_extra_data.dart';
import 'widgets/shared/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/student/attendance/attendance_bloc.dart';
import '../../blocs/student/attendance/attendance_event.dart';
import '../../blocs/student/attendance/attendance_state.dart';
import '../../models/student/student_attendance.dart';

const Color _kPrimary = Color(0xFF1565C0);
const Color _kBg = Color(0xFFF0F4FF);

class AttendanceStatsScreen extends StatefulWidget {
  const AttendanceStatsScreen({super.key});

  @override
  State<AttendanceStatsScreen> createState() => _AttendanceStatsScreenState();
}

class _AttendanceStatsScreenState extends State<AttendanceStatsScreen> {
  // Track which semester is expanded (key = semesterName)
  String? _expandedSemester;

  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(AttendanceFetchRequested());
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
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AttendanceLoadFailure) {
                  return Center(child: Text('Lỗi: ${state.message}'));
                } else if (state is AttendanceLoadSuccess) {
                  final attendances = state.attendances;
                  if (attendances.isEmpty) {
                    return const Center(child: Text('Chưa có dữ liệu điểm danh'));
                  }

                  // Nhóm theo học kỳ
                  final grouped = <String, List<StudentAttendance>>{};
                  for (var a in attendances) {
                    final sem = a.semesterName ?? 'Chưa xác định';
                    grouped.putIfAbsent(sem, () => []).add(a);
                  }

                  if (_expandedSemester == null && grouped.isNotEmpty) {
                    _expandedSemester = grouped.keys.last;
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: grouped.length,
                    itemBuilder: (_, i) {
                      final semName = grouped.keys.elementAt(i);
                      final semAttendances = grouped[semName]!;
                      return _SemesterSection(
                        semesterName: semName,
                        attendances: semAttendances,
                        isExpanded: _expandedSemester == semName,
                        onToggle: () {
                          setState(() {
                            _expandedSemester = _expandedSemester == semName ? null : semName;
                          });
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
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
  final String semesterName;
  final List<StudentAttendance> attendances;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _SemesterSection({
    required this.semesterName,
    required this.attendances,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    int totalDvht = attendances.fold(0, (sum, a) => sum + (a.credits ?? 0));
    int totalCp = attendances.fold(0, (sum, a) => sum + (a.absentWithPermission ?? 0));
    int totalKp = attendances.fold(0, (sum, a) => sum + (a.absentWithoutPermission ?? 0));

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
                    semesterName,
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
                      '$totalDvht',
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
                      '$totalCp',
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
                      '$totalKp',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isExpanded
                            ? Colors.white
                            : totalKp > 0
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
          ...attendances.asMap().entries.map((entry) {
            final idx = entry.key;
            final sub = entry.value;
            final isEven = idx.isEven;
            final kp = sub.absentWithoutPermission ?? 0;

            return Container(
              color: isEven ? Colors.white : const Color(0xFFF5F8FF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      sub.classCode ?? '',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        sub.courseName ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 42,
                    child: Center(
                      child: Text(
                        '${sub.credits ?? 0}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '${sub.absentWithPermission ?? 0}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '$kp',
                        style: TextStyle(
                          fontSize: 12,
                          color: kp > 0
                              ? const Color(0xFFE65100)
                              : const Color(0xFF424242),
                          fontWeight:
                              kp > 0 ? FontWeight.w600 : FontWeight.normal,
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
