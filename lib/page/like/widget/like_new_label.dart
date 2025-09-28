import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class LikeNewLabel extends StatelessWidget {
  const LikeNewLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 20,
      alignment: AlignmentDirectional.center,
      margin: EdgeInsetsDirectional.only(top: 6.h),
      padding: const EdgeInsets.symmetric(horizontal: 2.40, vertical: 1.60),
      decoration: ShapeDecoration(
        color: const Color(0xFFF5222D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        T.newKey.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          height: 1.33,
        ),
      ),
    );
  }
}
