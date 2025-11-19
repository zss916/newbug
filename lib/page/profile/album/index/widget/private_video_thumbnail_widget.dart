import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_video_thumbnail/flutter_video_thumbnail.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/stores/app_stores.dart';

class PrivateVideoThumbnailWidget extends StatelessWidget {
  final String videoPath;
  final MediaListItem? item;
  final double? w;
  final double? h;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  const PrivateVideoThumbnailWidget({
    super.key,
    required this.videoPath,
    this.item,
    this.w,
    this.h,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    String localFilePath = AppStores.getThumb(key: videoPath);
    if (File(localFilePath).existsSync()) {
      return buildFileImageWidget(localFilePath);
    } else {
      return FutureBuilder(
        future: getThumbnail(videoPath),
        builder: (_, AsyncSnapshot<File?> snapshot) {
          String localFilePath = AppStores.getThumb(key: videoPath);
          if (File(localFilePath).existsSync()) {
            return buildFileImageWidget(localFilePath);
          }
          return (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
              ? buildFileImageWidget(snapshot.data!.path)
              : Center(
                  child: CircularProgressIndicator(color: Color(0xFFFF0092)),
                );
        },
      );
    }
  }

  Widget buildFileImageWidget(String filePath) {
    return Container(
      width: w ?? 108,
      height: h ?? 143,
      decoration: ShapeDecoration(
        color: Colors.grey.shade200,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: ExtendedFileImageProvider(File(filePath)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      child: child,
    );
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
