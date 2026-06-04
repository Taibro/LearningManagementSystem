import 'package:flutter/material.dart';

class SemesterCard extends StatelessWidget {
  const SemesterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.school_outlined,
                    color: Color(0xFF6B4FA0), size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'Học kỳ 2 - 2025/2026',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF212121)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSemStat('5', 'Lớp phụ\ntrách'),
              _buildSemDivider(),
              _buildSemStat('120', 'Tiết kế\nhoạch'),
              _buildSemDivider(),
              _buildSemStat('87', 'Tiết đã\ndạy'),
              _buildSemDivider(),
              _buildSemStat('33', 'Tiết còn\nlại'),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 87 / 120,
              backgroundColor: const Color(0xFFE0D8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6B4FA0)),
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 4),
          const Text('Tiến độ giảng dạy: 72.5%',
              style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget _buildSemStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4FA0))),
        const SizedBox(height: 2),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10, color: Color(0xFF9E9E9E), height: 1.3)),
      ],
    );
  }

  Widget _buildSemDivider() {
    return Container(width: 1, height: 36, color: const Color(0xFFF0F0F0));
  }
}
