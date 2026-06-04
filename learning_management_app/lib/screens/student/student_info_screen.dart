import 'package:flutter/material.dart';
import 'widgets/shared/custom_app_bar.dart';

const Color _kBg = Color(0xFFF0F4FF);

class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(title: 'Thông tin sinh viên'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildAvatarSection(),
                  _buildInfoList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildAvatarSection() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
              color: Colors.white,
            ),
            child: ClipOval(
              child: Icon(Icons.person, size: 64, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Nguyễn Thành Tài',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoList() {
    final items = [
      _InfoItem('Trạng thái', 'Đang học'),
      _InfoItem('MSSV', '2001230773'),
      _InfoItem('Khoa', 'Khoa Công nghệ Thông tin'),
      _InfoItem('Lớp', '14DHTH05-14DHTH05'),
      _InfoItem('Bậc đào tạo', 'Đại học'),
      _InfoItem('Loại hình đào tạo', 'Chính quy'),
      _InfoItem('Khóa học', '2023'),
      _InfoItem('Ngành', 'Công nghệ thông tin'),
      _InfoItem('Chuyên ngành', 'Công nghệ phần mềm'),
      _InfoItem('Ngày sinh', '14/10/2005'),
      _InfoItem('Giới tính', 'Nam'),
      _InfoItem('Email', 'thanhtai@sgu.edu.vn'),
      _InfoItem('Số điện thoại', '0901234567'),
      _InfoItem('Địa chỉ', 'TP. Hồ Chí Minh'),
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          indent: 20,
          endIndent: 20,
          color: Color(0xFFF0F0F0),
        ),
        itemBuilder: (_, i) {
          final item = items[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  ' :  ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  const _InfoItem(this.label, this.value);
}
