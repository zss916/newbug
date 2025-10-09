import 'package:flutter/material.dart';

class SelectTabBar extends StatelessWidget {
  final bool isSelected;
  final String title;
  const SelectTabBar({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: ShapeDecoration(
        color: isSelected ? const Color(0xFFFF0092) : Color(0xFFF3F2FA),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: isSelected ? Color(0xFFFF0092) : const Color(0xFF7D60FF),
          ),
          borderRadius: BorderRadius.circular(70),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
