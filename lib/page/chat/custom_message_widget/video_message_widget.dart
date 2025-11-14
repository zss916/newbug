import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///私密媒体消息状态(photo/video)
enum PrivateMediaStatus { private, loading, countdown, destroyed }

class VideoMessageWidget extends StatefulWidget {
  final bool isLocal;
  final Function? onTap;
  final LocalWrapperMsg msgItem;

  const VideoMessageWidget({
    super.key,
    required this.msgItem,
    required this.isLocal,
    this.onTap,
  });

  @override
  State<VideoMessageWidget> createState() => _MediaMessageWidgetState();
}

class _MediaMessageWidgetState extends State<VideoMessageWidget> {
  bool isLoading = false;

  PrivateMediaStatus status = PrivateMediaStatus.private;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      isLocal: widget.isLocal,
      child: buildPublicVideoWidget(widget.msgItem),
    );
  }

  ///公开视频
  Widget buildPublicVideoWidget(LocalWrapperMsg msgItem) {
    RCIMIWSightMessage videoMessage =
        msgItem.rCIMIWMessage as RCIMIWSightMessage;
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: _buildMsgVideo(videoMessage),
    );
  }

  ///视频消息
  Widget _buildMsgVideo(RCIMIWSightMessage message) {
    if (message.thumbnailBase64String != null) {
      return Container(
        width: 179.w,
        height: 232.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedMemoryImageProvider(
              base64Decode(message.thumbnailBase64String ?? ""),
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: widget.isLocal ? Radius.zero : Radius.circular(12.r),
            topLeft: widget.isLocal ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Center(
              child: Image.asset(
                Assets.imgNotificationPlay,
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
