import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///普通图片消息(自定义样式)
class ImageMessageWidget extends StatelessWidget {
  final LocalWrapperMsg msgItem;
  const ImageMessageWidget({super.key, required this.msgItem});

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      isLocal: true,
      child: buildCommonImageWidget(msgItem, true),
    );
  }

  ///公开图片
  Widget buildCommonImageWidget(LocalWrapperMsg msgItem, bool isLocal) {
    RCIMIWImageMessage imageMessage =
        msgItem.rCIMIWMessage as RCIMIWImageMessage;
    return InkWell(
      onTap: () {
        RouteManager.toPreviewView(
          viewId: PreviewViewType.singleImagePhoto.index,
          data: {"message": imageMessage},
        );
      },
      child: RepaintBoundary(child: _buildMsgImage(imageMessage, isLocal)),
    );
  }

  Widget _buildMsgImage(RCIMIWImageMessage imageMessage, bool isLocal) {
    if (imageMessage.remote != null) {
      return _buildCustomMsgWidget(
        isLocal,
        CachedNetworkImageProvider(imageMessage.remote ?? ""),
      );
    } else if (File(imageMessage.local ?? "").existsSync()) {
      return _buildCustomMsgWidget(
        isLocal,
        ExtendedFileImageProvider(File(imageMessage.local ?? "")),
      );
    } else if (imageMessage.thumbnailBase64String != null) {
      return _buildCustomMsgWidget(
        isLocal,
        ExtendedMemoryImageProvider(
          base64Decode(imageMessage.thumbnailBase64String ?? ""),
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
    );
  }
}
