import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class HomeMore extends StatelessWidget {
  final Function() onReport;
  final Function() onBlock;
  const HomeMore({super.key, required this.onReport, required this.onBlock});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 16.w),
      child: PopupMenuButton(
        offset: Offset(-0.w, 40.h),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFE5E5E5), width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        borderRadius: BorderRadius.circular(5),
        padding: EdgeInsetsDirectional.zero,
        menuPadding: EdgeInsetsDirectional.zero,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Image.asset(Assets.imgMore, width: 32, height: 32),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Container(
                alignment: AlignmentDirectional.center,
                color: Colors.transparent,
                padding: EdgeInsetsDirectional.symmetric(vertical: 8),
                child: Text(
                  T.report.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF262626),
                  ),
                ),
              ),
              onTap: () {
                onReport.call();
              },
            ),
            PopupMenuItem(
              child: Container(
                alignment: AlignmentDirectional.center,
                color: Colors.transparent,
                padding: EdgeInsetsDirectional.symmetric(vertical: 8),
                child: Text(
                  T.blocked.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF262626),
                  ),
                ),
              ),
              onTap: () {
                onBlock.call();
              },
            ),
          ];
        },
      ),
    );
  }
}
