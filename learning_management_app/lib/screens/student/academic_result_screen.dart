import 'package:flutter/material.dart';
import 'widgets/shared/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/student/grade/grade_bloc.dart';
import '../../blocs/student/grade/grade_event.dart';
import '../../blocs/student/grade/grade_state.dart';
import '../../models/student/student_grade.dart';
import 'data/mock_grade_data.dart';

const Color _kPrimary = Color(0xFF1565C0);
const Color _kBg = Color(0xFFF0F4FF);

class AcademicResultScreen extends StatefulWidget {
  const AcademicResultScreen({super.key});

  @override
  State<AcademicResultScreen> createState() => _AcademicResultScreenState();
}

class _AcademicResultScreenState extends State<AcademicResultScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GradeBloc>().add(GradeFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: _kBg,
        body: Column(
          children: [
            const CustomAppBar(
              title: 'Kết quả học tập',
              isGradient: true,
              paddingBottom: 16,
              fontSize: 17,
            ),
            _buildTabBar(),
            const Expanded(
              child: TabBarView(
                children: [
                  _OverviewTab(),
                  _SummaryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: const TabBar(
        labelColor: _kPrimary,
        unselectedLabelColor: Color(0xFF757575),
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        indicatorColor: _kPrimary,
        indicatorWeight: 3,
        tabs: [
          Tab(text: 'Tổng quan'),
          Tab(text: 'Tổng kết'),
        ],
      ),
    );
  }
}

// ── Tab 1: Tổng quan ─────────────────────────────────────────────────
class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final s = kStudentOverview;
    final rows = [
      _InfoRow('Họ tên', s.hoTen),
      _InfoRow('Sinh viên năm', '${s.sinhVienNam}'),
      _InfoRow('Niên khóa', s.nienKhoa),
      _InfoRow('Thời gian đào tạo', '${s.thoiGianDaoTao}'),
      _InfoRow('Điểm TBC tích lũy (hệ 4)', '${s.diemTBCHe4}'),
      _InfoRow('Điểm TBC tích lũy (hệ 10)', '${s.diemTBCHe10}'),
      _InfoRow('STC đã đăng ký', '${s.stcDaDangKy}'),
      _InfoRow('STC đã tích lũy', '${s.stcDaTichLuy}'),
      _InfoRow('%STC nợ', '${s.stcNo} (${s.phanTramStcNo.toStringAsFixed(2)}%)'),
      _InfoRow('STC phải tích lũy', s.stcPhaiTichLuy.toStringAsFixed(2)),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: rows.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE0E0E0)),
      itemBuilder: (_, i) {
        final row = rows[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  row.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF424242),
                  ),
                ),
              ),
              const Text(
                ' : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  row.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);
}

class _SummaryTab extends StatelessWidget {
  const _SummaryTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeBloc, GradeState>(
      builder: (context, state) {
        if (state is GradeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GradeLoadFailure) {
          return Center(child: Text('Lỗi: ${state.message}'));
        } else if (state is GradeLoadSuccess) {
          final grades = state.grades;
          if (grades.isEmpty) {
            return const Center(child: Text('Chưa có dữ liệu điểm'));
          }

          // Nhóm điểm theo học kỳ
          final groupedGrades = <String, List<StudentGrade>>{};
          for (var grade in grades) {
            final sem = grade.semesterName ?? 'Chưa xác định';
            if (!groupedGrades.containsKey(sem)) {
              groupedGrades[sem] = [];
            }
            groupedGrades[sem]!.add(grade);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groupedGrades.length,
            itemBuilder: (_, i) {
              final semesterName = groupedGrades.keys.elementAt(i);
              final semesterGrades = groupedGrades[semesterName]!;
              return _SemesterBlock(semesterName: semesterName, grades: semesterGrades);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _SemesterBlock extends StatelessWidget {
  final String semesterName;
  final List<StudentGrade> grades;
  
  const _SemesterBlock({required this.semesterName, required this.grades});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Semester header
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 6),
          child: Text(
            semesterName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _kPrimary,
            ),
          ),
        ),

        // Table
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Header row
              Container(
                color: _kPrimary,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Row(
                  children: [
                    SizedBox(width: 60, child: Text('Mã môn', style: _kTableHeader)),
                    Expanded(child: Text('Môn Học', style: _kTableHeader)),
                    SizedBox(width: 36, child: Text('TC', style: _kTableHeader, textAlign: TextAlign.center)),
                    SizedBox(width: 60, child: Text('Điểm TB', style: _kTableHeader, textAlign: TextAlign.center)),
                  ],
                ),
              ),
              // Data rows
              ...grades.asMap().entries.map((entry) {
                final idx = entry.key;
                final sub = entry.value;
                final isEven = idx.isEven;
                return Container(
                  color: isEven ? Colors.white : const Color(0xFFF5F8FF),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(sub.courseCode ?? 'N/A', style: _kTableCell),
                      ),
                      Expanded(
                        child: Text(sub.courseName ?? 'N/A', style: _kTableCell),
                      ),
                      SizedBox(
                        width: 36,
                        child: Text(
                          '${sub.credits ?? 0}',
                          style: _kTableCell,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          sub.gradeTotal != null ? sub.gradeTotal!.toStringAsFixed(1) : '-',
                          style: _kTableCell.copyWith(
                            fontWeight: FontWeight.w600,
                            color: sub.gradeTotal != null ? const Color(0xFF212121) : const Color(0xFF9E9E9E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _statLine(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF616161)),
          ),
          if (value != null) ...[
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

const TextStyle _kTableHeader = TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const TextStyle _kTableCell = TextStyle(
  fontSize: 12,
  color: Color(0xFF424242),
);
