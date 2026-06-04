import 'package:flutter/material.dart';
import 'widgets/shared/custom_app_bar.dart';

const Color _kBg = Color(0xFFF0F4FF);

/// Represents a feature that can appear on the home screen grid.
class FeatureItem {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  bool isOnHome;

  FeatureItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    this.isOnHome = true,
  });
}

class CustomizeFeaturesScreen extends StatefulWidget {
  const CustomizeFeaturesScreen({super.key});

  @override
  State<CustomizeFeaturesScreen> createState() =>
      _CustomizeFeaturesScreenState();
}

class _CustomizeFeaturesScreenState extends State<CustomizeFeaturesScreen> {
  late List<FeatureItem> _homeFeatures;
  late List<FeatureItem> _otherFeatures;

  @override
  void initState() {
    super.initState();
    _homeFeatures = [
      FeatureItem(
        icon: Icons.grade_rounded,
        label: 'Xem điểm',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
      ),
      FeatureItem(
        icon: Icons.star_rounded,
        label: 'Thành tích',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
      ),
      FeatureItem(
        icon: Icons.menu_book_rounded,
        label: 'Chương trình khung',
        color: const Color(0xFFC62828),
        bgColor: const Color(0xFFFFEBEE),
      ),
      FeatureItem(
        icon: Icons.monetization_on_outlined,
        label: 'Thanh toán học phí',
        color: const Color(0xFF2E7D32),
        bgColor: const Color(0xFFE8F5E9),
      ),
      FeatureItem(
        icon: Icons.receipt_long_outlined,
        label: 'Phiếu thu tổng hợp',
        color: const Color(0xFF00695C),
        bgColor: const Color(0xFFE0F2F1),
      ),
      FeatureItem(
        icon: Icons.how_to_reg_outlined,
        label: 'Thống kê điểm danh',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
      ),
      FeatureItem(
        icon: Icons.calendar_month_outlined,
        label: 'Lịch học/ lịch thi',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
      ),
    ];

    _otherFeatures = [
      FeatureItem(
        icon: Icons.emoji_events_outlined,
        label: 'Rèn luyện',
        color: const Color(0xFFC62828),
        bgColor: const Color(0xFFFFEBEE),
        isOnHome: false,
      ),
      FeatureItem(
        icon: Icons.article_outlined,
        label: 'Tin tức',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
        isOnHome: false,
      ),
      FeatureItem(
        icon: Icons.poll_outlined,
        label: 'Khảo sát',
        color: const Color(0xFFE65100),
        bgColor: const Color(0xFFFFF3E0),
        isOnHome: false,
      ),
    ];
  }

  void _removeFromHome(int index) {
    setState(() {
      final item = _homeFeatures.removeAt(index);
      item.isOnHome = false;
      _otherFeatures.add(item);
    });
  }

  void _addToHome(int index) {
    setState(() {
      final item = _otherFeatures.removeAt(index);
      item.isOnHome = true;
      _homeFeatures.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(title: 'Tuỳ chỉnh tính năng'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Tính năng trang chủ'),
                  _buildHomeList(),
                  if (_otherFeatures.isNotEmpty) ...[
                    _buildSectionTitle('Tính năng khác'),
                    _buildOtherList(),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF757575),
        ),
      ),
    );
  }

  Widget _buildHomeList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        buildDefaultDragHandles: false,
        proxyDecorator: (child, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: child,
              );
            },
            child: child,
          );
        },
        itemCount: _homeFeatures.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = _homeFeatures.removeAt(oldIndex);
            _homeFeatures.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final item = _homeFeatures[index];
          return Column(
            key: ValueKey('home_${item.label}'),
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    // Remove button
                    GestureDetector(
                      onTap: () => _removeFromHome(index),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE53935),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Icon
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item.bgColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(item.icon, color: item.color, size: 20),
                    ),
                    const SizedBox(width: 14),
                    // Label
                    Expanded(
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    // Drag handle
                    ReorderableDragStartListener(
                      index: index,
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.drag_handle,
                          color: Color(0xFFBDBDBD),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (index < _homeFeatures.length - 1)
                const Divider(
                    height: 1,
                    indent: 54,
                    color: Color(0xFFF0F0F0)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOtherList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _otherFeatures.length,
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          indent: 54,
          color: Color(0xFFF0F0F0),
        ),
        itemBuilder: (_, index) {
          final item = _otherFeatures[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Add button
                GestureDetector(
                  onTap: () => _addToHome(index),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFF43A047),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Icon
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.bgColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(item.icon, color: item.color, size: 20),
                ),
                const SizedBox(width: 14),
                // Label
                Expanded(
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
