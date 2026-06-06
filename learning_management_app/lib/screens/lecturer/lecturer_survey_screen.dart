import 'package:flutter/material.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

class LecturerSurveyScreen extends StatelessWidget {
  const LecturerSurveyScreen({super.key});

  final List<Map<String, dynamic>> _surveys = const [
    {
      'subject': 'Kiến trúc máy tính',
      'class': '16DHTH10',
      'semester': 'HK2 2025-2026',
      'responses': 42,
      'total': 50,
      'rating': 4.5,
      'status': 'completed',
    },
    {
      'subject': 'TH Quản trị HT Mạng',
      'class': '14DHTH40',
      'semester': 'HK2 2025-2026',
      'responses': 28,
      'total': 45,
      'rating': 4.2,
      'status': 'active',
    },
    {
      'subject': 'Lập trình mạng',
      'class': '14DHTH04',
      'semester': 'HK2 2025-2026',
      'responses': 0,
      'total': 48,
      'rating': 0.0,
      'status': 'pending',
    },
    {
      'subject': 'An ninh mạng',
      'class': '16DHTH07',
      'semester': 'HK1 2025-2026',
      'responses': 38,
      'total': 40,
      'rating': 4.7,
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const LecturerCustomAppBar(title: 'Khảo sát'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOverviewCards(),
                  const SizedBox(height: 20),
                  const Text(
                    'Khảo sát theo môn học',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._surveys.map((s) => _buildSurveyCard(s)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    final completedCount = _surveys.where((s) => s['status'] == 'completed').length;
    final activeCount = _surveys.where((s) => s['status'] == 'active').length;
    final avgRating = _surveys
        .where((s) => (s['rating'] as double) > 0)
        .map((s) => s['rating'] as double)
        .fold<double>(0, (a, b) => a + b);
    final ratedCount = _surveys.where((s) => (s['rating'] as double) > 0).length;
    final avg = ratedCount > 0 ? (avgRating / ratedCount) : 0.0;

    final cards = [
      {'value': '$completedCount', 'label': 'Hoàn thành', 'color': const Color(0xFF4CAF50)},
      {'value': '$activeCount', 'label': 'Đang diễn ra', 'color': const Color(0xFFE65100)},
      {'value': avg.toStringAsFixed(1), 'label': 'Điểm TB', 'color': _kPrimary},
    ];

    return Row(
      children: cards.map((c) {
        final color = c['color'] as Color;
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
                  c['value'] as String,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  c['label'] as String,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSurveyCard(Map<String, dynamic> survey) {
    Color statusColor;
    String statusLabel;
    switch (survey['status']) {
      case 'completed':
        statusColor = const Color(0xFF4CAF50);
        statusLabel = 'Hoàn thành';
        break;
      case 'active':
        statusColor = const Color(0xFFE65100);
        statusLabel = 'Đang diễn ra';
        break;
      default:
        statusColor = const Color(0xFF9E9E9E);
        statusLabel = 'Chưa bắt đầu';
    }

    final responses = survey['responses'] as int;
    final total = survey['total'] as int;
    final ratio = total > 0 ? responses / total : 0.0;
    final rating = survey['rating'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      survey['subject'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${survey['class']}  ·  ${survey['semester']}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          Row(
            children: [
              const Text('Phản hồi: ', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ratio,
                    backgroundColor: const Color(0xFFE0D8F0),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$responses/$total',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
          if (rating > 0) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                ...List.generate(5, (i) {
                  if (i < rating.floor()) {
                    return const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 18);
                  } else if (i < rating.ceil() && rating % 1 > 0) {
                    return const Icon(Icons.star_half_rounded, color: Color(0xFFFFC107), size: 18);
                  } else {
                    return Icon(Icons.star_outline_rounded, color: Colors.grey.shade300, size: 18);
                  }
                }),
                const SizedBox(width: 6),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
