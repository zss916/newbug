import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/sheet/pay/pay_list_widget.dart';

// showPurchaseFailedSheet(onContinue: () {}, onLoginNow: () {});
//showPayFailedSheet();
//showPaySuccessSheet();

/// 显示支付弹窗
void showPaySheet({required int index}) {
  Get.bottomSheet(
    PayWidget(index: index),
    isScrollControlled: true,
    settings: RouteSettings(name: AppRoutes.paySheet),
  );
}

class PayWidget extends StatelessWidget {
  final int index;
  const PayWidget({super.key, required this.index});

  static const List<String> imgs = [
    Assets.imgPrivateVideos,
    Assets.imgPrivatePhotos,
    Assets.imgFlashChat,
  ];

  static List<String> get titles => [
    T.privateVideos.tr,
    T.privatePhotos.tr,
    T.flashChat.tr,
  ];

  static List<String> get contents => [
    T.privateVideosContent.tr,
    T.privatePhotosContent.tr,
    T.flashChatContent.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1EEFF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              ),
              padding: EdgeInsets.all(16.w),
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    margin: EdgeInsetsDirectional.only(top: 12.h, start: 4.w),
                    child: Image.asset(imgs[index], width: 48, height: 48),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    width: double.maxFinite,
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 0.96,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    width: double.maxFinite,
                    child: Text(
                      contents[index],
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.40),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (index == 1)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF7D60FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'You have X views remaining. To unlock this content, you need Y views. Please purchase Z more views.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    width: double.maxFinite,
                    height: 170.h + 16.h,
                    child: PayListWidget(),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 48,
                    margin: EdgeInsets.only(top: 20.h),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFF0092),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Get 3x more',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14.h, bottom: 15.h),
                    width: double.maxFinite,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'For full details, please refer to our ',
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 13,
              end: 13,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    Assets.imgClosePage,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
