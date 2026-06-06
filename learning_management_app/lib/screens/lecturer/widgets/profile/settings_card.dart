import 'package:flutter/material.dart';
import '../../../auth/school_code_screen.dart';
import '../../lecturer_change_password_screen.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _notificationEnabled = true;

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Đăng xuất',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?',
            style: TextStyle(fontSize: 14, color: Color(0xFF616161))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Huỷ',
                style: TextStyle(color: Color(0xFF616161))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SchoolCodeScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
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
          _buildMenuItem(
            icon: Icons.lock_outline_rounded,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            label: 'Đổi mật khẩu',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LecturerChangePasswordScreen(),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.description_outlined,
            iconBgColor: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF6B4FA0),
            label: 'Điều khoản & chính sách',
            onTap: () => _navigateTo(context, const TermsScreen()),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.chat_bubble_outline_rounded,
            iconBgColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            label: 'Góp ý ứng dụng',
            onTap: () => _navigateTo(context, const FeedbackScreen()),
          ),
          _buildDivider(),
          // Notification toggle
          _buildToggleItem(),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFC62828),
            label: 'Đăng xuất',
            onTap: () => _showLogoutDialog(context),
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
    required VoidCallback onTap,
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
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.notifications_outlined,
                color: Color(0xFF616161), size: 20),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Thông báo',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: _notificationEnabled,
            onChanged: (val) => setState(() => _notificationEnabled = val),
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF6B4FA0),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => const Divider(
      height: 1, indent: 68, color: Color(0xFFF0F0F0));
}
