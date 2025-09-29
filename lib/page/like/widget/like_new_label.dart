import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class LikeNewLabel extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const LikeNewLabel({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(minHeight: 20.h, minWidth: 40.w),
        alignment: AlignmentDirectional.center,
        margin: margin ?? EdgeInsetsDirectional.zero,
        padding: const EdgeInsets.symmetric(horizontal: 2.40, vertical: 1.60),
        decoration: ShapeDecoration(
          color: const Color(0xFFF5222D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          T.newKey.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
