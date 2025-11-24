import 'dart:io';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/custom_annotation.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/private_msg_status_entity.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/common_thumbnail_widget.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/loading_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:newbug/page/chat/index.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///私密媒体消息状态(photo/video)
enum PrivateMediaStatus { private, loading, countdown, destroyed }

class SinglePrivateMessageWidget extends StatefulWidget {
  final bool? isDestroyed;
  final LocalWrapperMsg msgItem;

  const SinglePrivateMessageWidget({
    super.key,
    required this.msgItem,
    this.isDestroyed,
  });

  @override
  State<SinglePrivateMessageWidget> createState() => _MediaMessageWidgetState();
}

class _MediaMessageWidgetState extends State<SinglePrivateMessageWidget> {
  bool isDestroyed = false;
  bool isLoading = false;

  PrivateMediaStatus status = PrivateMediaStatus.private;

  @override
  void initState() {
    super.initState();
    isDestroyed = widget.isDestroyed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      isCenter: (widget.msgItem.rCIMIWMessage as PrivateMessage)
          .isDestroyedStatus(),
      isLocal: widget.msgItem.isSender,
      child: _buildPrivateMediaWidget(widget.msgItem, widget.msgItem.isSender),
    );
  }

  /// 私密(单个消息视频或图片)
  Widget _buildPrivateMediaWidget(LocalWrapperMsg msgItem, bool isLocal) {
    PrivateMessage privateMessage = msgItem.rCIMIWMessage as PrivateMessage;
    MediaListItem? media = privateMessage.data;
    // debugPrint("media => ${privateMessage.toJson()}");
    debugPrint("media data=> ${media?.toJson()}");
    debugPrint("media expansion=> ${privateMessage.expansion}");

    return privateMessage.isDestroyedStatus()
        ? buildFireStatusWidget()
        : InkWell(
            onLongPress: () {
              ///todo 长按撤回
            },
            onTap: () {
              if (isLocal) {
                toPreview(privateMessage);
              } else {
                handUncock(msgItem);
              }
            },
            child: (media?.isVideo ?? false)
                ? CommonThumbnailWidget(
                    videoPath: media?.url ?? "",
                    builder: (String? thumbnailPath) {
                      media?.thumbUrl = thumbnailPath;
                      return _buildCustomPrivateWidget(
                        isLocal,
                        privateMessage,
                        thumbnailPath == null
                            ? null
                            : ExtendedFileImageProvider(File(thumbnailPath)),
                      );
                    },
                  )
                : _buildCustomPrivateWidget(
                    isLocal,
                    privateMessage,
                    ExtendedNetworkImageProvider(
                      privateMessage.data?.imageUrl ?? "",
                    ),
                  ),
          );
  }

  Widget _buildCustomPrivateWidget(
    bool isLocal,
    PrivateMessage privateMessage,
    ImageProvider? imageProvider,
  ) {
    MediaListItem? media = privateMessage.data;
    return Container(
      width: 179.w,
      height: 232.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
        image: (imageProvider == null)
            ? null
            : DecorationImage(fit: BoxFit.cover, image: imageProvider),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.r),
          bottomLeft: Radius.circular(12.r),
          bottomRight: isLocal ? Radius.zero : Radius.circular(12.r),
          topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
        ),
      ),
      child: privateMessage.isUnlockStatus()
          ? Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (status == PrivateMediaStatus.private ||
                    status == PrivateMediaStatus.loading)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: isLocal
                            ? Radius.zero
                            : Radius.circular(12.r),
                        topLeft: isLocal ? Radius.circular(12.r) : Radius.zero,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                if (status == PrivateMediaStatus.private ||
                    status == PrivateMediaStatus.loading)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imgLock, width: 55.r, height: 55.r),
                      Text(
                        (media?.isVideo ?? false)
                            ? T.privateVideo.tr
                            : T.privatePhoto.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(height: 10.h, color: Colors.transparent),
                      if (isLoading && status == PrivateMediaStatus.loading)
                        LoadingWidget()
                      else
                        SizedBox(width: 22.r, height: 22.r),
                    ],
                  ),
                if ((status == PrivateMediaStatus.private ||
                        status == PrivateMediaStatus.loading) &&
                    (!isLocal))
                  PositionedDirectional(
                    bottom: 8.r,
                    end: 8.r,
                    start: 8.r,
                    child: buildTags(),
                  ),
                if (status == PrivateMediaStatus.countdown)
                  PositionedDirectional(
                    bottom: 8.r,
                    end: 8.r,
                    child: CountDownWidget(
                      totalDuration: 60,
                      onFinished: () {
                        setState(() {
                          status = PrivateMediaStatus.destroyed;
                        });
                      },
                    ),
                  ),
              ],
            )
          : Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (media?.isVideo == true)
                  Center(
                    child: Image.asset(
                      Assets.imgNotificationPlay,
                      width: 50,
                      height: 50,
                    ),
                  ),
                PositionedDirectional(
                  bottom: 8.r,
                  end: 8.r,
                  child: CountDownWidget(
                    totalDuration: handCountDown(privateMessage),
                    onFinished: () {
                      setState(() {
                        status = PrivateMediaStatus.destroyed;
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildTags() {
    return Wrap(
      spacing: 4.w,
      runSpacing: 4.w,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: ShapeDecoration(
            color: const Color(0x19FF0092),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFFFF0092)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            '#Travel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.30,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: ShapeDecoration(
            color: const Color(0x19FF0092),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFFFF0092)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            '#Travel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.30,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: ShapeDecoration(
            color: const Color(0x19FF0092),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFFFF0092)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            '#Travel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.30,
            ),
          ),
        ),
      ],
    );
  }

  /// Fire status
  Widget buildFireStatusWidget() => UnconstrainedBox(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFFF0EDFF),
      ),
      margin: EdgeInsetsDirectional.only(top: 16.h, start: 14.w, end: 14.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.imgIcFire, width: 24, height: 24),
          Text(
            T.destroyedTip.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );

  ///解锁
  Future<void> handUncock(LocalWrapperMsg msgItem) async {
    ///todo 非会员会有弹窗拦截
    PrivateMessage privateMessage = msgItem.rCIMIWMessage as PrivateMessage;

    if (status == PrivateMediaStatus.private) {
      setState(() {
        isLoading = true;
        status = PrivateMediaStatus.loading;
      });

      String toMsgId = privateMessage.messageUId ?? "";
      String fromMsgId = privateMessage.data?.originalMsgid ?? "";
      String mediaId = privateMessage.data?.id.toString() ?? "";
      PrivateMsgStatusEntity? data = await safeFind<ChatLogic>()?.toUnLock(
        toMsgid: toMsgId,
        fromMsgid: fromMsgId,
        mediaId: mediaId,
      );
      //{del_time: 1763977997, set_ext: 1, status: 1}
      if (data != null) {
        if (data.setExt == 1) {
          setState(() {
            isLoading = false;
            status = PrivateMediaStatus.countdown;
          });
        }
      } else {
        CustomToast.showText("Unlock Failed");
      }
    } else if (status == PrivateMediaStatus.loading) {
      debugPrint("loading");
    } else if (status == PrivateMediaStatus.countdown) {
      debugPrint("countdown");
      toPreview(privateMessage);
    } else if (status == PrivateMediaStatus.destroyed) {
      debugPrint("destroyed");
    }
  }

  void toPreview(PrivateMessage privateMessage) {
    bool isLocal = privateMessage.direction == RCIMIWMessageDirection.send;
    bool isVideo = privateMessage.data?.isVideo ?? false;
    if (isVideo) {
      RouteManager.toPreviewView(
        viewId: PreviewViewType.singlePrivateVideo.index,
        data: {"message": privateMessage, "isReceiver": !isLocal},
      );
    } else {
      RouteManager.toPreviewView(
        viewId: PreviewViewType.singlePrivatePhoto.index,
        data: {"message": privateMessage, "isReceiver": !isLocal},
      );
    }
  }

  ///获取倒计时时间
  int handCountDown(PrivateMessage privateMessage) {
    PrivacyExtraData extra = PrivacyExtraData.fromJson(
      privateMessage.expansion ?? {},
    );
    if (extra.status == "1") {
      DateTime targetDateTime = DateTime.fromMillisecondsSinceEpoch(
        (int.parse(extra.del_time ?? "0")) * 1000,
      );
      final difference = targetDateTime.difference(DateTime.now());

      return difference.inSeconds;
    } else {
      return 0;
    }
  }
}
