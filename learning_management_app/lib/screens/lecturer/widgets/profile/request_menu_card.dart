import 'package:flutter/material.dart';
import 'bottom_sheets/request_sheet.dart';

class RequestMenuCard extends StatelessWidget {
  const RequestMenuCard({super.key});

  void _showRequestSheet(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RequestSheet(type: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Text(
                  'ĐỀ XUẤT LỊCH DẠY',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B4FA0),
                      letterSpacing: 0.5),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE85D75),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text('1 chờ duyệt',
                    style: TextStyle(fontSize: 11, color: Color(0xFFE85D75))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5)),
          _buildMenuItem(
            icon: Icons.pause_circle_outline_rounded,
            iconBgColor: const Color(0xFFFFF8E1),
            iconColor: const Color(0xFFF5A623),
            label: 'Đề xuất tạm ngừng lịch dạy',
            subtitle: '2 đề xuất gần đây',
            onTap: () => _showRequestSheet(context, 'tamNgung'),
            badge: null,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.add_circle_outline_rounded,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            label: 'Đề xuất dạy bù',
            subtitle: '1 chờ duyệt · 1 đã hoàn thành',
            onTap: () => _showRequestSheet(context, 'dayBu'),
            badge: '1',
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.swap_horiz_rounded,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: const Color(0xFF1565C0),
            label: 'Đề xuất dạy thay',
            subtitle: 'Không có đề xuất mới',
            onTap: () => _showRequestSheet(context, 'dayThay'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    String? subtitle,
    required VoidCallback onTap,
    String? badge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ],
              ),
            ),
            if (badge != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE85D75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => const Divider(
      height: 1, indent: 68, color: Color(0xFFF0F0F0));
}
