import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 20.h,
        bottom: 20.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFF6CDFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
        ),
      ),
      child: Text(
        'I’m all about genuine chats—whether it’s debating the best pizza topping (pineapple belongs, fight me) or geeking out over new music (recently obsessed with that indie folk band from Portland). Always down for trying new things,',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color(0xFFFF0092),
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
