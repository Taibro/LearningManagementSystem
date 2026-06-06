import 'package:flutter/material.dart';
import 'choose_school_screen.dart';

/// Screen 1: Nhập mã trường
/// User enters a school code or taps the QR icon to search schools.
class SchoolCodeScreen extends StatefulWidget {
  const SchoolCodeScreen({super.key});

  @override
  State<SchoolCodeScreen> createState() => _SchoolCodeScreenState();
}

class _SchoolCodeScreenState extends State<SchoolCodeScreen>
    with SingleTickerProviderStateMixin {
  final _codeController = TextEditingController();
  late AnimationController _animCtrl;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onContinue() {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập mã trường'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    // Navigate to role selection directly with the code
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChooseSchoolScreen(initialCode: code),
      ),
    );
  }

  void _onSearchSchool() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChooseSchoolScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Blue header with illustration ──
          _buildHeader(context),

          // ── White bottom card ──
          Expanded(
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: _buildFormCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2196F3), Color(0xFF1976D2), Color(0xFF1565C0)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: SizedBox(
            height: 200,
            child: _buildIllustration(),
          ),
        ),
      ),
    );
  }

  /// Custom illustration using Flutter shapes – replaces the image asset
  Widget _buildIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Phone shape
        Positioned(
          child: Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school_rounded, size: 40, color: Colors.white.withOpacity(0.8)),
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Books
        Positioned(
          left: 40,
          bottom: 20,
          child: Transform.rotate(
            angle: -0.15,
            child: Column(
              children: [
                _buildBook(const Color(0xFFFFC107), 55, 12),
                _buildBook(const Color(0xFFE91E63), 50, 10),
                _buildBook(const Color(0xFF4CAF50), 45, 8),
              ],
            ),
          ),
        ),
        // Graduation cap
        Positioned(
          left: 50,
          top: 15,
          child: Icon(
            Icons.school,
            size: 36,
            color: Colors.yellow.shade600,
          ),
        ),
        // Person reading
        Positioned(
          right: 50,
          bottom: 30,
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: const Icon(Icons.person, size: 18, color: Colors.white),
              ),
              Container(
                width: 25,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        // Gear icon
        Positioned(
          right: 45,
          top: 25,
          child: Icon(
            Icons.settings,
            size: 22,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildBook(Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      transform: Matrix4.translationValues(0, -24, 0),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
        child: Column(
          children: [
            // Title
            const Text(
              'Nhập mã trường',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Vui lòng nhập mã/chọn trường để tiếp tục',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // Input row
            Row(
              children: [
                // Text field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFE0E6ED)),
                    ),
                    child: TextField(
                      controller: _codeController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'Nhập mã trường',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // QR / Search icon button
                Material(
                  color: const Color(0xFFF5F7FA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFFE0E6ED)),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _onSearchSchool,
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Color(0xFF1565C0),
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Arrow button
            GestureDetector(
              onTap: _onContinue,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF90CAF9), Color(0xFF64B5F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF64B5F6).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
