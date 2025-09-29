import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';

void showAccountSheet() {
  Get.bottomSheet(
    AccountWidget(),
    isDismissible: false,
    settings: RouteSettings(name: AppRoutes.helpCenterSheet),
  );
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsetsDirectional.only(start: 8.w, end: 8.w),
          decoration: ShapeDecoration(
            color: Color(0xA6000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                child: Text(
                  T.reminder.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFD9D9D9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(height: 1, color: Color(0xFF3B3B3B)),
              InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    T.logOut.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Divider(height: 1, color: Color(0xFF3B3B3B)),
              InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    T.deleteAccount.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          margin: EdgeInsetsDirectional.only(
            top: 8.h,
            start: 8.w,
            end: 8.w,
            bottom: 20.h,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: () => Get.back(),
            child: Container(
              alignment: AlignmentDirectional.center,
              width: double.infinity,
              height: 60.h,
              decoration: ShapeDecoration(
                color: Color(0xA6000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Text(
                T.cancel.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF0A84FF),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
