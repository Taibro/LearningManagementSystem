import 'package:flutter/material.dart';
import 'data/mock_extra_data.dart';

const Color _kPrimary = Color(0xFF1565C0);

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: kReceipts.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFE8E8E8)),
              itemBuilder: (_, i) => _ReceiptCard(receipt: kReceipts[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Phiếu thu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Illustration icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptCard extends StatelessWidget {
  final Receipt receipt;
  const _ReceiptCard({required this.receipt});

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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Số phiếu & ngày giờ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Số phiếu: ',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  children: [
                    TextSpan(
                      text: receipt.soPhieu,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                receipt.ngayGio,
                style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 2: Đơn vị thu
          Row(
            children: [
              const Text(
                'Đơn vị thu : ',
                style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
              ),
              Expanded(
                child: Text(
                  receipt.donViThu,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 3: Số tiền
          Row(
            children: [
              const Text(
                'Số tiền :',
                style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
              ),
              const Spacer(),
              Text(
                _formatMoney(receipt.soTien),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _kPrimary,
                ),
              ),
            ],
          ),
          // Link xem hóa đơn
          if (receipt.hasInvoice) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.open_in_new, size: 14, color: _kPrimary),
                const SizedBox(width: 4),
                Text(
                  'Xem hoá đơn điện tử',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _kPrimary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
