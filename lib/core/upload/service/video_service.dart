import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:newbug/core/upload/cache/asset_cache_service.dart';
import 'package:newbug/core/upload/utils/toast_util.dart';
import 'package:video_compress/video_compress.dart';

/// 视频处理工具类
class VideoService {
  /// 压缩
  static Future<File> compressVideo(
    File file, {
    int miniCompressLength = 20 * 1024 * 1024,
    bool showToast = false,
    bool deleteOrigin = false,
    int? startTime,
    int? duration,
    bool? includeAudio,
    int frameRate = 30,
  }) async {
    final fileSize = file.lengthSync();
    final needCompress = (fileSize <= miniCompressLength);
    if (!needCompress) {
      return file;
    }

    try {

      final quality = needCompress
          ? VideoQuality.MediumQuality
          : VideoQuality.HighestQuality;
      final compressVideoMediaInfo = await VideoCompress.compressVideo(
        file.path,
        quality: quality,
        deleteOrigin: deleteOrigin,
        startTime: startTime,
        duration: duration,
        includeAudio: includeAudio,
        frameRate: frameRate,
      );
      debugPrint(
        "compressVideoMediaInfo: ${compressVideoMediaInfo?.toJson()},",
      );
      return compressVideoMediaInfo?.file ?? file;
    } catch (e) {
      debugPrint("e: $e,");
    }
    return file;
  }

  /// 元数据
  static Future<MediaInfo> getMediaInfo(String path) async {
    return VideoCompress.getMediaInfo(path);
  }

  /// 缩略图
  static Future<File> getFileThumbnail(
    String path, {
    int quality = 50,
    int position = -1,
  }) async {
    final thumbnailFile = VideoCompress.getFileThumbnail(
      path,
      quality: quality, // default(100)
      position: position, // default(-1)
    );
    return thumbnailFile;
  }

  /// 删除缓存文件夹
  static Future<bool?> deleteAllCache() async {
    return VideoCompress.deleteAllCache();
  }

  /// 保存视频到相册
  static Future<bool> saveVideo({
    required String url,
    bool showToast = true,
  }) async {
    final percentVN = ValueNotifier(0.0);

    ToastUtil.loading(
      "File downloading",
      indicator: ValueListenableBuilder<double>(
        valueListenable: percentVN,
        builder: (context, value, child) {
          return CircularProgressIndicator(value: value);
        },
      ),
    );

    String? name;
    try {
      name = url.split("/").last;
    } catch (e) {
      debugPrint("saveVideo name: ${e.toString()}");
      name = "tmp.mp4";
    }

    var cacheDir = await AssetCacheService().getDir();
    var savePath = "${cacheDir.path}/$name";
    await Dio().download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final percent = (received / total);
          final percentStr = "${(percent * 100).toStringAsFixed(0)}%";
          percentVN.value = percent;
          // debugPrint("percentStr: $percentStr");
        }
      },
    );
    // debugPrint("savePath: ${savePath}");
    ToastUtil.hideLoading();

    final result = await ImageGallerySaverPlus.saveFile(savePath);
    debugPrint("saveFile: $result $url");
    final isSuccess = result["isSuccess"];
    final message = isSuccess ? "Saved to album" : "Operation failed";
    if (isSuccess && showToast) {
      ToastUtil.show(message);
    }
    return isSuccess;
  }
}

/// 图片文件扩展方法
extension VideoFileExt on File {}
