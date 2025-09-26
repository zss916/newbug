import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class NotAction extends StatelessWidget {
  const NotAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 0.5],
          colors: [Color(0xD97E61FF), Colors.transparent],
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PositionedDirectional(
            bottom: 75.h,
            start: 0,
            child: Image.asset(Assets.decorationLove, width: 40.w),
          ),
          PositionedDirectional(
            bottom: 45.h,
            end: 70,
            child: Image.asset(Assets.decorationStar2, width: 50.w),
          ),
          Container(
            margin: EdgeInsetsDirectional.all(28),
            width: double.maxFinite,
            child: Text(
              T.noAction.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.14,
                letterSpacing: 0.38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
