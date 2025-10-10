import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class SubscribeTip extends StatelessWidget {
  const SubscribeTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 12.h),
      width: double.maxFinite,
      child: Opacity(
        opacity: 0.80,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: T.subscribeTip.tr,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.70),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  height: 1.18,
                  letterSpacing: -0.30,
                ),
              ),
              TextSpan(
                text: T.privacyPolicy.tr,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.70),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  height: 1.18,
                  letterSpacing: -0.30,
                ),
              ),
              TextSpan(
                text: ' & ',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.70),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  height: 1.18,
                  letterSpacing: -0.30,
                ),
              ),
              TextSpan(
                text: T.termsTitle.tr,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.70),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  height: 1.18,
                  letterSpacing: -0.30,
                ),
              ),
              TextSpan(
                text: '.',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.70),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  height: 1.18,
                  letterSpacing: -0.30,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
