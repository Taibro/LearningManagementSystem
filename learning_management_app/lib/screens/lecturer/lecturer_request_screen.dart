import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF8F9FA);

class LecturerRequestScreen extends StatefulWidget {
  final int initialTabIndex;
  const LecturerRequestScreen({super.key, this.initialTabIndex = 0});

  @override
  State<LecturerRequestScreen> createState() => _LecturerRequestScreenState();
}

class _LecturerRequestScreenState extends State<LecturerRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _pauseHistory = [
    {'class': '14DHTH04', 'date': '15/03/2026', 'reason': 'Tham dự hội thảo khoa học', 'status': 'approved'},
    {'class': '14DHTH03', 'date': '22/02/2026', 'reason': 'Ốm, có giấy tờ y tế', 'status': 'pending'},
  ];

  final List<Map<String, dynamic>> _makeupHistory = [
    {'class': '16DHTH10', 'date': '28/03/2026', 'reason': 'Bù tiết ngày 15/03', 'status': 'approved'},
    {'class': '14DHTH04', 'date': '02/04/2026', 'reason': 'Bù tiết ngày 22/02', 'status': 'pending'},
  ];

  final List<Map<String, dynamic>> _substituteHistory = [
    {'class': '16DHTH07', 'date': '10/01/2026', 'reason': 'Dạy thay GV Trần Văn B', 'status': 'rejected'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTabIndex);
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
          const LecturerCustomAppBar(title: 'Đề xuất lịch dạy'),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _RequestTab(
                  type: 'tamNgung',
                  history: _pauseHistory,
                  title: 'Tạm ngừng',
                ),
                _RequestTab(
                  type: 'dayBu',
                  history: _makeupHistory,
                  title: 'Dạy bù',
                ),
                _RequestTab(
                  type: 'dayThay',
                  history: _substituteHistory,
                  title: 'Dạy thay',
                ),
              ],
            ),
          ),
        ],
      ),
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
          Tab(text: 'Tạm ngừng'),
          Tab(text: 'Dạy bù'),
          Tab(text: 'Dạy thay'),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }
}

class _RequestTab extends StatelessWidget {
  final String type;
  final List<Map<String, dynamic>> history;
  final String title;

  const _RequestTab({
    required this.type,
    required this.history,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create new request button
          GestureDetector(
            onTap: () => _showCreateForm(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B6BBF), Color(0xFF6B4FA0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _kPrimary.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Tạo đề xuất $title',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn().slideY(begin: 0.1),

          const SizedBox(height: 32),

          // History header
          Text(
            'Lịch sử đề xuất',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
          const SizedBox(height: 16),

          // History items
          if (history.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Icon(Icons.inbox_rounded, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có đề xuất nào',
                    style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 15),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms)
          else
            ...history.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildHistoryCard(item).animate().fadeIn(delay: (200 + index * 100).ms).slideY(begin: 0.1);
            }),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    Color statusColor;
    String statusLabel;
    IconData statusIcon;
    Color bgColor;

    switch (item['status']) {
      case 'approved':
        statusColor = const Color(0xFF10B981);
        statusLabel = 'Đã duyệt';
        statusIcon = Icons.check_circle_rounded;
        bgColor = const Color(0xFFECFDF5);
        break;
      case 'rejected':
        statusColor = const Color(0xFFEF4444);
        statusLabel = 'Từ chối';
        statusIcon = Icons.cancel_rounded;
        bgColor = const Color(0xFFFEF2F2);
        break;
      default:
        statusColor = const Color(0xFFF59E0B);
        statusLabel = 'Chờ duyệt';
        statusIcon = Icons.schedule_rounded;
        bgColor = const Color(0xFFFFFBEB);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _kPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.class_rounded, color: _kPrimary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['class'],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        item['date'],
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      statusLabel,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, color: Color(0xFF94A3B8), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item['reason'],
                    style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475569), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CreateRequestSheet(type: type, title: title),
    );
  }
}

class _CreateRequestSheet extends StatelessWidget {
  final String type;
  final String title;

  const _CreateRequestSheet({required this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.edit_document, color: _kPrimary, size: 24),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tạo đề xuất $title',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Điền đầy đủ các thông tin bên dưới',
                      style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9), thickness: 1.5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormField('Lớp học phần', 'Chọn lớp học phần', isDropdown: true),
                  const SizedBox(height: 20),
                  _buildFormField('Ngày', 'DD/MM/YYYY', isDate: true),
                  const SizedBox(height: 20),
                  _buildFormField('Ca học', 'Chọn ca học', isDropdown: true),
                  const SizedBox(height: 20),
                  if (type == 'dayBu') ...[
                    _buildFormField('Ngày dạy bù', 'DD/MM/YYYY', isDate: true),
                    const SizedBox(height: 20),
                    _buildFormField('Phòng học', 'VD: A401'),
                    const SizedBox(height: 20),
                  ],
                  if (type == 'dayThay') ...[
                    _buildFormField('Giảng viên dạy thay', 'Chọn giảng viên', isDropdown: true),
                    const SizedBox(height: 20),
                  ],
                  Text('Lý do', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF475569))),
                  const SizedBox(height: 8),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Nhập lý do chi tiết...',
                          style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF94A3B8))),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _kPrimary.withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Gửi đề xuất',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildFormField(String label, String hint,
      {bool isDropdown = false, bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF475569))),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hint, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF94A3B8))),
              if (isDropdown)
                const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B), size: 22)
              else if (isDate)
                const Icon(Icons.calendar_month_rounded, color: Color(0xFF64748B), size: 20),
            ],
          ),
        ),
      ],
    );
  }
}
