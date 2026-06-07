import 'package:flutter/material.dart';

class DraggableChatbotButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color backgroundColor;
  final Offset initialOffset;

  const DraggableChatbotButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.backgroundColor,
    this.initialOffset = const Offset(0, 0),
  });

  @override
  State<DraggableChatbotButton> createState() => _DraggableChatbotButtonState();
}

class _DraggableChatbotButtonState extends State<DraggableChatbotButton> {
  Offset _offset = Offset.zero;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final size = MediaQuery.of(context).size;
      // Vị trí mặc định ở góc dưới bên phải, cách bottom nav bar một khoảng
      if (widget.initialOffset == Offset.zero) {
        _offset = Offset(size.width - 72, size.height - 150);
      } else {
        _offset = widget.initialOffset;
      }
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _offset += details.delta;
          });
        },
        onPanEnd: (details) {
          // Giới hạn trong màn hình khi thả ra
          final size = MediaQuery.of(context).size;
          double x = _offset.dx;
          double y = _offset.dy;

          if (x < 16) x = 16;
          if (x > size.width - 72) x = size.width - 72;
          if (y < 16) y = 16;
          // Có tính bottom nav bar (~100px)
          if (y > size.height - 100) y = size.height - 100;

          setState(() {
            _offset = Offset(x, y);
          });
        },
        child: FloatingActionButton(
          onPressed: widget.onPressed,
          backgroundColor: widget.backgroundColor,
          elevation: 4,
          child: Icon(widget.iconData, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
