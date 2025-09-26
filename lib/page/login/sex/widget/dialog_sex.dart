import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

void showSexDialog({required String select, required Function onConfirm}) {
  Get.dialog(
    Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Color(0xFFFDF0FF),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsetsDirectional.all(16),
          margin: EdgeInsetsDirectional.only(start: 18.w, end: 18.w),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 12.h, top: 25.h),
                    width: double.infinity,
                    child: Text(
                      T.sexDialogTitle.trArgs([select]),
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
                    margin: EdgeInsetsDirectional.only(start: 8, end: 8),
                    width: double.infinity,
                    child: Text(
                      T.sexDialogContent.tr,
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
                      onConfirm.call();
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 48,
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsetsDirectional.only(
                        bottom: 8.h,
                        start: 8.w,
                        end: 8.w,
                        top: 24.h,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF0092),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: Text(
                        T.ok.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              PositionedDirectional(
                top: 0,
                end: 0,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      Assets.imgCloseDialog,
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
