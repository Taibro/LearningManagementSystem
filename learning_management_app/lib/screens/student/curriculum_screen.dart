import 'package:flutter/material.dart';
import 'data/mock_extra_data.dart';

const Color _kPrimary = Color(0xFF1565C0);
const Color _kBg = Color(0xFFF0F4FF);

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  // Track which semester is expanded (-1 = none)
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    // Expand the current in-progress semester by default
    for (int i = 0; i < kCurriculum.semesters.length; i++) {
      final sem = kCurriculum.semesters[i];
      final hasInProgress = sem.categories.any((c) =>
          c.subjects.any((s) => s.trangThai == SubjectStatus.inProgress));
      if (hasInProgress) {
        _expandedIndex = i;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          _buildHeader(context),
          _buildStudentInfo(),
          _buildTableHeader(),
          Expanded(child: _buildSemesterList()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Chương trình khung',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfo() {
    final c = kCurriculum;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chuyên ngành',
            style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 2),
          Text(
            c.chuyenNganh,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Ngành : ', style: TextStyle(fontSize: 13, color: Color(0xFF757575))),
              Text(c.nganh,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF212121))),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text('Hệ đào tạo: ', style: TextStyle(fontSize: 13, color: Color(0xFF757575))),
              Text(c.heDaoTao,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF212121))),
              const SizedBox(width: 24),
              const Text('Loại đào tạo: ', style: TextStyle(fontSize: 13, color: Color(0xFF757575))),
              Text(c.loaiDaoTao,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF212121))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          const Expanded(
            flex: 4,
            child: Text('Tên học phần',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF616161))),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: Text('Mã HP',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF616161))),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text('TC',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF616161))),
            ),
          ),
          SizedBox(
            width: 44,
            child: Center(
              child: Text('T.Thái',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF616161))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: kCurriculum.semesters.length,
      itemBuilder: (_, i) {
        final sem = kCurriculum.semesters[i];
        final isExpanded = _expandedIndex == i;
        return _SemesterBlock(
          semester: sem,
          isExpanded: isExpanded,
          onToggle: () {
            setState(() {
              _expandedIndex = _expandedIndex == i ? -1 : i;
            });
          },
        );
      },
    );
  }
}

class _SemesterBlock extends StatelessWidget {
  final CurriculumSemester semester;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _SemesterBlock({
    required this.semester,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Semester header
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
                Text(
                  '${semester.totalTC}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isExpanded ? Colors.white : _kPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),

        // Expanded content
        if (isExpanded)
          ...semester.categories.expand((cat) => [
                // Category header
                Container(
                  color: const Color(0xFFF5F8FF),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          cat.label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _kPrimary,
                          ),
                        ),
                      ),
                      Text(
                        '${cat.totalTC}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _kPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Subject rows
                ...cat.subjects.map((sub) => _SubjectRow(subject: sub)),
              ]),
      ],
    );
  }
}

class _SubjectRow extends StatelessWidget {
  final CurriculumSubject subject;
  const _SubjectRow({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              subject.tenHocPhan,
              style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                subject.maHP,
                style: const TextStyle(fontSize: 11, color: Color(0xFF757575)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                '${subject.tinChi}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: Center(child: _statusIcon(subject.trangThai)),
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(SubjectStatus status) {
    switch (status) {
      case SubjectStatus.completed:
        return const Icon(Icons.check_circle, color: Color(0xFF43A047), size: 22);
      case SubjectStatus.inProgress:
        return const Icon(Icons.access_time_filled, color: Color(0xFFFFA726), size: 22);
      case SubjectStatus.notStarted:
        return const Icon(Icons.radio_button_unchecked, color: Color(0xFFBDBDBD), size: 22);
    }
  }
}
