import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';

class LoginBg extends StatelessWidget {
  const LoginBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 48.h + 20.h),
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [Image.asset(Assets.imgLoginBg, width: Get.width - 20.w)],
      ),
    );
  }
}
