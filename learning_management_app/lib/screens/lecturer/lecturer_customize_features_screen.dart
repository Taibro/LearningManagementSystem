import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../student/widgets/shared/custom_app_bar.dart';

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

class LecturerCustomizeFeaturesScreen extends StatefulWidget {
  const LecturerCustomizeFeaturesScreen({super.key});

  @override
  State<LecturerCustomizeFeaturesScreen> createState() =>
      _LecturerCustomizeFeaturesScreenState();
}

class _LecturerCustomizeFeaturesScreenState extends State<LecturerCustomizeFeaturesScreen> {
  late List<FeatureItem> _homeFeatures;
  late List<FeatureItem> _otherFeatures;

  late List<FeatureItem> _allFeatures;

  @override
  void initState() {
    super.initState();
    _allFeatures = [
      FeatureItem(icon: Icons.how_to_reg_rounded, label: 'Điểm danh', color: const Color(0xFF6B4FA0), bgColor: const Color(0xFF6B4FA0).withOpacity(0.1)),
      FeatureItem(icon: Icons.qr_code_2_rounded, label: 'QR Code', color: const Color(0xFF10B981), bgColor: const Color(0xFF10B981).withOpacity(0.1)),
      FeatureItem(icon: Icons.grade_rounded, label: 'Kết quả\nhọc tập', color: const Color(0xFF3B82F6), bgColor: const Color(0xFF3B82F6).withOpacity(0.1)),
      FeatureItem(icon: Icons.bar_chart_rounded, label: 'Thống kê\ngiảng dạy', color: const Color(0xFFF59E0B), bgColor: const Color(0xFFF59E0B).withOpacity(0.1)),
      FeatureItem(icon: Icons.account_balance_wallet_rounded, label: 'Thông tin\nlương', color: const Color(0xFF2E7D32), bgColor: const Color(0xFF2E7D32).withOpacity(0.1)),
      FeatureItem(icon: Icons.library_books_rounded, label: 'Tài liệu\nbài giảng', color: const Color(0xFF5C6BC0), bgColor: const Color(0xFF5C6BC0).withOpacity(0.1)),
      FeatureItem(icon: Icons.edit_document, label: 'Đề xuất\nlịch dạy', color: const Color(0xFFEC4899), bgColor: const Color(0xFFEC4899).withOpacity(0.1)),
      FeatureItem(icon: Icons.chat_rounded, label: 'Trò chuyện', color: const Color(0xFFE11D48), bgColor: const Color(0xFFE11D48).withOpacity(0.1)),
    ];
    _homeFeatures = [];
    _otherFeatures = [];
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedHomeLabels = prefs.getStringList('lecturer_home_features');

    setState(() {
      if (savedHomeLabels != null) {
        _homeFeatures = savedHomeLabels.map((label) {
          final item = _allFeatures.firstWhere((f) => f.label == label, orElse: () => _allFeatures.first);
          item.isOnHome = true;
          return item;
        }).toList();
        
        _otherFeatures = _allFeatures.where((f) => !savedHomeLabels.contains(f.label)).toList();
        for (var item in _otherFeatures) {
          item.isOnHome = false;
        }
      } else {
        final defaultHome = ['Điểm danh', 'QR Code', 'Kết quả\nhọc tập', 'Thống kê\ngiảng dạy', 'Thông tin\nlương', 'Tài liệu\nbài giảng', 'Đề xuất\nlịch dạy'];
        _homeFeatures = _allFeatures.where((f) => defaultHome.contains(f.label)).toList();
        for (var item in _homeFeatures) {
          item.isOnHome = true;
        }
        _otherFeatures = _allFeatures.where((f) => !defaultHome.contains(f.label)).toList();
        for (var item in _otherFeatures) {
          item.isOnHome = false;
        }
      }
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final homeLabels = _homeFeatures.map((e) => e.label).toList();
    await prefs.setStringList('lecturer_home_features', homeLabels);
  }

  void _removeFromHome(int index) {
    setState(() {
      final item = _homeFeatures.removeAt(index);
      item.isOnHome = false;
      _otherFeatures.add(item);
    });
    _savePreferences();
  }

  void _addToHome(int index) {
    setState(() {
      final item = _otherFeatures.removeAt(index);
      item.isOnHome = true;
      _homeFeatures.add(item);
    });
    _savePreferences();
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
          _savePreferences();
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
