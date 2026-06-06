import 'package:flutter/material.dart';
import 'bottom_sheets/edit_profile_sheet.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/lecturer/profile/teacher_profile_bloc.dart';
import '../../../../blocs/lecturer/profile/teacher_profile_state.dart';
import 'bottom_sheets/edit_profile_sheet.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  void _showEditProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const EditProfileSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A3570), Color(0xFF6B4FA0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
              color: Colors.white,
            ),
            child: ClipOval(
              child: Icon(Icons.person, size: 46, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: BlocBuilder<TeacherProfileBloc, TeacherProfileState>(
              builder: (context, state) {
                if (state is TeacherProfileLoading) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                } else if (state is TeacherProfileLoadSuccess) {
                  final profile = state.profile;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName ?? 'Chưa cập nhật',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Mã GV: ${profile.teacherCode ?? ''}  ·  Khoa ${profile.departmentName ?? ''}',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${profile.degree ?? ''} · ${profile.specialization ?? ''}',
                        style: const TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  );
                }
                return const Text('Không thể tải dữ liệu', style: TextStyle(color: Colors.white));
              },
            ),
          ),
          GestureDetector(
            onTap: () => _showEditProfile(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Chỉnh sửa',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
