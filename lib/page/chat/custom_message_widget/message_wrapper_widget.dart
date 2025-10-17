import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

enum MsgStatus { successful, loading, error }

class MessageWrapperWidget extends StatelessWidget {
  final Widget child;
  final bool isLocal;
  final MsgStatus? msgStatus;
  const MessageWrapperWidget({
    super.key,
    required this.isLocal,
    required this.child,
    this.msgStatus,
  });

  //todo
  // static String extraContent = "Reached the limit, continue to send";
  String get extraContent => T.reachedTheLimit.tr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsetsDirectional.only(top: 16.h, start: 14.w, end: 14.w),
      padding: EdgeInsetsDirectional.only(
        start: isLocal ? 36.w : 0,
        end: isLocal ? 0 : 36.w,
      ),
      child: Column(
        crossAxisAlignment: isLocal
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isLocal
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLocal)
                Container(
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (msgStatus == MsgStatus.error)
                        Image.asset(Assets.imgChatError, width: 24, height: 24),
                      if (msgStatus == MsgStatus.loading)
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Color(0xFF7D60FF),
                            strokeWidth: 2,
                          ),
                        ),
                      if (msgStatus == MsgStatus.successful ||
                          msgStatus != null)
                        SizedBox(width: 24, height: 24),
                    ],
                  ),
                ),
              Flexible(fit: FlexFit.loose, child: child),
              if (!isLocal)
                Container(
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                  child: SizedBox(width: 24, height: 24),
                ),
            ],
          ),

          if (isLocal && extraContent.isNotEmpty)
            Container(
              alignment: AlignmentDirectional.centerEnd,
              margin: EdgeInsetsDirectional.only(top: 4.h),
              child: Text(
                extraContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF8C8C8C),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsetsDirectional.only(top: 18.h, bottom: 8.h),
            width: double.maxFinite,
            child: Text(
              "6 February 2024, 9:35",
              textAlign: TextAlign.center,
              style: TextStyle(color: const Color(0xFF8C8C8C), fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
