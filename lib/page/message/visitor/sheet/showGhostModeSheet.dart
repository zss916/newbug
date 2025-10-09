import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';

/// Ghost Mode
void showGhostModeSheet({required Function onSave}) {
  Get.bottomSheet(
    GhostMode(onSave: onSave),
    settings: RouteSettings(name: AppRoutes.ghostModeSheet),
  );
}

class GhostMode extends StatefulWidget {
  final Function onSave;
  const GhostMode({super.key, required this.onSave});

  @override
  State<GhostMode> createState() => _GhostModeState();
}

class _GhostModeState extends State<GhostMode> {
  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      //constraints: BoxConstraints(minHeight: 400.h),
      decoration: BoxDecoration(
        color: Color(0xFFF1EEFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 5,
            margin: EdgeInsets.only(top: 10.h),
            decoration: ShapeDecoration(
              color: Colors.black.withValues(alpha: 0.30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32.h, bottom: 24.h),
            width: double.maxFinite,
            child: Text(
              T.ghostMode.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                height: 0.83,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectIndex = 0;
              });
            },
            child: Container(
              margin: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: selectIndex == 0
                      ? BorderSide(width: 1)
                      : BorderSide(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Image.asset(Assets.imgTurnOnIcon, width: 40, height: 40),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.turnOn.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.turnOnCount.tr,
                            style: TextStyle(
                              color: const Color(0xFFBFBFBF),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 5.w),
                    child: Image.asset(
                      selectIndex == 0
                          ? Assets.imgCheckedIcon
                          : Assets.imgUncheckIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.transparent, height: 12.h),
          GestureDetector(
            onTap: () {
              setState(() {
                selectIndex = 1;
              });
            },
            child: Container(
              margin: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: selectIndex == 1
                      ? BorderSide(width: 1)
                      : BorderSide(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Image.asset(Assets.imgTurnOffIcon, width: 40, height: 40),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.turnOff.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.turnOffCount.tr,
                            style: TextStyle(
                              color: const Color(0xFFBFBFBF),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 5.w),
                    child: Image.asset(
                      selectIndex == 1
                          ? Assets.imgCheckedIcon
                          : Assets.imgUncheckIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              widget.onSave.call();
            },
            child: Container(
              width: double.maxFinite,
              height: 48,
              margin: EdgeInsetsDirectional.only(
                start: 15.w,
                top: 24.h,
                end: 15.w,
                bottom: 48.h,
              ),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFFF0092),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                T.save.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
