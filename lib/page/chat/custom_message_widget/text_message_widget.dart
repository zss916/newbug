import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';

class TextMessageWidget extends StatelessWidget {
  final bool isLocal;
  final String message;

  const TextMessageWidget({
    super.key,
    required this.message,
    required this.isLocal,
  });

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      isLocal: isLocal,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: isLocal ? Radius.zero : Radius.circular(12.r),
            topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isLocal ? Color(0xFF7D60FF) : Color(0xFFFF0092),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
