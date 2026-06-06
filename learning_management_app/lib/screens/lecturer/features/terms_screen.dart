import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      appBar: AppBar(
        title: const Text('Điều khoản chính sách', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF455A64),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ĐIỀU KHOẢN SỬ DỤNG HỆ THỐNG', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text('1. Bảo mật thông tin\nGiảng viên có trách nhiệm bảo mật tài khoản cá nhân, không chia sẻ mật khẩu cho người khác.', style: TextStyle(height: 1.6, color: Colors.black87)),
              SizedBox(height: 12),
              Text('2. Trách nhiệm cập nhật dữ liệu\nKết quả điểm danh, điểm số phải được cập nhật đúng hạn theo quy định của nhà trường.', style: TextStyle(height: 1.6, color: Colors.black87)),
              SizedBox(height: 12),
              Text('3. Xử lý vi phạm\nMọi hành vi can thiệp trái phép vào hệ thống sẽ bị xử lý theo quy chế.', style: TextStyle(height: 1.6, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}
