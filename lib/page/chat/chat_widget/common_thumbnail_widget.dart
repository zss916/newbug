import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_video_thumbnail/flutter_video_thumbnail.dart';
import 'package:newbug/core/stores/app_stores.dart';

typedef WidgetThumbnailBuilder = Widget Function(String? thumbnailPath);

///通用
class CommonThumbnailWidget extends StatelessWidget {
  final String videoPath;
  final WidgetThumbnailBuilder builder;

  const CommonThumbnailWidget({
    super.key,
    required this.videoPath,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    String localFilePath = AppStores.getThumb(key: videoPath);
    if (File(localFilePath).existsSync()) {
      return builder(localFilePath);
    } else {
      return FutureBuilder(
        future: getThumbnail(videoPath),
        builder: (_, AsyncSnapshot<File?> snapshot) {
          String localFilePath = AppStores.getThumb(key: videoPath);
          if (File(localFilePath).existsSync()) {
            return builder(localFilePath);
          }
          return (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
              ? builder(snapshot.data!.path)
              : builder(null);
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
