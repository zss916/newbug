import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/widget/app_blur_widget.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/message/index/widget/red_point.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///会话item UI
class ConversationMsgWidget extends StatelessWidget {
  final RCIMIWConversation value;
  const ConversationMsgWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    //item.lastMessage?.messageType == RCIMIWMessageType.text
    RCIMIWMessageType? type = value.lastMessage?.messageType;
    return switch (type) {
      _ when type == RCIMIWMessageType.text => buildTextMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),
      _ => Text("type: ${type?.name}"),
    };
  }

  ///文本消息
  Widget buildTextMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    RCIMIWTextMessage msg = lastMessage as RCIMIWTextMessage;
    return Row(
      children: [
        Expanded(
          child: Text(
            msg.text ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if ((unreadCount ?? 0) > 0) RedPoint(count: unreadCount ?? 0),
        SizedBox.shrink(),
      ],
    );
  }

  Widget buildImageMsg({int? unreadCount}) => Row(
    children: [
      if (true)
        Container(
          margin: EdgeInsetsDirectional.only(end: 6.w),
          child: AppBlurWidget(
            isBlur: true,
            sigma: 1.5,
            borderRadius: BorderRadius.circular(6),
            foreground: Image.asset(Assets.imgLock, width: 14.w, height: 14.w),
            child: Container(
              width: 24,
              height: 20,
              clipBehavior: Clip.hardEdge,
              foregroundDecoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(6),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
                  ),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      Expanded(
        child: Text(
          '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: const Color(0xFF494949),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      if ((unreadCount ?? 0) > 0) RedPoint(count: unreadCount ?? 0),
      SizedBox.shrink(),
    ],
  );
}
