import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/loading_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

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
    PrivatePackageMessage privatePackageMessage =
        msgItem.rCIMIWMessage as PrivatePackageMessage;
    PackageMediaModel? media = privatePackageMessage.data;
    List<PackageMediaItem> data = media?.list ?? [];
    return privatePackageMessage.isDestroyedStatus()
        ? buildFireStatusWidget()
        : InkWell(
            onTap: () {
              if (isLocal) {
                toPreview(privatePackageMessage);
              } else {
                handUncock(msgItem);
              }
            },
            child: _buildCustomUI(
              isVideo: (media?.isVideo ?? false),
              isLocal: isLocal,
              data: data,
            ),
          );
  }

  Widget _buildCustomUI({
    required bool isVideo,
    required bool isLocal,
    required List<PackageMediaItem> data,
  }) => isLocal
      ? buildCardStackLocal(isVideo: isVideo, data: data, isLocal: isLocal)
      : buildCardStack(isVideo: isVideo, data: data, isLocal: isLocal);

  ///收到方
  Widget buildCardStack({
    required bool isVideo,
    required bool isLocal,
    required List<PackageMediaItem> data,
  }) => Container(
    margin: EdgeInsetsDirectional.only(bottom: 8.h),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (data.length > 2)
          Transform.scale(
            scale: 0.85,
            child: Transform.rotate(
              angle: 0.2,
              child: Transform.translate(
                offset: Offset(50, 8),
                child: buildSingleCard(
                  index: 2,
                  len: data.length,
                  isVideo: isVideo,
                  isLocal: isLocal,
                  imageUrl: data[2].url,
                ),
              ),
            ),
          ),

        if (data.length > 1)
          Transform.scale(
            scale: 0.95,
            child: Transform.rotate(
              angle: 0.125,
              child: Transform.translate(
                offset: Offset(25, 4),
                child: buildSingleCard(
                  index: 1,
                  len: data.length,
                  isVideo: isVideo,
                  isLocal: isLocal,
                  imageUrl: data[1].url,
                ),
              ),
            ),
          ),

        if (data.isNotEmpty)
          Transform.translate(
            offset: Offset(0, 0),
            child: buildSingleCard(
              index: 0,
              len: data.length,
              isVideo: isVideo,
              isLocal: isLocal,
              imageUrl: data[0].url,
            ),
          ),
      ],
    ),
  );

  ///发送方
  Widget buildCardStackLocal({
    required bool isVideo,
    required bool isLocal,
    required List<PackageMediaItem> data,
  }) => Container(
    margin: EdgeInsetsDirectional.only(bottom: 8.h),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (data.length > 2)
          Transform.scale(
            scale: 0.85,
            child: Transform.rotate(
              angle: -0.2,
              child: Transform.translate(
                offset: Offset(-50, 8),
                child: buildSingleCard(
                  len: data.length,
                  index: 2,
                  isVideo: isVideo,
                  isLocal: isLocal,
                  imageUrl: data[2].url,
                ),
              ),
            ),
          ),

        if (data.length > 1)
          Transform.scale(
            scale: 0.95,
            child: Transform.rotate(
              angle: -0.125,
              child: Transform.translate(
                offset: Offset(-25, 4),
                child: buildSingleCard(
                  index: 1,
                  len: data.length,
                  isVideo: isVideo,
                  isLocal: isLocal,
                  imageUrl: data[1].url,
                ),
              ),
            ),
          ),

        if (data.isNotEmpty)
          Transform.translate(
            offset: Offset(0, 0),
            child: buildSingleCard(
              index: 0,
              len: data.length,
              isVideo: isVideo,
              isLocal: isLocal,
              imageUrl: data[0].url,
            ),
          ),
      ],
    ),
  );

  Widget buildSingleCard({
    required String imageUrl,
    required bool isVideo,
    required bool isLocal,
    required int len,
    int? index,
  }) {
    return Container(
      width: 179.w,
      height: 232.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(imageUrl),
        ),
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

                if ((status == PrivatePackageStatus.private ||
                    status == PrivatePackageStatus.loading))
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imgLock, width: 55.r, height: 55.r),
                      Text(
                        "${isVideo ? T.privateVideo.tr : T.privatePhoto.tr} ${len == 0 ? "" : len}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(height: 10.h, color: Colors.transparent),
                      if (isLoading && status == PrivatePackageStatus.loading)
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
                      totalDuration: 60,
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
              ],
            ),
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

  ///解锁
  void handUncock(LocalWrapperMsg msgItem) {
    setState(() {
      isLoading = true;
      status = PrivatePackageStatus.loading;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        status = PrivatePackageStatus.countdown;
        // widget.onTap?.call();
      });
    });
  }

  void toPreview(PrivatePackageMessage privatePackageMsg) {
    bool isLocal = privatePackageMsg.direction == RCIMIWMessageDirection.send;
    bool isVideo = privatePackageMsg.data?.isVideo ?? false;
    if (isVideo) {
      RouteManager.toPreviewView(
        viewId: PreviewViewType.multipleVideo.index,
        data: {"message": privatePackageMsg},
      );
    } else {
      RouteManager.toPreviewView(
        viewId: PreviewViewType.multiplePhoto.index,
        data: {"message": privatePackageMsg},
      );
    }
  }
}
