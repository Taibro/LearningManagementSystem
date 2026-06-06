import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isGradient;
  final double paddingBottom;
  final double fontSize;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isGradient = false,
    this.paddingBottom = 14,
    this.fontSize = 18,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return Container(
      decoration: BoxDecoration(
        color: isGradient ? null : const Color(0xFF1565C0),
        gradient: isGradient
            ? const LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: paddingBottom,
      ),
      child: Row(
        children: [
          if (canPop)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            )
          else
            const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              textAlign: canPop || trailing != null ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (trailing != null) trailing! else SizedBox(width: canPop ? 48 : 16),
        ],
      ),
    );
  }
}
