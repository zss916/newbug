import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/custom_annotation.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
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

enum PrivatePackageStatus { private, loading, countdown, destroyed }

///私有打包消息（照片/视频）
class PackageMessageWidget extends StatefulWidget {
  final LocalWrapperMsg msgItem;

  const PackageMessageWidget({super.key, required this.msgItem});

  @override
  State<PackageMessageWidget> createState() => _PackageMessageWidgetState();
}

class _PackageMessageWidgetState extends State<PackageMessageWidget> {
  bool isLoading = false;

  PrivatePackageStatus status = PrivatePackageStatus.private;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MessageWrapperWidget(
      isCenter: (widget.msgItem.rCIMIWMessage as PrivatePackageMessage)
          .isDestroyedStatus(),
      isLocal: widget.msgItem.isSender,
      extraContent: '',
      child: _buildPrivatePackageWidget(
        widget.msgItem,
        widget.msgItem.isSender,
      ),
    );
  }

  ///私有打包消息
  Widget _buildPrivatePackageWidget(LocalWrapperMsg msgItem, bool isLocal) {
    PrivatePackageMessage privatePkgMsg =
        msgItem.rCIMIWMessage as PrivatePackageMessage;
    PackageMediaModel? media = privatePkgMsg.data;
    List<PackageMediaItem> data = media?.list ?? [];
    Map expansion = privatePkgMsg.expansion ?? {};
    bool isUnlockStatus = privatePkgMsg.isUnlockStatus();
    return privatePkgMsg.isDestroyedStatus()
        ? buildFireStatusWidget()
        : InkWell(
            onTap: () {
              if (isLocal) {
                toPreview(privatePkgMsg);
              } else {
                handUncock(privatePkgMsg);
              }
            },
            child: _buildCustomCardStack(
              expansion: expansion,
              isVideo: (media?.isVideo ?? false),
              isLocal: isLocal,
              data: data,
              isUnlockStatus: isUnlockStatus,
            ),
          );
  }

  Widget _buildCustomCardStack({
    required bool isVideo,
    required bool isLocal,
    required Map expansion,
    required List<PackageMediaItem> data,
    required bool isUnlockStatus,
  }) => Container(
    margin: EdgeInsetsDirectional.only(bottom: 8.h),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (data.length > 2)
          Transform.scale(
            scale: 0.85,
            child: Transform.rotate(
              angle: isLocal ? -0.2 : 0.2,
              child: Transform.translate(
                offset: Offset(isLocal ? -50 : 50, 8),
                child: buildSingleCard(
                  isUnlockStatus: isUnlockStatus,
                  expansion: expansion,
                  len: data.length,
                  index: 2,
                  isVideo: isVideo,
                  isLocal: isLocal,
                  item: data[2],
                ),
              ),
            ),
          ),

        if (data.length > 1)
          Transform.scale(
            scale: 0.95,
            child: Transform.rotate(
              angle: isLocal ? -0.125 : 0.125,
              child: Transform.translate(
                offset: Offset(isLocal ? -25 : 25, 4),
                child: buildSingleCard(
                  isUnlockStatus: isUnlockStatus,
                  expansion: expansion,
                  index: 1,
                  len: data.length,
                  isVideo: isVideo,
                  isLocal: isLocal,
                  item: data[1],
                ),
              ),
            ),
          ),

        if (data.isNotEmpty)
          Transform.translate(
            offset: Offset(0, 0),
            child: buildSingleCard(
              isUnlockStatus: isUnlockStatus,
              expansion: expansion,
              index: 0,
              len: data.length,
              isVideo: isVideo,
              isLocal: isLocal,
              item: data[0],
            ),
          ),
      ],
    ),
  );

  Widget buildSingleCard({
    required Map expansion,
    required PackageMediaItem item,
    required bool isVideo,
    required bool isLocal,
    required int len,
    required bool isUnlockStatus,
    int? index,
  }) {
    return isVideo
        ? CommonThumbnailWidget(
            videoPath: item.url,
            builder: (String? thumbnailPath) {
              item.thumb_url = thumbnailPath;
              return _buildCustomItem(
                isUnlockStatus: isUnlockStatus,
                expansion: expansion,
                item: item,
                isLocal: isLocal,
                isVideo: isVideo,
                len: len,
                index: index,
                imageProvider: thumbnailPath == null
                    ? null
                    : ExtendedFileImageProvider(File(thumbnailPath)),
              );
            },
          )
        : _buildCustomItem(
            isUnlockStatus: isUnlockStatus,
            expansion: expansion,
            item: item,
            isLocal: isLocal,
            isVideo: isVideo,
            len: len,
            index: index,
            imageProvider: CachedNetworkImageProvider(item.url),
          );
  }

  Widget _buildCustomItem({
    required Map expansion,
    required PackageMediaItem item,
    required bool isVideo,
    required bool isLocal,
    required int len,
    required bool isUnlockStatus,
    int? index,
    ImageProvider? imageProvider,
  }) {
    return isUnlockStatus
        ? Container(
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
            child: index == 0
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      if ((status == PrivatePackageStatus.private ||
                          status == PrivatePackageStatus.loading))
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                              bottomRight: isLocal
                                  ? Radius.zero
                                  : Radius.circular(12.r),
                              topLeft: isLocal
                                  ? Radius.circular(12.r)
                                  : Radius.zero,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),

                      if ((status == PrivatePackageStatus.private ||
                          status == PrivatePackageStatus.loading))
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.imgLock,
                              width: 55.r,
                              height: 55.r,
                            ),
                            Text(
                              "${isVideo ? T.privateVideo.tr : T.privatePhoto.tr} ${len == 0 ? "" : len}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(height: 10.h, color: Colors.transparent),
                            if (isLoading &&
                                status == PrivatePackageStatus.loading)
                              LoadingWidget()
                            else
                              SizedBox(width: 22.r, height: 22.r),
                          ],
                        ),
                      if (status == PrivatePackageStatus.private ||
                          status == PrivatePackageStatus.loading)
                        PositionedDirectional(
                          bottom: 8.r,
                          end: 8.r,
                          start: 8.r,
                          child: Wrap(
                            spacing: 4.w,
                            runSpacing: 4.w,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
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
                          ),
                        ),

                      if (status == PrivatePackageStatus.countdown)
                        PositionedDirectional(
                          top: 8.r,
                          end: 8.r,
                          start: 8.r,
                          child: Wrap(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Text(
                                  'Unlocked:${len}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (status == PrivatePackageStatus.countdown)
                        PositionedDirectional(
                          bottom: 8.r,
                          end: 8.r,
                          child: CountDownWidget(
                            totalDuration: handCountDown(expansion),
                            onFinished: () {
                              setState(() {
                                status = PrivatePackageStatus.destroyed;
                              });
                            },
                          ),
                        ),

                      if (isVideo &&
                          (status == PrivatePackageStatus.private ||
                              status == PrivatePackageStatus.loading))
                        PositionedDirectional(
                          top: 8,
                          start: 8,
                          child: Image.asset(
                            Assets.imgIcVideo,
                            width: 28.w,
                            height: 20.h,
                          ),
                        ),

                      if (isVideo)
                        Center(
                          child: Image.asset(
                            Assets.imgNotificationPlay,
                            width: 50,
                            height: 50,
                          ),
                        ),

                      if (isVideo && status == PrivatePackageStatus.countdown)
                        Center(
                          child: Image.asset(
                            Assets.imgNotificationPlay,
                            width: 50,
                            height: 50,
                          ),
                        ),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      if ((status == PrivatePackageStatus.private ||
                          status == PrivatePackageStatus.loading))
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                              bottomRight: isLocal
                                  ? Radius.zero
                                  : Radius.circular(12.r),
                              topLeft: isLocal
                                  ? Radius.circular(12.r)
                                  : Radius.zero,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          )
        : Container(
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
            child: index == 0
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      if (false)
                        PositionedDirectional(
                          bottom: 8.r,
                          end: 8.r,
                          start: 8.r,
                          child: Wrap(
                            spacing: 4.w,
                            runSpacing: 4.w,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x19FF0092),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFFF0092),
                                    ),
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
                          ),
                        ),

                      PositionedDirectional(
                        top: 8.r,
                        end: 8.r,
                        start: 8.r,
                        child: Wrap(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color(0x19FF0092),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: const Color(0xFFFF0092),
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                'Unlocked:${len}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      PositionedDirectional(
                        bottom: 8.r,
                        end: 8.r,
                        child: CountDownWidget(
                          totalDuration: handCountDown(expansion),
                          onFinished: () {
                            setState(() {
                              status = PrivatePackageStatus.destroyed;
                            });
                          },
                        ),
                      ),

                      if (isVideo)
                        Center(
                          child: Image.asset(
                            Assets.imgNotificationPlay,
                            width: 50,
                            height: 50,
                          ),
                        ),
                    ],
                  )
                : SizedBox.shrink(),
          );
  }

  /// Fire status
  Widget buildFireStatusWidget() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Color(0xFFF0EDFF),
    ),
    margin: EdgeInsets.only(top: 16.h),
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
  );

  Future<void> handUncock(PrivatePackageMessage privatePkgMsg) async {
    ///todo 非会员会有弹窗拦截
    if (status == PrivatePackageStatus.private) {
      setState(() {
        isLoading = true;
        status = PrivatePackageStatus.loading;
      });

      String toMsgId = privatePkgMsg.messageUId ?? "";
      String fromMsgId = privatePkgMsg.data?.original_msgid ?? "";
      String mediaId = privatePkgMsg.data?.media_ids.toString() ?? "";
      debugPrint(
        "toMsgId => $toMsgId,fromMsgId => $fromMsgId, mediaId=>$mediaId",
      );
      PrivateMsgStatusEntity? data = await safeFind<ChatLogic>()?.toUnLock(
        toMsgid: toMsgId,
        fromMsgid: fromMsgId,
        mediaId: mediaId,
      );
      if (data != null) {
        if (data.setExt == 1) {
          setState(() {
            isLoading = false;
            status = PrivatePackageStatus.countdown;
          });
        }
      } else {
        CustomToast.showText("Unlock Failed");
      }
    } else if (status == PrivatePackageStatus.loading) {
      debugPrint("loading");
    } else if (status == PrivatePackageStatus.countdown) {
      debugPrint("countdown");
      toPreview(privatePkgMsg);
    } else if (status == PrivatePackageStatus.destroyed) {
      debugPrint("destroyed");
    }
  }

  void toPreview(PrivatePackageMessage privatePkgMsg) {
    bool isVideo = privatePkgMsg.data?.isVideo ?? false;
    if (isVideo) {
      RouteManager.toPreviewView(
        viewId: PreviewViewType.multipleVideo.index,
        data: {"message": privatePkgMsg},
      );
    } else {
      RouteManager.toPreviewView(
        viewId: PreviewViewType.multiplePhoto.index,
        data: {"message": privatePkgMsg},
      );
    }
  }

  ///获取倒计时时间
  int handCountDown(Map expansion) {
    PrivacyExtraData extra = PrivacyExtraData.fromJson(expansion);
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
