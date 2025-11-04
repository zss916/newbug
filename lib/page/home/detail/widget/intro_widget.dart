import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroWidget extends StatelessWidget {
  final String sign;
  const IntroWidget({super.key, required this.sign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 20.h,
        bottom: 20.h,
      ),
      width: double.maxFinite,
      child: Text(
        sign,
        style: TextStyle(
          color: const Color(0xFF616161),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.12,
        ),
      ),
    );
  }
}
