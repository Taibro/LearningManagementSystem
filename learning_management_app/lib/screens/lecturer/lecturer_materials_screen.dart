import 'package:flutter/material.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

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
        icon: const Icon(Icons.upload_file, color: Colors.white),
        label: const Text('Tải lên',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: _kPrimary,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Tất cả'),
          Tab(text: 'Đã duyệt'),
          Tab(text: 'Chờ duyệt'),
        ],
      ),
    );
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
            Icon(Icons.folder_open_outlined, size: 56, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'Chưa có tài liệu',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final m = filtered[i];
        return _buildMaterialCard(m);
      },
    );
  }

  Widget _buildMaterialCard(Map<String, dynamic> material) {
    IconData typeIcon;
    Color typeColor;
    switch (material['type']) {
      case 'slide':
        typeIcon = Icons.slideshow_rounded;
        typeColor = const Color(0xFFE65100);
        break;
      case 'video':
        typeIcon = Icons.play_circle_outline;
        typeColor = const Color(0xFFC62828);
        break;
      default:
        typeIcon = Icons.description_outlined;
        typeColor = const Color(0xFF5C6BC0);
    }

    final isApproved = material['status'] == 'approved';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(typeIcon, color: typeColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  material['name'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${material['subject']}  ·  ${material['size']}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
                const SizedBox(height: 3),
                Text(
                  material['date'],
                  style: const TextStyle(fontSize: 10, color: Color(0xFFBDBDBD)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isApproved
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isApproved ? 'Đã duyệt' : 'Chờ duyệt',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isApproved
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFE65100),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.upload_file, color: _kPrimary, size: 22),
            SizedBox(width: 8),
            Text('Tải lên tài liệu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chức năng tải lên tài liệu sẽ được cập nhật trong phiên bản tiếp theo.',
              style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF616161)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Đóng',
                style: TextStyle(color: _kPrimary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
