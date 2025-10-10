import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';

void showPurchaseFailedSheet({
  required Function onContinue,
  required Function onLoginNow,
}) {
  Get.bottomSheet(
    PurchaseFailed(onContinue: onContinue, onLoginNow: onLoginNow),
    isScrollControlled: true,
    settings: RouteSettings(name: AppRoutes.purchaseFailedSheet),
  );
}

class PurchaseFailed extends StatelessWidget {
  final Function onContinue;
  final Function onLoginNow;
  const PurchaseFailed({
    super.key,
    required this.onLoginNow,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF1EEFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          padding: EdgeInsets.all(16.r),
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                width: 36,
                height: 5,
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0.30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h),
                width: double.maxFinite,
                child: Text(
                  T.purchaseFailed.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF262626),
                    fontSize: 32,
                    fontFamily: AppFonts.font1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h, left: 10.w, right: 10.w),
                width: double.maxFinite,
                child: Text(
                  T.purchaseFailedContent.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF595959),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 24.h),
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFDFDFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          Text(
                            T.changeAccount.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              T.loginNowTip.trArgs(["XXXX(Account ID)"]),
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        onLoginNow.call();
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFF0092),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          T.loginNow.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 16.h, bottom: 40.h),
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFDFDFD) /* Base-color-Gray-01 */,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          Text(
                            T.changeStoreID.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              T.changeStoreIDContent.tr,
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        onContinue.call();
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFF0092),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          T.continueKey.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
