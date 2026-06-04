import 'package:flutter/material.dart';
import '../../../screens/student/transaction_history_screen.dart';
import '../../../screens/student/receipt_screen.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const PaymentBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            const Text(
              'Thanh toán',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 20),
            // Grid of items
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildItem(
                  context,
                  icon: Icons.school_outlined,
                  color: const Color(0xFF1565C0),
                  bgColor: const Color(0xFFE3F2FD),
                  label: 'Thanh toán\nhọc phí',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to tuition payment
                  },
                ),
                _buildItem(
                  context,
                  icon: Icons.miscellaneous_services_outlined,
                  color: const Color(0xFF2E7D32),
                  bgColor: const Color(0xFFE8F5E9),
                  label: 'Thanh toán\ndịch vụ',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to service payment
                  },
                ),
                _buildItem(
                  context,
                  icon: Icons.request_page_outlined,
                  color: const Color(0xFFE65100),
                  bgColor: const Color(0xFFFFF3E0),
                  label: 'Thanh toán\nbiểu mẫu',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to form payment
                  },
                ),
                _buildItem(
                  context,
                  icon: Icons.history_rounded,
                  color: const Color(0xFF5E35B1),
                  bgColor: const Color(0xFFEDE7F6),
                  label: 'Lịch sử GD\ntrực tuyến',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TransactionHistoryScreen()),
                    );
                  },
                ),
                _buildItem(
                  context,
                  icon: Icons.receipt_long_outlined,
                  color: const Color(0xFF00695C),
                  bgColor: const Color(0xFFE0F2F1),
                  label: 'Phiếu thu\ntổng hợp',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ReceiptScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
