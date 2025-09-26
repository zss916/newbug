import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

/// 显示弹窗
void showWildPhoto() {
  Get.dialog(WildPhotoWidget());
}

class WildPhotoWidget extends StatelessWidget {
  const WildPhotoWidget({super.key});

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
                      Assets.imgWildPhoto,
                      width: 100.r,
                      height: 100.r,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 18.h),
                      width: double.maxFinite,
                      child: Text(
                        T.wildPhoto.tr,
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
                        T.wildPhotoContent.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF595959),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: 48.h,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFD9EF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                T.later.tr,
                                style: TextStyle(
                                  color: Color(0xFFFF0092),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(width: 12.w, color: Colors.transparent),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: 48.h,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFF0092),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                T.addPhoto.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
