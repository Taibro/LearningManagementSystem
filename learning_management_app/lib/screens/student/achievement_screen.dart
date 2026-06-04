import 'package:flutter/material.dart';
import 'widgets/shared/custom_app_bar.dart';
import 'data/mock_grade_data.dart';

const Color _kPrimary = Color(0xFF1565C0);
const Color _kBg = Color(0xFFF0F4FF);
const Color _kStudentBar = Color(0xFF00796B);   // teal / dark green-blue
const Color _kClassBar = Color(0xFF64B5F6);      // light blue

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  int _selectedSemesterIndex = 0;

  SemesterAchievement get _current =>
      kSemesterAchievements[_selectedSemesterIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Thành tích',
            isGradient: true,
            paddingBottom: 16,
            fontSize: 17,
          ),
          _buildSemesterSelector(),
          Expanded(child: _buildChart()),
          _buildLegend(),
        ],
      ),
    );
  }

  // ── App Bar ───────────────────────────────────────────────────────


  // ── Semester Selector ─────────────────────────────────────────────
  Widget _buildSemesterSelector() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Chọn học kỳ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
            ),
          ),
          GestureDetector(
            onTap: _showSemesterPicker,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _current.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kPrimary,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: _kPrimary, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSemesterPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Chọn học kỳ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ...kSemesterAchievements.asMap().entries.map((e) {
              final i = e.key;
              final sem = e.value;
              final selected = i == _selectedSemesterIndex;
              return ListTile(
                title: Text(
                  sem.label,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? _kPrimary : const Color(0xFF212121),
                  ),
                ),
                trailing: selected
                    ? const Icon(Icons.check, color: _kPrimary)
                    : null,
                onTap: () {
                  setState(() => _selectedSemesterIndex = i);
                  Navigator.pop(context);
                },
              );
            }),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // ── Chart Body ────────────────────────────────────────────────────
  Widget _buildChart() {
    final subjects = _current.subjects;
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      itemCount: subjects.length,
      separatorBuilder: (_, __) => const Divider(height: 28, color: Color(0xFFE0E0E0)),
      itemBuilder: (_, i) => _BarPair(subject: subjects[i]),
    );
  }

  // ── Legend ────────────────────────────────────────────────────────
  Widget _buildLegend() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendDot(_kClassBar, 'Điểm trung bình của lớp'),
            const SizedBox(width: 24),
            _legendDot(_kStudentBar, 'Điểm của bạn'),
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
      ],
    );
  }
}

// ── Individual bar pair widget ───────────────────────────────────────
class _BarPair extends StatelessWidget {
  final AchievementSubject subject;
  const _BarPair({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Subject name (fixed width)
        SizedBox(
          width: 80,
          child: Text(
            subject.tenMon,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
              height: 1.3,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Bars + scale
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student bar
              _HorizontalBar(
                value: subject.diemCaNhan,
                maxValue: 10,
                color: _kStudentBar,
              ),
              const SizedBox(height: 4),
              // Class average bar
              _HorizontalBar(
                value: subject.diemTBLop,
                maxValue: 10,
                color: _kClassBar,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HorizontalBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final Color color;

  const _HorizontalBar({
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = (value / maxValue).clamp(0.0, 1.0);
    return SizedBox(
      height: 22,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth * fraction;
          return Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Filled bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: barWidth,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
