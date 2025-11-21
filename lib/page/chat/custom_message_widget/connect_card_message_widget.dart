import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_thumbnail/flutter_video_thumbnail.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/im/custom_message/connected_message.dart';
import 'package:newbug/generated/assets.dart';

///建联卡
class ConnectCardMessageWidget extends StatelessWidget {
  final ConnectModel? data;

  const ConnectCardMessageWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsetsDirectional.all(12.r),
      margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 22.h),
      constraints: BoxConstraints(minHeight: 234.h),
      decoration: BoxDecoration(
        color: Color(0xFFF7DEF9),
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                margin: EdgeInsetsDirectional.only(end: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(data?.headimg ?? ""),
                  ),
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),

              Expanded(
                child: Text(
                  data?.name ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 8.h, color: Colors.transparent),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: buildItem(
                    path: data?.videoUrl ?? "",
                    isVideo: true,
                    isEmpty: data?.isVideoEmpty ?? false,
                  ),
                ),
              ),
              VerticalDivider(width: 10.w, color: Colors.transparent),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: buildItem(
                    path: data?.imageUrl ?? "",
                    isVideo: false,
                    isEmpty: (data?.isImageEmpty ?? false),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String path,
    required bool isVideo,
    required bool isEmpty,
  }) => isVideo
      ? FutureBuilder(
          future: FlutterVideoThumbnail.getThumbnail(path),
          builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
            return (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData)
                ? Container(
                    width: double.maxFinite,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: isEmpty
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: ExtendedMemoryImageProvider(
                                snapshot.data!,
                              ),
                            ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!isEmpty)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Image.asset(Assets.imgLock, width: 45, height: 45),
                        PositionedDirectional(
                          bottom: 8.h,
                          start: 8.w,
                          end: 8.w,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  isVideo
                                      ? T.privateVideo.tr
                                      : T.privatePhoto.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  isEmpty ? T.isEmpty.tr : T.isFilled.tr,
                                  style: TextStyle(
                                    color: isEmpty
                                        ? Color(0xFF8C8C8C)
                                        : Color(0xFF43CC25),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isVideo)
                          PositionedDirectional(
                            top: 10.h,
                            start: 10.w,
                            child: Image.asset(
                              Assets.imgIcVideo,
                              width: 28.w,
                              height: 20.h,
                            ),
                          ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF0092)),
                  );
          },
        )
      : Container(
          width: double.maxFinite,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.black,
            image: isEmpty
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(path),
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!isEmpty)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              Image.asset(Assets.imgLock, width: 45, height: 45),
              PositionedDirectional(
                bottom: 8.h,
                start: 8.w,
                end: 8.w,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        isVideo ? T.privateVideo.tr : T.privatePhoto.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        isEmpty ? T.isEmpty.tr : T.isFilled.tr,
                        style: TextStyle(
                          color: isEmpty
                              ? Color(0xFF8C8C8C)
                              : Color(0xFF43CC25),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isVideo)
                PositionedDirectional(
                  top: 10.h,
                  start: 10.w,
                  child: Image.asset(
                    Assets.imgIcVideo,
                    width: 28.w,
                    height: 20.h,
                  ),
                ),
            ],
          ),
        );
}
