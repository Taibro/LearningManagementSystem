import 'package:flutter/material.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/lecturer/statistic/teacher_statistic_bloc.dart';
import '../../blocs/lecturer/statistic/teacher_statistic_event.dart';
import '../../blocs/lecturer/statistic/teacher_statistic_state.dart';
import '../../models/lecturer/teaching_statistic.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

class LecturerTeachingStatsScreen extends StatefulWidget {
  const LecturerTeachingStatsScreen({super.key});

  @override
  State<LecturerTeachingStatsScreen> createState() => _LecturerTeachingStatsScreenState();
}

class _LecturerTeachingStatsScreenState extends State<LecturerTeachingStatsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherStatisticBloc>().add(TeacherStatisticFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const LecturerCustomAppBar(title: 'Thống kê giảng dạy'),
          Expanded(
            child: BlocBuilder<TeacherStatisticBloc, TeacherStatisticState>(
              builder: (context, state) {
                if (state is TeacherStatisticLoading || state is TeacherStatisticInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TeacherStatisticLoadFailure) {
                  return Center(child: Text('Lỗi: ${state.message}'));
                } else if (state is TeacherStatisticLoadSuccess) {
                  final stat = state.statistic;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryRow(stat),
                        const SizedBox(height: 16),
                        _buildMonthlyChart(stat),
                        const SizedBox(height: 16),
                        _buildStatsGrid(stat),
                        const SizedBox(height: 16),
                        _buildDetailTable(stat),
                        const SizedBox(height: 24),
                      ],
                    ),
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

  Widget _buildSummaryRow(TeachingStatistic stat) {
    final items = [
      {'value': '${stat.totalPeriods ?? 0}', 'label': 'Tổng tiết\nđã dạy', 'color': _kPrimary},
      {'value': '${stat.examShifts ?? 0}', 'label': 'Buổi\ncoi thi', 'color': const Color(0xFFE85D75)},
      {'value': '${stat.overallProgress ?? 0}%', 'label': 'Tiến độ\ngiảng dạy', 'color': const Color(0xFF2E7D32)},
    ];

    return Row(
      children: items.map((item) {
        final color = item['color'] as Color;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  item['value'] as String,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9E9E9E),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMonthlyChart(TeachingStatistic stat) {
    final maxPeriods = stat.chartData != null && stat.chartData!.isNotEmpty
        ? stat.chartData!.map((e) => e.periods ?? 0).reduce((a, b) => a > b ? a : b)
        : 1;

    final months = stat.chartData?.map((e) {
          final val = e.periods ?? 0;
          return {
            'month': e.month ?? '',
            'value': maxPeriods > 0 ? val / maxPeriods : 0.0,
            'realValue': val,
          };
        }).toList() ?? [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tiến độ giảng dạy theo tháng',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: months.map((m) {
                final ratio = m['value'] as double;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${m['realValue']}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF616161),
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          height: 100 * ratio,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF8B6BBF), Color(0xFF6B4FA0)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m['month'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(TeachingStatistic stat) {
    final stats = [
      {'label': 'Tổng tiết đã dạy', 'value': '${stat.totalPeriods ?? 0} tiết', 'color': _kPrimary},
      {'label': 'Tiết lý thuyết', 'value': '${stat.theoryPeriods ?? 0} tiết', 'color': const Color(0xFF4CAF50)},
      {'label': 'Tiết thực hành', 'value': '${stat.labPeriods ?? 0} tiết', 'color': const Color(0xFF5C6BC0)},
      {'label': 'Tỷ lệ lý thuyết', 'value': '${stat.theoryPercentage ?? 0}%', 'color': const Color(0xFFE65100)},
      {'label': 'Số buổi coi thi', 'value': '${stat.examShifts ?? 0} buổi', 'color': const Color(0xFFE85D75)},
      {'label': 'Sắp tới', 'value': '${stat.upcomingExamShifts ?? 0} ca thi', 'color': const Color(0xFF2E7D32)},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.3,
      ),
      itemCount: stats.length,
      itemBuilder: (_, i) {
        final s = stats[i];
        final color = s['color'] as Color;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                s['value'] as String,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                s['label'] as String,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailTable(TeachingStatistic stat) {
    final data = stat.classDetails ?? [];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Text(
              'Chi tiết theo lớp',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Header
          Container(
            color: _kPrimary,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: const Row(
              children: [
                Expanded(flex: 4, child: Text('Môn học', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Lớp', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Đã dạy', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Tổng', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
              ],
            ),
          ),
          ...data.asMap().entries.map((entry) {
            final i = entry.key;
            final d = entry.value;
            return Container(
              color: i.isEven ? Colors.white : const Color(0xFFF9F7FF),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: Row(
                children: [
                  Expanded(flex: 4, child: Text(d.subjectName ?? '', style: const TextStyle(fontSize: 12, color: Color(0xFF424242)))),
                  Expanded(flex: 2, child: Text(d.classCode ?? '', style: const TextStyle(fontSize: 12, color: Color(0xFF424242)), textAlign: TextAlign.center)),
                  Expanded(flex: 2, child: Text('${d.completedPeriods ?? 0}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF6B4FA0)), textAlign: TextAlign.center)),
                  Expanded(flex: 2, child: Text('${d.totalPeriods ?? 0}', style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)), textAlign: TextAlign.center)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
