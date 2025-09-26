import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class CheckWidget extends StatefulWidget {
  final bool isCheck;
  final String title;
  const CheckWidget({super.key, required this.title, required this.isCheck});

  @override
  State<CheckWidget> createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: ShapeDecoration(
        color: widget.isCheck ? const Color(0x19FF0092) : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: widget.isCheck
                ? const Color(0xFFFF0092)
                : Colors.black.withValues(alpha: 0.50),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            Image.asset(
              widget.isCheck ? Assets.imgCheckedIcon : Assets.imgUncheckIcon,
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
