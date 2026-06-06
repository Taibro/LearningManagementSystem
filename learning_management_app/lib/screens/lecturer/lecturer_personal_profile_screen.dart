import 'package:flutter/material.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/lecturer/profile/teacher_profile_bloc.dart';
import '../../blocs/lecturer/profile/teacher_profile_event.dart';
import '../../blocs/lecturer/profile/teacher_profile_state.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

class LecturerPersonalProfileScreen extends StatefulWidget {
  const LecturerPersonalProfileScreen({super.key});

  @override
  State<LecturerPersonalProfileScreen> createState() => _LecturerPersonalProfileScreenState();
}

class _LecturerPersonalProfileScreenState extends State<LecturerPersonalProfileScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<TeacherProfileBloc>();
    if (bloc.state is TeacherProfileInitial || bloc.state is TeacherProfileLoadFailure) {
      bloc.add(TeacherProfileFetchRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const LecturerCustomAppBar(title: 'Hồ sơ cá nhân'),
          Expanded(
            child: BlocBuilder<TeacherProfileBloc, TeacherProfileState>(
              builder: (context, state) {
                if (state is TeacherProfileLoading || state is TeacherProfileInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TeacherProfileLoadFailure) {
                  return Center(child: Text('Lỗi: ${state.message}'));
                } else if (state is TeacherProfileLoadSuccess) {
                  final profile = state.profile;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildAvatarSection(profile),
                        const SizedBox(height: 16),
                        _buildInfoCard('Thông tin cá nhân', [
                          _InfoItem('Họ và tên', profile.fullName ?? 'Chưa cập nhật'),
                          _InfoItem('Giới tính', profile.gender ?? 'Chưa cập nhật'),
                          _InfoItem('Ngày sinh', profile.dateOfBirth ?? 'Chưa cập nhật'),
                          _InfoItem('CCCD', profile.citizenIdNumber ?? 'Chưa cập nhật'),
                        ]),
                        const SizedBox(height: 12),
                        _buildInfoCard('Thông tin công tác', [
                          _InfoItem('Mã giảng viên', profile.teacherCode ?? 'Chưa cập nhật'),
                          _InfoItem('Khoa / Bộ môn', profile.departmentName ?? 'Chưa cập nhật'),
                          _InfoItem('Học vị', profile.degree ?? 'Chưa cập nhật'),
                          _InfoItem('Chuyên môn', profile.specialization ?? 'Chưa cập nhật'),
                        ]),
                        const SizedBox(height: 12),
                        _buildInfoCard('Thông tin liên hệ', [
                          _InfoItem('Email', profile.email ?? 'Chưa cập nhật'),
                          _InfoItem('Điện thoại', profile.phone ?? 'Chưa cập nhật'),
                          _InfoItem('Địa chỉ', profile.address ?? 'Chưa cập nhật'),
                        ]),
                        const SizedBox(height: 24),
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

  Widget _buildAvatarSection(profile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
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
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _kPrimary.withOpacity(0.3), width: 3),
              color: const Color(0xFFEDE7F6),
            ),
            child: const Icon(Icons.person, size: 50, color: Color(0xFF9E9E9E)),
          ),
          const SizedBox(height: 12),
          Text(
            profile.fullName ?? 'Chưa cập nhật',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${profile.degree ?? ''} · ${profile.specialization ?? ''}',
              style: const TextStyle(
                fontSize: 12,
                color: _kPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile.departmentName ?? 'Chưa cập nhật',
            style: const TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<_InfoItem> items) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(Icons.info_outline, color: _kPrimary, size: 16),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ...items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.value,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < items.length - 1)
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF5F5F5)),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  const _InfoItem(this.label, this.value);
}
