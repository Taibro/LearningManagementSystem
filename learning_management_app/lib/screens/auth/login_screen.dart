import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:learning_management_app/screens/student/home_screen.dart';
import 'package:learning_management_app/screens/lecturer/lecturer_main_layout.dart';
import 'package:learning_management_app/screens/admin/admin_main_layout.dart';
import 'package:learning_management_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_management_app/blocs/auth/auth_bloc.dart';
import 'package:learning_management_app/blocs/auth/auth_event.dart';
import 'package:learning_management_app/blocs/auth/auth_state.dart';

/// Screen 4: Đăng nhập
/// Login form with username/password and optional biometric auth.
class LoginScreen extends StatefulWidget {
  final String schoolName;
  final String role;

  const LoginScreen({
    super.key,
    required this.schoolName,
    required this.role,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  late AnimationController _animCtrl;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  String get _roleLabel {
    switch (widget.role) {
      case 'Sinh viên':
        return 'Sinh viên';
      case 'Cán bộ CNV':
        return 'Cán bộ CNV';
      case 'Admin trường':
        return 'Admin trường';
      default:
        return widget.role;
    }
  }

  Color get _accentColor {
    switch (widget.role) {
      case 'Sinh viên':
        return const Color(0xFF00695C);
      case 'Cán bộ CNV':
        return const Color(0xFF4A148C);
      case 'Admin trường':
        return const Color(0xFFB71C1C);
      default:
        return const Color(0xFF1565C0);
    }
  }

  List<Color> get _headerGradient {
    switch (widget.role) {
      case 'Sinh viên':
        return [const Color(0xFF4DB6AC), const Color(0xFF00897B), const Color(0xFF00695C)];
      case 'Cán bộ CNV':
        return [const Color(0xFF9575CD), const Color(0xFF7E57C2), const Color(0xFF5E35B1)];
      case 'Admin trường':
        return [const Color(0xFFEF5350), const Color(0xFFE53935), const Color(0xFFC62828)];
      default:
        return [const Color(0xFF42A5F5), const Color(0xFF1E88E5), const Color(0xFF1565C0)];
    }
  }

  void _onLogin() {
    if (_userCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    String userType = 'STUDENT';
    if (widget.role == 'Cán bộ CNV') userType = 'LECTURER';
    if (widget.role == 'Admin trường') userType = 'SCHOOL_ADMIN';

    context.read<AuthBloc>().add(AuthLoginRequested(
      loginCode: _userCtrl.text.trim(),
      password: _passCtrl.text.trim(),
      userType: userType,
      schoolCode: 'HUIT', // TODO: Lấy mã trường thực tế từ luồng chọn trường
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Widget destination;
          switch (widget.role) {
            case 'Sinh viên':
              destination = const MainLayout();
              break;
            case 'Cán bộ CNV':
              destination = const LecturerMainLayout();
              break;
            case 'Admin trường':
              destination = const AdminMainLayout();
              break;
            default:
              destination = const MainLayout();
          }

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => destination),
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeIn,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: _buildLoginForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _headerGradient,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 18),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 12),

            // Title & role
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _roleLabel,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.75),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Lock icon decoration
                  _buildLockDecoration(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockDecoration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer ring
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 2,
            ),
          ),
        ),
        // Inner circle
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: Icon(
            Icons.lock_rounded,
            color: Colors.white.withOpacity(0.6),
            size: 24,
          ),
        ),
        // Small dots
        ...List.generate(4, (i) {
          final angle = (i * math.pi / 2) + math.pi / 4;
          return Positioned(
            left: 35 + 30 * math.cos(angle) - 3,
            top: 35 + 30 * math.sin(angle) - 3,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 36),

        // School info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _accentColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _accentColor.withOpacity(0.12)),
          ),
          child: Row(
            children: [
              Icon(Icons.account_balance_rounded,
                  color: _accentColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.schoolName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Username
        _buildLabel('Tên đăng nhập'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _userCtrl,
          hint: 'Nhập mã sinh viên / mã nhân viên',
          icon: Icons.person_outline_rounded,
        ),

        const SizedBox(height: 20),

        // Password
        _buildLabel('Mật khẩu'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _passCtrl,
          hint: 'Nhập mật khẩu',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
        ),

        const SizedBox(height: 12),

        // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(
                color: _accentColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Login button
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : _onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: _accentColor.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Divider
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'hoặc',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),

        const SizedBox(height: 24),

        // Biometric login
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Show biometric dialog
                  _showBiometricDialog();
                },
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _accentColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                    border: Border.all(color: _accentColor.withOpacity(0.2)),
                  ),
                  child: Icon(
                    Icons.fingerprint_rounded,
                    size: 36,
                    color: _accentColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Đăng nhập bằng sinh trắc học',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A2E),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E6ED)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePass : false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.grey.shade500, size: 22),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePass
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade500,
                    size: 22,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePass = !_obscurePass),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void _showBiometricDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Xác thực sinh trắc học',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        content: const Text(
          'Xác thực sinh trắc học chưa được thiết lập trên thiết bị của bạn. '
          'Vào Cài đặt > Bảo mật để thêm xác thực sinh trắc học.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'HUỶ',
              style: TextStyle(
                color: _accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'ĐẾN CÀI ĐẶT',
              style: TextStyle(
                color: _accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
