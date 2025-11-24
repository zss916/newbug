import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///普通视频消息(自定义样式)
class VideoMessageWidget extends StatelessWidget {
  final LocalWrapperMsg msgItem;
  const VideoMessageWidget({super.key, required this.msgItem});

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      isLocal: true,
      child: buildCommonVideoWidget(msgItem, true),
    );
  }

  ///普通视频
  Widget buildCommonVideoWidget(LocalWrapperMsg msgItem, bool isLocal) {
    RCIMIWSightMessage videoMessage =
        msgItem.rCIMIWMessage as RCIMIWSightMessage;
    return InkWell(
      onTap: () {
        RouteManager.toPreviewView(
          viewId: PreviewViewType.singleSightVideo.index,
          data: {"message": videoMessage},
        );
      },
      child: RepaintBoundary(child: _buildMsgVideo(videoMessage, isLocal)),
    );
  }

  ///视频消息
  Widget _buildMsgVideo(RCIMIWSightMessage message, bool isLocal) {
    if (message.thumbnailBase64String != null) {
      return _buildCustomMsgWidget(
        isLocal,
        ExtendedMemoryImageProvider(
          base64Decode(message.thumbnailBase64String ?? ""),
        ),
      );
    } else {
      return _buildCustomMsgWidget(isLocal, null);
    }
  }

  Widget _buildCustomMsgWidget(bool isLocal, ImageProvider? imageProvider) {
    return Container(
      width: 179.w,
      height: 232.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
        image: imageProvider == null
            ? null
            : DecorationImage(fit: BoxFit.cover, image: imageProvider),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.r),
          bottomLeft: Radius.circular(12.r),
          bottomRight: isLocal ? Radius.zero : Radius.circular(12.r),
          topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
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
  }
}
