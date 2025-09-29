import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class NoVisitorView extends StatelessWidget {
  final double? bottomPadding;
  final Function onTap;
  const NoVisitorView({super.key, this.bottomPadding, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.statusVisitor, width: 100.r, height: 100.r),
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 32.w,
            end: 32.w,
            top: 18.h,
            bottom: 12.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.noVisitor.tr,
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
            T.noVisitorContent.tr,
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
            onTap.call();
          },
          child: Container(
            margin: EdgeInsetsDirectional.only(start: 32.w, end: 32.w),
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

        Divider(height: bottomPadding ?? 0.h, color: Colors.transparent),
      ],
    );
  }
}
