import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  static const _kPrimary = Color(0xFF1A237E);
  static const _kAccent  = Color(0xFF283593);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B6E), _kPrimary, _kAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16, right: 16, bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
                  ),
                ),
                child: const Center(
                  child: Text('AD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Xin chào, Admin', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text('Quản trị hệ thống · HUIT', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ),
              Stack(children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                  child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                ),
                Positioned(right: 6, top: 6,
                  child: Container(width: 9, height: 9,
                    decoration: const BoxDecoration(color: Color(0xFFE85D75), shape: BoxShape.circle)),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _hStat('HK2 2025-2026', 'Học kỳ'),
                _hDiv(),
                _hStat('3 chờ duyệt', 'Đề xuất'),
                _hDiv(),
                _hStat('Thứ 2, 28/04', 'Hôm nay'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hStat(String v, String l) => Column(children: [
    Text(v, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
    const SizedBox(height: 2),
    Text(l, style: const TextStyle(color: Colors.white60, fontSize: 11)),
  ]);
  
  Widget _hDiv() => Container(width: 1, height: 28, color: Colors.white24);
}
