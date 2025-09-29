import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class MatchView extends StatelessWidget {
  final Function? onTap;
  final Function? onImprove;
  final double? bottomPadding;
  const MatchView({super.key, this.onTap, this.onImprove, this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100.r,
          height: 100.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF7DEF9),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [Image.asset(Assets.imgMatch, width: 62.r, height: 62.r)],
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 32.w,
            end: 32.w,
            top: 18.h,
            bottom: 12.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.checkBackSoon.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF262626),
              fontSize: 32.sp,
              fontFamily: AppFonts.font1,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 32.w,
            end: 32.w,
            bottom: 32.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.matchContent.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF595959),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            margin: EdgeInsetsDirectional.only(
              start: 32.w,
              end: 32.w,
              bottom: 11.h,
            ),
            width: double.maxFinite,
            height: 48.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            decoration: ShapeDecoration(
              color: const Color(0xFFFF0092),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              T.goToMatch.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            onImprove?.call();
          },
          child: Container(
            padding: EdgeInsetsDirectional.all(5),
            child: Text(
              T.improveYourProfile.tr,
              style: TextStyle(
                color: const Color(0xFF8C8C8C),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),

        Divider(height: bottomPadding ?? 0.h, color: Colors.transparent),
      ],
    );
  }
}
