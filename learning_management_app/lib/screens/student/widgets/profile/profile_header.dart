import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/student/profile/profile_bloc.dart';
import '../../../../blocs/student/profile/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
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
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          String name = 'Đang tải...';
          String mssv = 'Đang tải...';
          String? avatarUrl;

          if (state is ProfileLoadSuccess) {
            name = state.profile.fullName ?? 'Chưa cập nhật';
            mssv = 'MSSV: ${state.profile.studentCode ?? 'N/A'}';
            avatarUrl = state.profile.avatarUrl;
          } else if (state is ProfileLoadFailure) {
            name = 'Lỗi tải dữ liệu';
            mssv = '';
          }

          return Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: avatarUrl != null
                      ? Image.network(avatarUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 44, color: Colors.grey[400]))
                      : Icon(Icons.person, size: 44, color: Colors.grey[400]),
                ),
              ),
              const SizedBox(width: 14),
              // Name + MSSV
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mssv,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
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
