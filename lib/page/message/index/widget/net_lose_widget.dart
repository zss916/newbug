import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class NetLoseWidget extends StatelessWidget {
  const NetLoseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: 14.h,
        start: 14.w,
        end: 14.w,
        bottom: 12.h,
      ),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFFF74E57),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 8.w),
            child: Image.asset(Assets.imgNetLose, width: 20, height: 20),
          ),
          Text(
            T.netLose.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
