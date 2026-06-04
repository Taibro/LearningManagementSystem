import 'package:flutter/material.dart';
import 'data/mock_extra_data.dart';
import 'widgets/shared/custom_app_bar.dart';

const Color _kBg = Color(0xFFF0F4FF);

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Lịch sử giao dịch trực tuyến',
            isGradient: true,
            paddingBottom: 16,
            fontSize: 17,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: kTransactions.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE8E8E8)),
              itemBuilder: (_, i) => _TransactionRow(tx: kTransactions[i]),
            ),
          ),
        ],
      ),
    );
  }


}

class _TransactionRow extends StatelessWidget {
  final Transaction tx;
  const _TransactionRow({required this.tx});

  String _formatMoney(double amount) {
    final intAmount = amount.toInt();
    final str = intAmount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write('.');
    }
    return '${buffer.toString().split('').reversed.join()}đ';
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = tx.status == TransactionStatus.thanhCong;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.loai,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tx.ngayGio,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          // Right column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatMoney(tx.soTien),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isSuccess ? 'Thành công' : 'Giao dịch đã hủy',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSuccess ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
