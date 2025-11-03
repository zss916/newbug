import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';

class ProfilePremium extends StatelessWidget {
  final Function onTap;
  const ProfilePremium({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 170.h),
      padding: EdgeInsetsDirectional.only(
        start: 12.w,
        end: 12.w,
        top: 20.h,
        bottom: 14.h,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFEEFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 14.h),
      child: Column(
        children: [
          Text(
            T.membership.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.sp,
              fontFamily: AppFonts.font1,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(top: 8.h),
            width: double.maxFinite,
            child: Text(
              T.membershipTitle.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap.call();
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(top: 16.h),
              width: double.infinity,
              height: 48.h,
              alignment: AlignmentDirectional.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFFF0092),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                T.getPremium.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
