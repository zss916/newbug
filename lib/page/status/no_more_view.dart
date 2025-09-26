import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class NoMoreView extends StatelessWidget {
  const NoMoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.statusNoMore, width: 100.r, height: 100.r),
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 32.w,
            end: 32.w,
            top: 18.h,
            bottom: 12.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.noMorePeople.tr,
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
            T.noMorePeopleContent.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF595959),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Divider(height: 0.h, color: Colors.transparent),
      ],
    );
  }
}
