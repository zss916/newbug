import 'package:flutter/material.dart';

@immutable
class InterestTag extends StatefulWidget {
  bool isSelected;
  final String title;
  InterestTag({super.key, required this.isSelected, required this.title});

  @override
  State<InterestTag> createState() => _InterestTagState();
}

class _InterestTagState extends State<InterestTag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: widget.isSelected
              ? Color(0x19FF0092)
              : Colors.black.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: widget.isSelected
                  ? Color(0xFFFF0092)
                  : Colors.black.withValues(alpha: 0.10),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.isSelected ? Color(0xFFFF0092) : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
