import 'package:flutter/material.dart';
import 'login_screen.dart';

/// Screen 3: Chọn vai trò
/// Blue background with role cards: Sinh viên, Cán bộ CNV, Admin trường
class RoleSelectionScreen extends StatefulWidget {
  final String schoolName;
  const RoleSelectionScreen({super.key, required this.schoolName});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _animCtrl;
  late List<Animation<double>> _cardFades;
  late List<Animation<Offset>> _cardSlides;

  final _roles = [
    _RoleData(
      title: 'Sinh viên',
      icon: Icons.school_rounded,
      gradient: [const Color(0xFF42A5F5), const Color(0xFF1E88E5)],
      description: 'Dành cho sinh viên đang theo học',
    ),
    _RoleData(
      title: 'Cán bộ CNV',
      icon: Icons.public_rounded,
      gradient: [const Color(0xFF66BB6A), const Color(0xFF43A047)],
      description: 'Dành cho giảng viên, cán bộ',
    ),
    _RoleData(
      title: 'Admin trường',
      icon: Icons.admin_panel_settings_rounded,
      gradient: [const Color(0xFFEF5350), const Color(0xFFE53935)],
      description: 'Quản trị viên hệ thống trường',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _cardFades = List.generate(3, (i) {
      final start = i * 0.2;
      final end = start + 0.6;
      return CurvedAnimation(
        parent: _animCtrl,
        curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOut),
      );
    });

    _cardSlides = List.generate(3, (i) {
      final start = i * 0.2;
      final end = start + 0.6;
      return Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animCtrl,
        curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOutCubic),
      ));
    });

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _onSelectRole(String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          schoolName: widget.schoolName,
          role: role,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2196F3), Color(0xFF1565C0), Color(0xFF0D47A1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    // Logout / switch icon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.logout_rounded,
                            color: Colors.white, size: 20),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Greeting
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Xin chào,',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.schoolName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Vui lòng chọn tuỳ chọn để tiếp tục',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Role cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _roles.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, i) {
                      return FadeTransition(
                        opacity: _cardFades[i],
                        child: SlideTransition(
                          position: _cardSlides[i],
                          child: _RoleCard(
                            role: _roles[i],
                            onTap: () => _onSelectRole(_roles[i].title),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Bottom decorative elements
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_stories_rounded,
                          color: Colors.white.withOpacity(0.2), size: 28),
                      const SizedBox(width: 16),
                      Icon(Icons.school_rounded,
                          color: Colors.white.withOpacity(0.15), size: 32),
                      const SizedBox(width: 16),
                      Icon(Icons.psychology_rounded,
                          color: Colors.white.withOpacity(0.2), size: 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Role data ──
class _RoleData {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final String description;

  const _RoleData({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.description,
  });
}

// ── Role card ──
class _RoleCard extends StatelessWidget {
  final _RoleData role;
  final VoidCallback onTap;

  const _RoleCard({required this.role, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon with gradient background
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: role.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: role.gradient[0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(role.icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 18),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
