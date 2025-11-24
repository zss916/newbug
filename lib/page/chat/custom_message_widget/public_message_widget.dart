import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/common_thumbnail_widget.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';

class PublicMessageWidget extends StatelessWidget {
  final bool isLocal;
  final Function? onTap;
  final LocalWrapperMsg msgItem;

  const PublicMessageWidget({
    super.key,
    required this.msgItem,
    required this.isLocal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    PublicMessage publicMessage = msgItem.rCIMIWMessage as PublicMessage;
    MediaListItem? media = publicMessage.data;
    return MessageWrapperWidget(
      isLocal: isLocal,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          width: 179.w,
          height: 232.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(publicMessage.data?.url ?? ""),
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
              bottomRight: isLocal ? Radius.zero : Radius.circular(12.r),
              topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (media?.isVideo == true)
                PositionedDirectional(
                  top: 8,
                  start: 8,
                  child: Image.asset(
                    Assets.imgIcVideo,
                    width: 28.w,
                    height: 20.h,
                  ),
                ),
              if (media?.isVideo == true)
                Center(
                  child: Image.asset(
                    Assets.imgNotificationPlay,
                    width: 50,
                    height: 50,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget buildOldWidget(MediaListItem? media) => (media?.isVideo == true)
      ? CommonThumbnailWidget(
          videoPath: media?.url ?? "",
          builder: (String? thumbnailPath) {
            media?.thumbUrl = thumbnailPath;
            return Container(
              width: 179.w,
              height: 232.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
                image: (thumbnailPath == null)
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: ExtendedFileImageProvider(File(thumbnailPath)),
                      ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: isLocal ? Radius.zero : Radius.circular(12.r),
                  topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PositionedDirectional(
                    top: 8,
                    start: 8,
                    child: Image.asset(
                      Assets.imgIcVideo,
                      width: 28.w,
                      height: 20.h,
                    ),
                  ),
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
          },
        )
      : Container(
          width: 179.w,
          height: 232.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(media?.url ?? ""),
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
              bottomRight: isLocal ? Radius.zero : Radius.circular(12.r),
              topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
            ),
          ),
        );
}
