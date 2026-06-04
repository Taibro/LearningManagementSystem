import 'package:flutter/material.dart';
import '../../student_info_screen.dart';

class ProfileMenuCard extends StatefulWidget {
  const ProfileMenuCard({super.key});

  @override
  State<ProfileMenuCard> createState() => _ProfileMenuCardState();
}

class _ProfileMenuCardState extends State<ProfileMenuCard> {
  bool _notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.article_outlined,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: const Color(0xFF1565C0),
            label: 'Thông tin sinh viên',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudentInfoScreen()),
            ),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.lock_clock_outlined,
            iconBgColor: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            label: 'Đổi mật khẩu',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.description_outlined,
            iconBgColor: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF5E35B1),
            label: 'Điều khoản và chính sách sử dụng',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.chat_bubble_outline_rounded,
            iconBgColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            label: 'Góp ý ứng dụng',
            onTap: () {},
          ),
          _buildDivider(),
          // Thông báo với Toggle
          _buildToggleItem(),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFC62828),
            label: 'Đăng xuất',
            onTap: _showLogoutDialog,
            showArrow: true,
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
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            // Label
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
            if (showArrow)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFBDBDBD),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF616161),
              size: 20,
            ),
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
            activeTrackColor: const Color(0xFF43A047),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 66,
      endIndent: 0,
      color: Color(0xFFF0F0F0),
    );
  }

  // ── Logout Dialog with radio options ─────────────────────────────
  void _showLogoutDialog() {
    int selectedOption = 0; // 0 = Đăng nhập lại, 1 = Nhập mã trường

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đăng xuất',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 16),
                // Option 1: Đăng nhập lại
                GestureDetector(
                  onTap: () => setDialogState(() => selectedOption = 0),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Icon(
                        selectedOption == 0
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: selectedOption == 0
                            ? const Color(0xFF1565C0)
                            : const Color(0xFFBDBDBD),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Đăng nhập lại',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // Option 2: Nhập mã trường
                GestureDetector(
                  onTap: () => setDialogState(() => selectedOption = 1),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Icon(
                        selectedOption == 1
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: selectedOption == 1
                            ? const Color(0xFF1565C0)
                            : const Color(0xFFBDBDBD),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Nhập mã trường',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            actions: [
              Row(
                children: [
                  // Huỷ
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF616161),
                        side: const BorderSide(color: Color(0xFFBDBDBD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Huỷ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Xác nhận
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        // TODO: handle logout with selectedOption
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
