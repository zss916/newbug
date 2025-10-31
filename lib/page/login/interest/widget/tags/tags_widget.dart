import 'package:flutter/material.dart';

class TagsWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  const TagsWidget({super.key, required this.isSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: isSelected
            ? Color(0x19FF0092)
            : Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: isSelected
                ? Color(0xFFFF0092)
                : Colors.black.withValues(alpha: 0.10),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        "# $title",
        style: TextStyle(
          color: isSelected ? Color(0xFFFF0092) : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
