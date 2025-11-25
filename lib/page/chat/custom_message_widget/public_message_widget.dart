import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/common_thumbnail_widget.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';

class PublicMessageWidget extends StatelessWidget {
  final LocalWrapperMsg msgItem;

  const PublicMessageWidget({super.key, required this.msgItem});

  @override
  Widget build(BuildContext context) {
    PublicMessage publicMessage = msgItem.rCIMIWMessage as PublicMessage;
    MediaListItem? media = publicMessage.data;
    debugPrint("media ===> ${media?.toJson()}");
    return MessageWrapperWidget(
      isLocal: msgItem.isSender,
      child: InkWell(
        onTap: () {
          ///判断是否是video
          if (media?.isVideo ?? false) {
            RouteManager.toPreviewView(
              viewId: PreviewViewType.singlePublicVideo.index,
              data: {"message": publicMessage},
            );
          } else {
            RouteManager.toPreviewView(
              viewId: PreviewViewType.singlePublicPhoto.index,
              data: {"message": publicMessage},
            );
          }
        },
        child: (media?.isVideo == true)
            ? CommonThumbnailWidget(
                videoPath: media?.url ?? "",
                builder: (String? thumbnailPath) {
                  media?.thumbUrl = thumbnailPath;
                  return Container(
                    width: 179.w,
                    height: 232.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: msgItem.isSender
                          ? Color(0xFFCDD2FF)
                          : Color(0xFFF6CDFF),
                      image: (thumbnailPath == null)
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: ExtendedFileImageProvider(
                                File(thumbnailPath),
                              ),
                            ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: msgItem.isSender
                            ? Radius.zero
                            : Radius.circular(12.r),
                        topLeft: msgItem.isSender
                            ? Radius.circular(12.r)
                            : Radius.zero,
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
                  color: msgItem.isSender
                      ? Color(0xFFCDD2FF)
                      : Color(0xFFF6CDFF),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(media?.url ?? ""),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: msgItem.isSender
                        ? Radius.zero
                        : Radius.circular(12.r),
                    topLeft: msgItem.isSender
                        ? Radius.circular(12.r)
                        : Radius.zero,
                  ),
                ),
              ),
      ),
    );
  }
}
