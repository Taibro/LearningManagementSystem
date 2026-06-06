import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../widgets/shared/custom_app_bar.dart';
import '../widgets/shared/mesh_background.dart';
import '../data/mock_features_data.dart';

class ConductScreen extends StatefulWidget {
  const ConductScreen({super.key});

  @override
  State<ConductScreen> createState() => _ConductScreenState();
}

class _ConductScreenState extends State<ConductScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentScore = kConductScores[_selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: MeshBackground(
        child: Column(
          children: [
            const CustomAppBar(title: 'Điểm Rèn luyện', isGradient: true),
            
            // Semester Selector
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: kConductScores.length,
                itemBuilder: (context, i) {
                  final isSelected = i == _selectedIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF4F46E5) : Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
                          width: 2,
                        ),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ] : [],
                      ),
                      child: Center(
                        child: Text(
                          kConductScores[i].semester,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).animate().fade(duration: 400.ms).slideX(begin: 0.1, end: 0),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Score Circle
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withOpacity(0.1),
                            blurRadius: 32,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 160,
                            child: CircularProgressIndicator(
                              value: currentScore.totalScore / 100,
                              strokeWidth: 16,
                              backgroundColor: const Color(0xFFE2E8F0),
                              color: const Color(0xFF10B981),
                              strokeCap: StrokeCap.round,
                            ),
                          ).animate(key: ValueKey(_selectedIndex)).scale(duration: 800.ms, curve: Curves.easeOutBack),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${currentScore.totalScore}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF0F172A),
                                ),
                              ).animate(key: ValueKey(_selectedIndex)).fade(duration: 600.ms).slideY(begin: 0.2, end: 0),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  currentScore.classification,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF059669),
                                  ),
                                ),
                              ).animate(key: ValueKey('c_$_selectedIndex')).fade(delay: 200.ms),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fade().slideY(begin: -0.1, end: 0),

                    const SizedBox(height: 32),

                    // Details List
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(20),
                            itemCount: currentScore.details.length,
                            separatorBuilder: (_, __) => Divider(color: Colors.grey.shade200, height: 24),
                            itemBuilder: (context, i) {
                              final detail = currentScore.details[i];
                              return _buildDetailRow(detail)
                                  .animate(key: ValueKey('${_selectedIndex}_$i'))
                                  .fade(duration: 400.ms, delay: (100 * i).ms)
                                  .slideY(begin: 0.1, end: 0);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(ConductDetail detail) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4F46E5).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.check_circle_rounded, color: Color(0xFF4F46E5), size: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: detail.achievedScore / detail.maxScore,
                  backgroundColor: const Color(0xFFE2E8F0),
                  color: const Color(0xFF4F46E5),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
            text: '${detail.achievedScore}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
            children: [
              TextSpan(
                text: '/${detail.maxScore}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
