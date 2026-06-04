import 'package:flutter/material.dart';

class FunctionGrid extends StatelessWidget {
  const FunctionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.how_to_reg_outlined,
        'label': 'Điểm danh',
        'color': const Color(0xFF6B4FA0)
      },
      {
        'icon': Icons.qr_code_2_rounded,
        'label': 'QR Code',
        'color': const Color(0xFF4CAF50)
      },
      {
        'icon': Icons.grade_rounded,
        'label': 'Kết quả\nhọc tập',
        'color': const Color(0xFF2196F3)
      },
      {
        'icon': Icons.bar_chart_rounded,
        'label': 'Thống kê\ngiảng dạy',
        'color': const Color(0xFFE65100)
      },
      {
        'icon': Icons.monetization_on_outlined,
        'label': 'Thông tin\nlương',
        'color': const Color(0xFF2E7D32)
      },
      {
        'icon': Icons.library_books_outlined,
        'label': 'Tài liệu\nbài giảng',
        'color': const Color(0xFF5C6BC0)
      },
      {
        'icon': Icons.pending_actions_outlined,
        'label': 'Đề xuất\nlịch dạy',
        'color': const Color(0xFFE85D75)
      },
      {
        'icon': Icons.grid_view_rounded,
        'label': 'Tất cả',
        'color': const Color(0xFF6B4FA0)
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Chức năng',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.tune, size: 16, color: Color(0xFF616161)),
              label: const Text(
                'Tuỳ chỉnh',
                style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final item = features[index];
              final color = item['color'] as Color;
              return GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'] as IconData,
                          color: color, size: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF424242),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
