import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key});

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
        'so if you’ve got a favorite bookstore, a weird hobby, or just want to swap stories over a virtual coffee, hit me up. Let’s make this more than just a scroll, yeah?​',
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
