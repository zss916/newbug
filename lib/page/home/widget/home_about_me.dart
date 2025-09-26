import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class HomeAboutMe extends StatelessWidget {
  const HomeAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 18.h),
          child: Text(
            T.aboutMe.tr,
            style: TextStyle(
              color: const Color(0xFF303133),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 8.h),
          child: Text(
            'Stray birds of summer come to my window to sing and fly away.\nAnd yellow leaves of autumn, which have no songs, flutter and fall there with a sigh.\nIf you shed tears when you miss the sun, you also miss the stars.\nflutter and fall there with a sigh.\nIf you shed tears when you miss the sun, you also miss the stars.\nflutter and fall there with a sigh.\nIf you shed tears when you miss the sun, you also miss the stars.',
            style: TextStyle(
              color: const Color(0xFF7A7A7A),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
