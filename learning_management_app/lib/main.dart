import 'package:flutter/material.dart';
import 'package:learning_management_app/screens/auth/school_code_screen.dart';
import 'package:learning_management_app/screens/student/attendance_screen.dart';
import 'package:learning_management_app/screens/student/home_screen.dart';
import 'package:learning_management_app/screens/student/profile_screen.dart';
import 'package:learning_management_app/screens/student/schedule_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_management_app/core/network/dio_client.dart';
import 'package:learning_management_app/repositories/auth_repository.dart';
import 'package:learning_management_app/repositories/student_repository.dart';
import 'package:learning_management_app/blocs/auth/auth_bloc.dart';
import 'package:learning_management_app/blocs/student/profile/profile_bloc.dart';
import 'package:learning_management_app/blocs/student/schedule/schedule_bloc.dart';
import 'package:learning_management_app/blocs/student/grade/grade_bloc.dart';
import 'package:learning_management_app/blocs/student/attendance/attendance_bloc.dart';

import 'package:learning_management_app/repositories/teacher_repository.dart';
import 'package:learning_management_app/blocs/lecturer/profile/teacher_profile_bloc.dart';
import 'package:learning_management_app/blocs/lecturer/salary/teacher_salary_bloc.dart';
import 'package:learning_management_app/blocs/lecturer/statistic/teacher_statistic_bloc.dart';
import 'package:learning_management_app/blocs/lecturer/attendance/teacher_attendance_bloc.dart';

import 'package:learning_management_app/repositories/school_admin_repository.dart';
import 'package:learning_management_app/blocs/admin/dashboard/admin_dashboard_bloc.dart';
import 'package:learning_management_app/blocs/admin/request/admin_request_bloc.dart';
import 'package:learning_management_app/blocs/admin/notification/admin_notification_bloc.dart';
import 'package:learning_management_app/blocs/admin/user_management/admin_user_management_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DioClient()),
        RepositoryProvider(create: (context) => AuthRepository(context.read<DioClient>())),
        RepositoryProvider(create: (context) => StudentRepository(context.read<DioClient>())),
        RepositoryProvider(create: (context) => TeacherRepository(context.read<DioClient>().dio)),
        RepositoryProvider(create: (context) => SchoolAdminRepository(context.read<DioClient>().dio)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => ProfileBloc(context.read<StudentRepository>())),
          BlocProvider(create: (context) => ScheduleBloc(context.read<StudentRepository>())),
          BlocProvider(create: (context) => GradeBloc(context.read<StudentRepository>())),
          BlocProvider(create: (context) => AttendanceBloc(context.read<StudentRepository>())),
          // Lecturer Blocs
          BlocProvider(create: (context) => TeacherProfileBloc(context.read<TeacherRepository>())),
          BlocProvider(create: (context) => TeacherSalaryBloc(context.read<TeacherRepository>())),
          BlocProvider(create: (context) => TeacherStatisticBloc(context.read<TeacherRepository>())),
          BlocProvider(create: (context) => TeacherAttendanceBloc(context.read<TeacherRepository>())),
          // Admin Blocs
          BlocProvider(create: (context) => AdminDashboardBloc(context.read<SchoolAdminRepository>())),
          BlocProvider(create: (context) => AdminRequestBloc(context.read<SchoolAdminRepository>())),
          BlocProvider(create: (context) => AdminNotificationBloc(context.read<SchoolAdminRepository>())),
          BlocProvider(create: (context) => AdminUserManagementBloc(context.read<SchoolAdminRepository>())),
        ],
        child: MaterialApp(
          title: 'Learning Management System',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
            useMaterial3: true,
          ),
          home: const SchoolCodeScreen(),
        ),
      ),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
int _selectedIndex = 0;

  // Danh sách các màn hình sẽ được tráo đổi
  final List<Widget> _screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const AttendanceScreen(), // Tạo tạm một màn hình rỗng nếu chưa có
    const ProfileScreen(),    // Tạo tạm một màn hình rỗng nếu chưa có
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], 
      
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Trang chủ'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Lịch học'},
      {'icon': Icons.checklist_outlined, 'label': 'Điểm danh'},
      {'icon': Icons.person_outline_rounded, 'label': 'Cá nhân'},
    ];
 
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: isSelected ? const Color(0xFF1565C0) : const Color(0xFF9E9E9E),
                      size: 24,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? const Color(0xFF1565C0) : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

}