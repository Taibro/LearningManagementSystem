import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'widgets/shared/custom_app_bar.dart';
import 'widgets/shared/mesh_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/student/grade/grade_bloc.dart';
import '../../blocs/student/grade/grade_event.dart';
import '../../blocs/student/grade/grade_state.dart';
import 'package:learning_management_app/models/student/student_grade.dart';
import '../../core/widgets/custom_loading_indicator.dart';
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
        backgroundColor: const Color(0xFFF8FAFC),
        body: MeshBackground(
          child: Column(
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
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.transparent,
      child: TabBar(
        labelColor: _kPrimary,
        unselectedLabelColor: const Color(0xFF94A3B8),
        labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 15),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 15),
        indicatorColor: _kPrimary,
        indicatorWeight: 3,
        dividerColor: const Color(0xFFE2E8F0).withOpacity(0.5),
        tabs: const [
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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4F46E5).withOpacity(0.05),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: rows.length,
              separatorBuilder: (_, __) => Divider(height: 1, indent: 20, endIndent: 20, color: const Color(0xFFE2E8F0).withOpacity(0.5)),
              itemBuilder: (_, i) {
                final row = rows[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          row.label,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      const Text(' : ', style: TextStyle(color: Color(0xFF94A3B8))),
                      Expanded(
                        flex: 4,
                        child: Text(
                          row.value,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ).animate().fade(duration: 500.ms, delay: 100.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuart),
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
          return Center(child: CustomLoadingIndicator());
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
          padding: const EdgeInsets.only(bottom: 12, top: 8),
          child: Text(
            semesterName,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF4F46E5),
            ),
          ),
        ),

        // Table
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F46E5).withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  // Header row
                  Container(
                    color: const Color(0xFF4F46E5).withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
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
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: const Color(0xFFE2E8F0).withOpacity(0.5), width: 1),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(sub.courseCode ?? 'N/A', style: _kTableCell),
                          ),
                          Expanded(
                            child: Text(sub.courseName ?? 'N/A', style: _kTableCell.copyWith(fontWeight: FontWeight.w500, color: const Color(0xFF0F172A))),
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
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: sub.gradeTotal != null ? const Color(0xFF4F46E5) : const Color(0xFF94A3B8),
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
          ),
        ).animate().fade(duration: 500.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuart),

        const SizedBox(height: 24),
      ],
    );
  }
}

final TextStyle _kTableHeader = GoogleFonts.inter(
  color: const Color(0xFF4F46E5),
  fontSize: 12,
  fontWeight: FontWeight.w700,
);

final TextStyle _kTableCell = GoogleFonts.inter(
  fontSize: 12,
  color: const Color(0xFF64748B),
);
