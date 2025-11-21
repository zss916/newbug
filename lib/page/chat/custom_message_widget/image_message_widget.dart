import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///私密媒体消息状态(photo/video)
enum PrivateMediaStatus { private, loading, countdown, destroyed }

class ImageMessageWidget extends StatefulWidget {
  final bool isLocal;
  final Function? onTap;
  final LocalWrapperMsg msgItem;

  const ImageMessageWidget({
    super.key,
    required this.msgItem,
    required this.isLocal,
    this.onTap,
  });

  @override
  State<ImageMessageWidget> createState() => _MediaMessageWidgetState();
}

class _MediaMessageWidgetState extends State<ImageMessageWidget> {
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
      child: buildPublicImageWidget(widget.msgItem),
    );
  }

  ///公开图片
  Widget buildPublicImageWidget(LocalWrapperMsg msgItem) {
    RCIMIWImageMessage imageMessage =
        msgItem.rCIMIWMessage as RCIMIWImageMessage;
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: _buildMsgImage(imageMessage),
    );
  }

  Widget _buildMsgImage(RCIMIWImageMessage imageMessage) {
    if (imageMessage.remote != null) {
      return Container(
        width: 179.w,
        height: 232.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(imageMessage.remote ?? ""),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: widget.isLocal ? Radius.zero : Radius.circular(12.r),
            topLeft: widget.isLocal ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
      );
    } else if (File(imageMessage.local ?? "").existsSync()) {
      return Container(
        width: 179.w,
        height: 232.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedFileImageProvider(File(imageMessage.local ?? "")),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: widget.isLocal ? Radius.zero : Radius.circular(12.r),
            topLeft: widget.isLocal ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
      );
    } else if (imageMessage.thumbnailBase64String != null) {
      return Container(
        width: 179.w,
        height: 232.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedMemoryImageProvider(
              base64Decode(imageMessage.thumbnailBase64String ?? ""),
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: widget.isLocal ? Radius.zero : Radius.circular(12.r),
            topLeft: widget.isLocal ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
