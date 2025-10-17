import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';

void showChatMoreSheet() {
  Get.bottomSheet(
    ChatMoreWidget(),
    isDismissible: false,
    settings: RouteSettings(name: AppRoutes.chatMoreSheet),
  );
}

class ChatMoreWidget extends StatelessWidget {
  const ChatMoreWidget({super.key});

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
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: T.viewProfile.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
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
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: T.delete.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
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
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: T.report.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
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
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    T.block.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
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
