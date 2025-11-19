import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_thumbnail/flutter_video_thumbnail.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/widget/generated/assets.dart';

class PrivateVideoThumbnailWidget extends StatelessWidget {
  final String videoPath;
  final MediaListItem? item;
  final double? w;
  final double? h;
  final BorderRadiusGeometry? borderRadius;
  final bool isChecked;
  const PrivateVideoThumbnailWidget({
    super.key,
    required this.videoPath,
    this.item,
    this.w,
    this.h,
    this.borderRadius,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    String localFilePath = AppStores.getThumb(key: videoPath);
    if (File(localFilePath).existsSync()) {
      return Container(
        width: w ?? 108,
        height: h ?? 143,
        decoration: ShapeDecoration(
          color: Colors.grey.shade200,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedFileImageProvider(File(localFilePath)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.black.withValues(alpha: 0.50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: 3.w),
                              child: Image.asset(
                                Assets.imgIcAlbumVideo,
                                width: 12,
                                height: 12,
                              ),
                            ),
                            Text(
                              item?.showVideoDuration ?? "00:00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 5.w),
                        child: StatefulBuilder(
                          builder: (_, setState) {
                            return InkWell(
                              onTap: () {
                                setState(() => (isChecked == !isChecked));
                              },
                              child: Image.asset(
                                isChecked
                                    ? Assets.imgCheckedIcon
                                    : Assets.imgUncheckIcon,
                                width: 24,
                                height: 24,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return FutureBuilder(
        future: getThumbnail(videoPath),
        builder: (_, AsyncSnapshot<File?> snapshot) {
          String localFilePath = AppStores.getThumb(key: videoPath);
          if (File(localFilePath).existsSync()) {
            return Container(
              width: w ?? 108,
              height: h ?? 143,
              decoration: ShapeDecoration(
                color: Colors.grey.shade200,
                image: snapshot.data == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: ExtendedFileImageProvider(snapshot.data!),
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(8),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.black.withValues(alpha: 0.50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                      end: 3.w,
                                    ),
                                    child: Image.asset(
                                      Assets.imgIcAlbumVideo,
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                  Text(
                                    item?.showVideoDuration ?? "00:00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 5.w),
                              child: StatefulBuilder(
                                builder: (_, setState) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() => (isChecked == !isChecked));
                                    },
                                    child: Image.asset(
                                      isChecked
                                          ? Assets.imgCheckedIcon
                                          : Assets.imgUncheckIcon,
                                      width: 24,
                                      height: 24,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
              ? Container(
                  width: w ?? 108,
                  height: h ?? 143,
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade200,
                    image: snapshot.data == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: ExtendedFileImageProvider(snapshot.data!),
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius ?? BorderRadius.circular(8),
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: Colors.black.withValues(alpha: 0.50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                          end: 3.w,
                                        ),
                                        child: Image.asset(
                                          Assets.imgIcAlbumVideo,
                                          width: 12,
                                          height: 12,
                                        ),
                                      ),
                                      Text(
                                        item?.showVideoDuration ?? "00:00",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                    start: 5.w,
                                  ),
                                  child: StatefulBuilder(
                                    builder: (_, setState) {
                                      return InkWell(
                                        onTap: () {
                                          setState(
                                            () => (isChecked == !isChecked),
                                          );
                                        },
                                        child: Image.asset(
                                          isChecked
                                              ? Assets.imgCheckedIcon
                                              : Assets.imgUncheckIcon,
                                          width: 24,
                                          height: 24,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Color(0xFFFF0092)),
                );
        },
      );
    }
  }

  Future<File?> getThumbnail(String videoPath) async {
    final cacheManager = DefaultCacheManager();
    FileInfo? fileInfo = await cacheManager.getFileFromCache(videoPath);
    if (fileInfo == null) {
      Uint8List? thumbnailData = await FlutterVideoThumbnail.getThumbnail(
        videoPath,
      );
      if (thumbnailData != null) {
        File thumbnailFile = await cacheManager.putFile(
          videoPath,
          thumbnailData,
        );
        AppStores.setThumb(key: videoPath, value: thumbnailFile.path);
        return thumbnailFile;
      } else {
        return null;
      }
    } else {
      AppStores.setThumb(key: videoPath, value: fileInfo.file.path);
      return fileInfo.file;
    }
  }
}
