import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentClassCard extends StatefulWidget {
  const CurrentClassCard({super.key});

  @override
  State<CurrentClassCard> createState() => _CurrentClassCardState();
}

class _CurrentClassCardState extends State<CurrentClassCard> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int _currentPage = 0;

  final List<Map<String, dynamic>> classes = [
    {
      'status': 'Đang diễn ra',
      'room': 'Phòng A301',
      'subject': 'Khai phá dữ liệu',
      'time': 'Tiết 1 - 3 (07:00 - 09:30)',
      'isOnline': false,
    },
    {
      'status': 'Sắp diễn ra',
      'room': 'Google Meet',
      'subject': 'Lập trình Web nâng cao',
      'time': 'Tiết 4 - 6 (09:30 - 12:00)',
      'isOnline': true,
    },
    {
      'status': 'Chiều nay',
      'room': 'Phòng B102',
      'subject': 'Trí tuệ nhân tạo',
      'time': 'Tiết 7 - 9 (13:00 - 15:30)',
      'isOnline': false,
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 125, // Fixed height for the card
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: classes.length,
            itemBuilder: (context, index) {
              return _buildCard(classes[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            classes.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Map<String, dynamic> cls) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2), // Small gap between pages
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
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Icon Container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: cls['isOnline'] 
                        ? [const Color(0xFFFFE4E6), const Color(0xFFFFF1F2)]
                        : [const Color(0xFFE0E7FF), const Color(0xFFF1F5F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (cls['isOnline'] ? const Color(0xFFE85D75) : const Color(0xFF4F46E5)).withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    cls['isOnline'] ? Icons.video_call_rounded : Icons.school_rounded,
                    size: 28,
                    color: cls['isOnline'] ? const Color(0xFFE85D75) : const Color(0xFF4F46E5),
                  ),
                ).animate(onPlay: (AnimationController controller) => controller.repeat(reverse: true))
                 .moveY(begin: -2, end: 2, duration: 2.seconds, curve: Curves.easeInOut),
                 
                const SizedBox(width: 14),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${cls['status']} • ${cls['room']}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEF4444),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cls['subject'],
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF0F172A),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF64748B)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              cls['time'],
                              style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                // Go Button
                GestureDetector(
                  onTap: () {
                    if (_currentPage < classes.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    } else {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
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
                      size: 14,
                    ),
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
