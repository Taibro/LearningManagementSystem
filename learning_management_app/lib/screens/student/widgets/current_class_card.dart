import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentClassCard extends StatelessWidget {
  const CurrentClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Stack(
        children: [
          // Subtle background gradient element
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [const Color(0xFF0EA5E9).withOpacity(0.1), Colors.transparent],
                  center: Alignment.bottomRight,
                  radius: 1.0,
                ),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24)),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Icon Container
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0E7FF), Color(0xFFF1F5F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 32,
                    color: Color(0xFF4F46E5),
                  ),
                ).animate(onPlay: (AnimationController controller) => controller.repeat(reverse: true))
                 .moveY(begin: -2, end: 2, duration: 2.seconds, curve: Curves.easeInOut),
                 
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Đang diễn ra • Phòng A301',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEF4444),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Khai phá dữ liệu',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF0F172A),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF64748B)),
                          const SizedBox(width: 4),
                          Text(
                            'Tiết 1 - 3 (07:00 - 09:30)',
                            style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Go Button
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
