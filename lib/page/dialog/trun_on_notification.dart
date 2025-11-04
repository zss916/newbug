import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';

//showTurnOnNotification();

/// 显示打开通知权限的对话框
void showTurnOnNotification() {
  Get.dialog(
    TurnOnNotificationWidget(),
    routeSettings: RouteSettings(name: AppRoutes.notificationDialog),
  );
}

class TurnOnNotificationWidget extends StatelessWidget {
  const TurnOnNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          padding: EdgeInsetsDirectional.all(0),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFFEF0FF),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                padding: EdgeInsetsDirectional.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.imgNotification,
                      width: 100.r,
                      height: 100.r,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 18.h),
                      width: double.maxFinite,
                      child: Text(
                        T.notificationTitle.tr,
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
                        top: 12.h,
                        bottom: 24.h,
                      ),
                      width: double.maxFinite,
                      child: Text(
                        T.notificationContent.tr,
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
                        Get.back();
                      },
                      child: Container(
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
                          T.ok.tr,
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
              ),
              PositionedDirectional(
                top: 10,
                end: 10,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.all(6.r),
                    child: Image.asset(
                      Assets.imgCloseDialog,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
