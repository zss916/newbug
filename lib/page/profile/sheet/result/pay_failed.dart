import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';

void showPayFailedSheet() {
  Get.bottomSheet(
    PayFailed(),
    isScrollControlled: true,
    settings: RouteSettings(name: AppRoutes.payFailedSheet),
  );
}

class PayFailed extends StatelessWidget {
  const PayFailed({super.key});

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
                margin: EdgeInsetsDirectional.only(top: 25.h, bottom: 18.h),
                child: Image.asset(
                  Assets.imgPayFailed,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  T.payFailed.tr,
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
                  T.payFailedContent.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF595959),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                  width: double.maxFinite,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF0092),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    T.tryAgin.tr,
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
        ),
      ],
    );
  }
}
