import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/generated/assets.dart';

class GuideView extends StatelessWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        EventService.to.post(HomeMenuEvent(isShow: true));
        EventService.to.post(OpenMenuEvent(isOpen: true));
      },
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(color: Color(0x99000000)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                top:
                    (Get.statusBarHeight +
                    ((Get.width - 28.w - 4) * 483 / 362) +
                    18.h -
                    5),
              ),
              child: Image.asset(Assets.imgTouch, width: 48, height: 48),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 10.h, bottom: 0.h),
              width: double.maxFinite,
              child: Text(
                T.interestedTip.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 10, end: 10),
              width: double.maxFinite,
              child: Text(
                T.touchTip.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.80),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
