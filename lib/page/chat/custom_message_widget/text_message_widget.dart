import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class TextMessageWidget extends StatelessWidget {
  final LocalWrapperMsg msgItem;

  const TextMessageWidget({super.key, required this.msgItem});

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      showTime: msgItem.showTime,
      isLocal: msgItem.isSender,
      time: (msgItem.rCIMIWMessage as RCIMIWTextMessage).sentTime,
      msgStatus: msgItem.msgStatus,
      extraContent: "",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: msgItem.isSender ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: msgItem.isSender ? Radius.zero : Radius.circular(12.r),
            topLeft: msgItem.isSender ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
        child: Text(
          (msgItem.rCIMIWMessage as RCIMIWTextMessage).text ?? "",
          style: TextStyle(
            color: msgItem.isSender ? Color(0xFF7D60FF) : Color(0xFFFF0092),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
