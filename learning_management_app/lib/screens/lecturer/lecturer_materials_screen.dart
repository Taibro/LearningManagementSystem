import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF8F9FA);

class LecturerMaterialsScreen extends StatefulWidget {
  const LecturerMaterialsScreen({super.key});

  @override
  State<LecturerMaterialsScreen> createState() =>
      _LecturerMaterialsScreenState();
}

class _LecturerMaterialsScreenState extends State<LecturerMaterialsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _materials = [
    {
      'name': 'Slide Chương 1 - Tổng quan',
      'subject': 'Kiến trúc máy tính',
      'type': 'slide',
      'size': '2.4 MB',
      'date': '12/03/2026',
      'status': 'approved',
    },
    {
      'name': 'Bài tập thực hành Lab 1',
      'subject': 'TH Quản trị HT Mạng',
      'type': 'doc',
      'size': '1.1 MB',
      'date': '15/03/2026',
      'status': 'approved',
    },
    {
      'name': 'Slide Chương 2 - Bộ xử lý',
      'subject': 'Kiến trúc máy tính',
      'type': 'slide',
      'size': '3.8 MB',
      'date': '20/03/2026',
      'status': 'pending',
    },
    {
      'name': 'Đề cương môn học HK2',
      'subject': 'Lập trình mạng',
      'type': 'doc',
      'size': '580 KB',
      'date': '01/02/2026',
      'status': 'approved',
    },
    {
      'name': 'Video bài giảng - Chương 3',
      'subject': 'An ninh mạng',
      'type': 'video',
      'size': '85 MB',
      'date': '25/03/2026',
      'status': 'pending',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const LecturerCustomAppBar(title: 'Tài liệu bài giảng'),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMaterialList(null),
                _buildMaterialList('approved'),
                _buildMaterialList('pending'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUploadDialog(context),
        backgroundColor: _kPrimary,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(Icons.upload_file_rounded, color: Colors.white, size: 20),
        label: Text(
          'Tải lên',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ).animate().scale(curve: Curves.easeOutBack, delay: 500.ms),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4FA0).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: _kPrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _kPrimary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF64748B),
        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 13),
        tabs: const [
          Tab(text: 'Tất cả'),
          Tab(text: 'Đã duyệt'),
          Tab(text: 'Chờ duyệt'),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildMaterialList(String? statusFilter) {
    final filtered = statusFilter == null
        ? _materials
        : _materials.where((m) => m['status'] == statusFilter).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_rounded, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Chưa có tài liệu',
              style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 15),
            ),
          ],
        ).animate().fadeIn().slideY(begin: 0.1),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final m = filtered[i];
        return _buildMaterialCard(m).animate().fadeIn(delay: (i * 100).ms).slideY(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildMaterialCard(Map<String, dynamic> material) {
    IconData typeIcon;
    Color typeColor;
    switch (material['type']) {
      case 'slide':
        typeIcon = Icons.slideshow_rounded;
        typeColor = const Color(0xFFF59E0B);
        break;
      case 'video':
        typeIcon = Icons.play_circle_fill_rounded;
        typeColor = const Color(0xFFEF4444);
        break;
      default:
        typeIcon = Icons.description_rounded;
        typeColor = const Color(0xFF3B82F6);
    }

    final isApproved = material['status'] == 'approved';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4FA0).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(typeIcon, color: typeColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  material['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${material['subject']}  ·  ${material['size']}',
                  style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B), fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Text(
                  material['date'],
                  style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isApproved
                  ? const Color(0xFFECFDF5)
                  : const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isApproved ? 'Đã duyệt' : 'Chờ duyệt',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isApproved
                    ? const Color(0xFF10B981)
                    : const Color(0xFFF59E0B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.cloud_upload_rounded, color: _kPrimary, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'Tải lên tài liệu',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 18, color: const Color(0xFF1E293B)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chức năng tải lên tài liệu sẽ được cập nhật trong phiên bản tiếp theo.',
              style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: const Color(0xFF475569)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Đóng', style: GoogleFonts.inter(color: _kPrimary, fontWeight: FontWeight.w700)),
          ),
        ],
      ).animate().scale(curve: Curves.easeOutBack, duration: 300.ms),
    );
  }
}
