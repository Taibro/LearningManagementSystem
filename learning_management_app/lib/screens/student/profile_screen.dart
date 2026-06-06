import 'package:flutter/material.dart';
import 'widgets/profile/profile_header.dart';
import 'widgets/profile/profile_menu_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/student/profile/profile_bloc.dart';
import '../../blocs/student/profile/profile_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          const ProfileHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(height: 16),
                  ProfileMenuCard(),
                  SizedBox(height: 24),
                  Text(
                    'Phiên bản 1.4.8',
                    style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
