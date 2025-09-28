import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeLeft extends StatelessWidget {
  const LikeLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Left',
              style: TextStyle(
                color: const Color(0xFFD9D9D9),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: const Color(0xFFD9D9D9),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
            TextSpan(
              text: '7',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: const Color(0xFFD9D9D9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Hours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' \n',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
            TextSpan(
              text: 'to like back',
              style: TextStyle(
                color: const Color(0xFFD9D9D9),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
