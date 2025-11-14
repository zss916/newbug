import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/loading_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';

///私密媒体消息状态(photo/video)
enum PrivateMediaStatus { private, loading, countdown, destroyed }

class MediaMessageWidget extends StatefulWidget {
  final bool isLocal;
  final bool? isPrivate;
  final bool? isDestroyed;
  final bool? isVideo;
  final Function? onTap;
  final LocalWrapperMsg msgItem;

  const MediaMessageWidget({
    super.key,
    required this.msgItem,
    required this.isLocal,
    this.isVideo,
    this.isPrivate,
    this.isDestroyed,
    this.onTap,
  });

  @override
  State<MediaMessageWidget> createState() => _MediaMessageWidgetState();
}

class _MediaMessageWidgetState extends State<MediaMessageWidget> {
  bool isPrivate = true;
  bool isDestroyed = false;
  bool isLoading = false;
  bool isVideo = false;

  PrivateMediaStatus status = PrivateMediaStatus.private;

  @override
  void initState() {
    super.initState();
    isPrivate = widget.isPrivate ?? true;
    isDestroyed = widget.isDestroyed ?? false;
    isVideo = widget.isVideo ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isDestroyed == true ||
            status == PrivateMediaStatus.destroyed)
        ? buildFireStatusWidget()
        : MessageWrapperWidget(
            isLocal: widget.isLocal,
            child: isPrivate
                ? buildPrivateMediaWidget(widget.msgItem)
                : buildPublicMediaWidget(widget.msgItem),
          );
  }

  ///公开
  Widget buildPublicMediaWidget(LocalWrapperMsg msgItem) {
    PublicMessage publicMessage = msgItem.rCIMIWMessage as PublicMessage;
    //debugPrint("publicMessage ===>> ${publicMessage.data?.toJson()}");

    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        width: 179.w,
        height: 232.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedNetworkImageProvider(
              publicMessage.data?.imageUrl ?? "",
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: widget.isLocal ? Radius.zero : Radius.circular(12.r),
            topLeft: widget.isLocal ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
      ),
    );
  }

  /// 私密
  Widget buildPrivateMediaWidget(LocalWrapperMsg msgItem) {
    PrivateMessage privateMessage = msgItem.rCIMIWMessage as PrivateMessage;
    return InkWell(
      onTap: () {
        handTapImage();
      },
      child: Container(
        width: 179.w,
        height: 232.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.isLocal ? Color(0xFFCDD2FF) : Color(0xFFF6CDFF),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedNetworkImageProvider(
              privateMessage.data?.imageUrl ?? "",
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
            if (status == PrivateMediaStatus.private ||
                status == PrivateMediaStatus.loading)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: widget.isLocal
                        ? Radius.zero
                        : Radius.circular(12.r),
                    topLeft: widget.isLocal
                        ? Radius.circular(12.r)
                        : Radius.zero,
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
                    isVideo ? T.privateVideo.tr : T.privatePhoto.tr,
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
            if (status == PrivateMediaStatus.private ||
                status == PrivateMediaStatus.loading)
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

            /// Video
            if (isVideo)
              PositionedDirectional(
                top: 8,
                start: 8,
                child: Image.asset(
                  Assets.imgIcVideo,
                  width: 28.w,
                  height: 20.h,
                ),
              ),

            if (isVideo && status == PrivateMediaStatus.countdown)
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

  ///tap
  void handTapImage() {
    if (status == PrivateMediaStatus.private) {
      setState(() {
        isLoading = true;
        status = PrivateMediaStatus.loading;

        ///加载缓存
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
            status = PrivateMediaStatus.countdown;
            widget.onTap?.call();
          });
        });
      });
    } else if (status == PrivateMediaStatus.loading) {
      debugPrint("loading");
    } else if (status == PrivateMediaStatus.countdown) {
      debugPrint("countdown");
      widget.onTap?.call();
    } else if (status == PrivateMediaStatus.destroyed) {
      debugPrint("destroyed");
    }
  }
}
