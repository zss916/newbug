import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class SubscribeButton extends StatelessWidget {
  final Function onTap;
  const SubscribeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(
          horizontal: 10.w,
          vertical: 12.h,
        ),
        width: double.maxFinite,
        height: 48,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFFFF0092),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
        child: Text(
          T.subscribe.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.31,
            letterSpacing: -0.32,
          ),
        ),
      ),
    );
  }
}
