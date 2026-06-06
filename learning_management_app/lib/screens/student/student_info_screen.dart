import 'package:flutter/material.dart';
import 'widgets/shared/custom_app_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/student/profile/profile_bloc.dart';
import '../../blocs/student/profile/profile_event.dart';
import '../../blocs/student/profile/profile_state.dart';
import '../../models/student/student_profile.dart';
import 'package:intl/intl.dart';

const Color _kBg = Color(0xFFF0F4FF);

class StudentInfoScreen extends StatefulWidget {
  const StudentInfoScreen({super.key});

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(title: 'Thông tin sinh viên'),
          Expanded(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoadFailure) {
                  return Center(child: Text('Lỗi: ${state.message}'));
                } else if (state is ProfileLoadSuccess) {
                  final profile = state.profile;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildAvatarSection(profile),
                        _buildInfoList(profile),
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



  Widget _buildAvatarSection(StudentProfile profile) {
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
              child: profile.avatarUrl != null
                  ? Image.network(profile.avatarUrl!, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 64, color: Colors.grey[400]))
                  : Icon(Icons.person, size: 64, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            profile.fullName ?? 'Chưa cập nhật',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoList(StudentProfile profile) {
    final dobFormat = profile.dateOfBirth != null ? DateFormat('dd/MM/yyyy').format(profile.dateOfBirth!) : 'Chưa cập nhật';
    final items = [
      _InfoItem('Trạng thái', 'Đang học'),
      _InfoItem('MSSV', profile.studentCode ?? 'N/A'),
      _InfoItem('Khoa', profile.departmentName ?? 'N/A'),
      _InfoItem('Lớp', profile.className ?? 'N/A'),
      _InfoItem('Bậc đào tạo', 'Đại học'),
      _InfoItem('Loại hình đào tạo', 'Chính quy'),
      _InfoItem('Khóa học', profile.enrollmentYear?.toString() ?? 'N/A'),
      _InfoItem('Ngành', profile.major ?? 'N/A'),
      _InfoItem('Ngày sinh', dobFormat),
      _InfoItem('Giới tính', profile.gender ?? 'N/A'),
      _InfoItem('Email', profile.email ?? 'N/A'),
      _InfoItem('Số điện thoại', profile.phone ?? 'N/A'),
      _InfoItem('Địa chỉ', profile.address ?? 'N/A'),
      _InfoItem('CCCD', profile.citizenIdNumber ?? 'N/A'),
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
