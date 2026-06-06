import 'package:flutter/material.dart';
import 'widgets/shared/lecturer_custom_app_bar.dart';

const Color _kPrimary = Color(0xFF6B4FA0);
const Color _kBg = Color(0xFFF4F1F8);

class LecturerRequestScreen extends StatefulWidget {
  const LecturerRequestScreen({super.key});

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
          const LecturerCustomAppBar(title: 'Đề xuất lịch dạy'),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _RequestTab(
                  type: 'tamNgung',
                  history: _pauseHistory,
                  title: 'Tạm ngừng lịch dạy',
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
      color: _kPrimary,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Tạm ngừng'),
          Tab(text: 'Dạy bù'),
          Tab(text: 'Dạy thay'),
        ],
      ),
    );
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create new request button
          GestureDetector(
            onTap: () => _showCreateForm(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _kPrimary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Tạo đề xuất $title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // History header
          const Text(
            'Lịch sử đề xuất',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 12),

          // History items
          if (history.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Text(
                    'Chưa có đề xuất nào',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            )
          else
            ...history.map((item) => _buildHistoryCard(item)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    Color statusColor;
    String statusLabel;
    IconData statusIcon;
    switch (item['status']) {
      case 'approved':
        statusColor = const Color(0xFF4CAF50);
        statusLabel = 'Đã duyệt';
        statusIcon = Icons.check_circle_outline;
        break;
      case 'rejected':
        statusColor = const Color(0xFFC62828);
        statusLabel = 'Từ chối';
        statusIcon = Icons.cancel_outlined;
        break;
      default:
        statusColor = const Color(0xFFE65100);
        statusLabel = 'Chờ duyệt';
        statusIcon = Icons.access_time;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.class_outlined, color: _kPrimary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${item['class']} · ${item['date']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF212121),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12, color: statusColor),
                    const SizedBox(width: 3),
                    Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Lý do: ${item['reason']}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF616161)),
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
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0D8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit_note_rounded, color: _kPrimary, size: 22),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tạo đề xuất $title',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const Text(
                      'Điền thông tin bên dưới',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildFormField('Lớp học phần', '010110195604 - 14DHTH04', isDropdown: true),
                  const SizedBox(height: 12),
                  _buildFormField('Ngày', '25/04/2026', isDate: true),
                  const SizedBox(height: 12),
                  _buildFormField('Ca học', 'Sáng (Tiết 1–3)', isDropdown: true),
                  const SizedBox(height: 12),
                  if (type == 'dayBu') ...[
                    _buildFormField('Ngày dạy bù', '28/04/2026', isDate: true),
                    const SizedBox(height: 12),
                    _buildFormField('Phòng học', 'VD: A401'),
                    const SizedBox(height: 12),
                  ],
                  if (type == 'dayThay') ...[
                    _buildFormField('Giảng viên dạy thay', 'Chọn giảng viên', isDropdown: true),
                    const SizedBox(height: 12),
                  ],
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Lý do',
                        style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0D8F0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Nhập lý do đề xuất...',
                          style: TextStyle(fontSize: 13, color: Color(0xFFBDBDBD))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6B4FA0), Color(0xFF8B6BBF)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: _kPrimary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('📤  Gửi đề xuất',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint,
      {bool isDropdown = false, bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF616161))),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0D8F0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hint,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF424242))),
              if (isDropdown)
                const Icon(Icons.keyboard_arrow_down,
                    color: _kPrimary, size: 18)
              else if (isDate)
                const Icon(Icons.calendar_today_outlined,
                    color: _kPrimary, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
