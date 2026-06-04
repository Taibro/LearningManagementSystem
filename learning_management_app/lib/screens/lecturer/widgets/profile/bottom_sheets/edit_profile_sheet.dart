import 'package:flutter/material.dart';
import 'shared_sheet_helpers.dart';

class EditProfileSheet extends StatelessWidget {
  const EditProfileSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          buildSheetHandle(),
          buildSheetHeader(
              'Thông tin giảng viên', 'Chỉ đọc', const Color(0xFF6B4FA0)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileRow('Họ và tên', 'Nguyễn Văn A'),
                  _buildProfileRow('Mã giảng viên', 'GV001'),
                  _buildProfileRow('Khoa / Bộ môn', 'Công nghệ thông tin'),
                  _buildProfileRow('Học hàm / Học vị', 'Tiến sĩ'),
                  _buildProfileRow('Chức danh', 'Giảng viên chính'),
                  _buildProfileRow('Email công vụ', 'gv001@huit.edu.vn'),
                  _buildProfileRow('Điện thoại', '0901 234 567'),
                  _buildProfileRow('Ngày vào trường', '15/08/2015'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13, color: Color(0xFF9E9E9E))),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF212121))),
          ),
        ],
      ),
    );
  }
}
