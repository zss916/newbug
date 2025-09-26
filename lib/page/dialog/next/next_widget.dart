import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class NextWidget extends StatelessWidget {
  const NextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.r,
      height: 80.r,
      decoration: BoxDecoration(
        color: Color(0xFFF1EEFF),
        borderRadius: BorderRadius.circular(100),
      ),
      child: UnconstrainedBox(
        child: Image.asset(Assets.imgIcClose, width: 48.r, height: 48.r),
      ),
    );
  }
}
