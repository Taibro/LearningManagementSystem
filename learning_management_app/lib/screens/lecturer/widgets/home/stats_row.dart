import 'package:flutter/material.dart';
import '../../features/stats_detail_screen.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, 'Hôm nay', '2 lớp', Icons.class_outlined, const Color(0xFF6B4FA0), 0),
        const SizedBox(width: 12),
        _buildStatCard(context, 'Tuần này', '8 buổi', Icons.calendar_view_week_outlined, const Color(0xFF4CAF50), 1),
        const SizedBox(width: 12),
        _buildStatCard(context, 'Chờ duyệt', '1 đề xuất', Icons.pending_outlined, const Color(0xFFE65100), 2),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color, int tabIndex) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatsDetailScreen(initialTabIndex: tabIndex),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
