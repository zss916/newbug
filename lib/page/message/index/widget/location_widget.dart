import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 3.w, end: 3.w, bottom: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFF7DEF9),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.80,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.imgLocation, width: 11, height: 11),
          Container(
            constraints: BoxConstraints(maxWidth: 60.w),
            child: Text(
              'Columbusddd',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF7D60FF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
