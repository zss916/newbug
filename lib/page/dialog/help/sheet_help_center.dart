import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';

void showHelpCenterSheet() {
  Get.bottomSheet(
    HelpCenter(),
    isDismissible: false,
    settings: RouteSettings(name: AppRoutes.helpCenterSheet),
  );
}

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

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
                ),
                child: Text(
                  T.helpCenter.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFD9D9D9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                width: double.maxFinite,
                child: Text(
                  T.helpCenterTitle.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFBFBFBF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(height: 1, color: Color(0xFF3B3B3B)),
              InkWell(
                onTap: () {
                  Get.back();
                  RouteManager.toChatCustomerService();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: T.onlineSupport.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: T.newTitle.tr,
                          style: TextStyle(
                            color: const Color(0xFFF74E57),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
                  copyEmail();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    T.copyEmailAddress.tr,
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

  Future<void> copyEmail() async {
    await Clipboard.setData(ClipboardData(text: App.contactUsEmail));
    CustomToast.showText("Copy success!");
  }
}
