import 'package:flutter/material.dart';
import '../../data/mock_attendance_data.dart';

class GradesTab extends StatelessWidget {
  const GradesTab({super.key});

  double _computeTotal(Map<String, dynamic> g) =>
      g['cc'] * 0.1 + g['gk'] * 0.3 + g['ck'] * 0.6;

  String _gradeLabel(double total) {
    if (total >= 9.0) return 'Xuất sắc';
    if (total >= 8.0) return 'Giỏi';
    if (total >= 7.0) return 'Khá';
    if (total >= 5.0) return 'Trung bình';
    return 'Không đạt';
  }

  Color _gradeLabelColor(double total) {
    if (total >= 9.0) return const Color(0xFF2E7D32);
    if (total >= 7.0) return const Color(0xFF1565C0);
    if (total >= 5.0) return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  @override
  Widget build(BuildContext context) {
    final avg = kGrades.fold<double>(
            0, (sum, g) => sum + _computeTotal(g)) /
        kGrades.length;
    final passed = kGrades.where((g) => _computeTotal(g) >= 5.0).length;
    final failed = kGrades.where((g) => _computeTotal(g) < 5.0).length;
    final excellent = kGrades.where((g) => _computeTotal(g) >= 9.0).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter
          _buildGradesFilter(context),
          const SizedBox(height: 14),
          // Summary stats
          Row(
            children: [
              _buildGradeStat(avg.toStringAsFixed(1), 'Điểm TB',
                  const Color(0xFF6B4FA0)),
              const SizedBox(width: 8),
              _buildGradeStat('$passed', 'Đạt (≥5)', const Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              _buildGradeStat('$failed', 'Không đạt', const Color(0xFFC62828)),
              const SizedBox(width: 8),
              _buildGradeStat(
                  '$excellent', 'Xuất sắc', const Color(0xFFE65100)),
            ],
          ),
          const SizedBox(height: 14),
          // Grade table
          _buildGradeTable(context),
        ],
      ),
    );
  }

  Widget _buildGradesFilter(BuildContext context) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lớp học phần',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0D8F0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('010110195604 - 14DHTH04',
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF6B4FA0), size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Tìm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _showSnack(context, 'Xuất Excel'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF6B4FA0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.table_chart_outlined,
                          color: Color(0xFF6B4FA0), size: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradeStat(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(top: BorderSide(color: color, width: 3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeTable(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF9F7FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                SizedBox(
                    width: 24,
                    child: Text('#',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color(0xFF6B4FA0)))),
                SizedBox(width: 8),
                Expanded(
                    flex: 3,
                    child: Text('Họ tên',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(
                    width: 36,
                    child: Text('CC\n10%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(
                    width: 36,
                    child: Text('GK\n30%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(
                    width: 36,
                    child: Text('CK\n60%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Color(0xFF424242)))),
                SizedBox(width: 4),
                SizedBox(
                    width: 38,
                    child: Text('Tổng',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color(0xFF424242)))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ...kGrades.asMap().entries.map((entry) {
            final i = entry.key;
            final g = entry.value;
            final total = _computeTotal(g);
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF9E9E9E))),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(g['name'],
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                            Text(g['mssv'],
                                style: const TextStyle(
                                    fontSize: 10, color: Color(0xFF9E9E9E))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            '${g['cc']}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text('${g['gk']}',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text('${g['ck']}',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 38,
                        child: Column(
                          children: [
                            Text(
                              total.toStringAsFixed(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _gradeLabelColor(total),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color:
                                    _gradeLabelColor(total).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _gradeLabel(total),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: _gradeLabelColor(total),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < kGrades.length - 1)
                  const Divider(height: 1, indent: 16, color: Color(0xFFF0F0F0)),
              ],
            );
          }),
          // Actions
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildActionBtn(context, 'Lưu điểm', const Color(0xFF6B4FA0),
                    Icons.save_outlined),
                const SizedBox(width: 8),
                _buildActionBtn(context, 'Khóa điểm', const Color(0xFF2E7D32),
                    Icons.lock_outline_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(
      BuildContext context, String label, Color color, IconData icon) {
    return GestureDetector(
      onTap: () => _showSnack(context, label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 15),
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF6B4FA0),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
