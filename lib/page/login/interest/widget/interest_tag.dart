import 'package:flutter/material.dart';
import 'package:newbug/core/network/model/tag_entity.dart';

class InterestTag extends StatefulWidget {
  final TagEntity tag;

  const InterestTag({super.key, required this.tag});

  @override
  State<InterestTag> createState() => _InterestTagState();
}

class _InterestTagState extends State<InterestTag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.tag.isSelected = !(widget.tag.isSelected ?? false);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: (widget.tag.isSelected ?? false)
              ? Color(0x19FF0092)
              : Colors.black.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: (widget.tag.isSelected ?? false)
                  ? Color(0xFFFF0092)
                  : Colors.black.withValues(alpha: 0.10),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "# ${widget.tag.title ?? ""}",
          style: TextStyle(
            color: (widget.tag.isSelected ?? false)
                ? Color(0xFFFF0092)
                : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
