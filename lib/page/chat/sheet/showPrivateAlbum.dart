import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';

void showPrivateAlbum({required Function onConfirm}) {
  Get.bottomSheet(
    PrivateAlbumWidget(onConfirm: onConfirm),
    isScrollControlled: true,
    isDismissible: true,
    settings: RouteSettings(name: AppRoutes.privateAlbumSheet),
  );
}

class PrivateAlbumWidget extends StatelessWidget {
  final Function onConfirm;
  const PrivateAlbumWidget({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Container(
          width: double.maxFinite,
          constraints: BoxConstraints(minHeight: 500.h),
          decoration: BoxDecoration(
            color: Color(0xFFF1EEFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              PositionedDirectional(
                top: 20,
                end: 15.w,
                child: Image.asset(
                  Assets.decorationAlbumBg1,
                  width: 41,
                  height: 42,
                ),
              ),

              PositionedDirectional(
                top: 60,
                start: 15.w,
                child: Image.asset(
                  Assets.decorationAlbumBg3,
                  width: 41,
                  height: 42,
                ),
              ),

              PositionedDirectional(
                top: 300.h,
                end: 5.w,
                child: Image.asset(
                  Assets.decorationAlbumBg2,
                  width: 41,
                  height: 42,
                ),
              ),

              Column(
                children: [
                  Container(
                    width: 36.w,
                    height: 5.h,
                    margin: EdgeInsets.only(top: 10.h),
                    decoration: ShapeDecoration(
                      color: Colors.black.withValues(alpha: 0.30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  Divider(height: 32.h, color: Colors.transparent),

                  Container(
                    margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                    width: double.maxFinite,
                    child: Text(
                      T.privateAlbum.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                    width: double.maxFinite,
                    child: Text(
                      T.privateAlbumTip.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.50),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),

                  Divider(height: 24.h, color: Colors.transparent),

                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.privateAlbumTitle1.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.privateAlbumContent1.tr,
                            style: TextStyle(
                              color: const Color(0xFFBFBFBF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 16.h, color: Colors.transparent),

                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.privateAlbumTitle2.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.privateAlbumContent2.tr,
                            style: TextStyle(
                              color: const Color(0xFFBFBFBF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 16.h, color: Colors.transparent),

                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.privateAlbumTitle3.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            T.privateAlbumContent3.tr,
                            style: TextStyle(
                              color: const Color(0xFFBFBFBF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 24.h, color: Colors.transparent),

                  GestureDetector(
                    onTap: () {
                      Get.back();
                      onConfirm.call();
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 48.h,
                      alignment: Alignment.center,
                      margin: EdgeInsetsDirectional.only(
                        start: 16.w,
                        end: 16.w,
                      ),
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
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Divider(height: 40.h, color: Colors.transparent),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
