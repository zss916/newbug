import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';
import 'package:get/get.dart';
import 'package:newbug/core/album/compress/file_compress_utils.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:video_compress/video_compress.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class GalleryTools {
  /// 常量定义
  // static const int _imageMaxSize = 10 * 1024 * 1024; // 10MB

  static const int _imageMaxSize = 10 * 1024 * 1024; // 10MB
  static const int _videoMaxSize = 15 * 1024 * 1024; // 15MB
  static const int _maxVideoDuration = 15; // 15秒

  /// 支持的图片格式
  static const Set<String> _supportedImageFormats = {
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.heic',
    '.heif',
  };

  /// 支持的视频格式
  static const Set<String> _supportedVideoFormats = {'.mp4', '.mov'};

  /// 打开相册
  static Future<List<AssetEntity>> openGallery({
    required BuildContext context,
    int maxAssets = 6,
    RequestType type = RequestType.common,
    SpecialPickerType? specialPickerType,
    List<AssetEntity>? selectedAssets,
  }) async {
    try {
      // 隐藏键盘
      FocusManager.instance.primaryFocus?.unfocus();

      final currentState = await PhotoManager.getPermissionState(
        requestOption: const PermissionRequestOption(),
      );
      //检查权限
      final PermissionState state =
          await PhotoManager.requestPermissionExtend();
      if (state != PermissionState.authorized &&
          state != PermissionState.limited) {
        openAppSettings();
        return [];
      } else if (currentState == PermissionState.notDetermined &&
          state == PermissionState.authorized) {
        return openGallery(
          context: context,
          maxAssets: maxAssets,
          type: type,
          specialPickerType: specialPickerType,
          selectedAssets: selectedAssets,
        );
      }

      // 选择资源
      final result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: maxAssets,
          selectedAssets: selectedAssets,
          specialPickerType: specialPickerType,
          requestType: type,
          // filterOptions: FilterOptionGroup(containsPathModified: true),
          selectPredicate: _assetSelectPredicate,
        ),
      );

      return await _validateSelectedAssets(result);
    } catch (e) {
      debugPrint('媒体选择器错误: $e');
      CustomToast.showText('Operation failed, please try again');
      return [];
    }
  }

  //无权限跳转设置
  static void openAppSettings({bool isCamera = false}) async {
    var contentText = isCamera
        ? "Please allow access to your camera in the settings."
        : "Please allow access to the album in the settings.";
    await showDialog<bool>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFDF0FF),
          title: const Text(
            'Notice',
            style: TextStyle(
              color: Colors.black,
              fontFamily: AppFonts.font1,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            contentText,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                'Setting',
                style: TextStyle(
                  color: Color(0xFFFF0092),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
                PhotoManager.openSetting();
              },
            ),
          ],
        );
      },
    );
  }

  /// 检查并请求权限
  static Future<bool> _checkAndRequestPermission() async {
    try {
      final currentState = await PhotoManager.getPermissionState(
        requestOption: const PermissionRequestOption(),
      );

      final requestedState = await PhotoManager.requestPermissionExtend();

      return requestedState == PermissionState.authorized ||
          requestedState == PermissionState.limited;
    } catch (e) {
      debugPrint('权限检查错误: $e');
      return false;
    }
  }

  /// 资源选择条件判断
  static Future<bool> _assetSelectPredicate(
    BuildContext context,
    AssetEntity asset,
    bool isSelected,
  ) async {
    try {
      final file = await asset.originFile;
      if (file == null) return false;

      final fileSize = await file.length();
      final fileExtension = _getFileExtension(file.path);

      if (asset.type == AssetType.image) {
        return _validateImage(file, fileSize, fileExtension);
      } else if (asset.type == AssetType.video) {
        return _validateVideo(asset, file, fileSize, fileExtension);
      }

      return true;
    } catch (e) {
      debugPrint('资源选择判断错误: $e');
      return false;
    }
  }

  /// 验证图片资源
  static bool _validateImage(File file, int fileSize, String fileExtension) {
    if (!_supportedImageFormats.contains(fileExtension.toLowerCase())) {
      CustomToast.showText('UnSupport Type');
      return false;
    }

    if (fileSize > _imageMaxSize) {
      CustomToast.showText('Image Size Limit 10M');
      return false;
    }

    return true;
  }

  /// 验证视频资源
  static bool _validateVideo(
    AssetEntity asset,
    File file,
    int fileSize,
    String fileExtension,
  ) {
    if (asset.duration > _maxVideoDuration) {
      CustomToast.showText('Can\'t select videos longer than 15s');
      return false;
    }

    if (!_supportedVideoFormats.contains(fileExtension.toLowerCase())) {
      CustomToast.showText('不支持该视频格式');
      return false;
    }

    if (fileSize > _videoMaxSize) {
      CustomToast.showText('Video Size Limit 15M');
      return false;
    }

    return true;
  }

  /// 验证已选择的资源
  static Future<List<AssetEntity>> _validateSelectedAssets(
    List<AssetEntity>? result,
  ) async {
    if (result == null || result.isEmpty) return [];

    // 单资源额外验证
    if (result.length == 1) {
      final isValid = await _validateSingleAsset(result.first);
      return isValid ? result : [];
    }

    return result;
  }

  /// 验证单个资源
  static Future<bool> _validateSingleAsset(AssetEntity asset) async {
    try {
      final file = await asset.originFile;
      if (file == null) return false;

      final fileSize = await file.length();
      final fileExtension = _getFileExtension(file.path);

      if (asset.type == AssetType.image) {
        if (fileSize > _imageMaxSize) {
          CustomToast.showText('Image Size Limit 10M');
          return false;
        }
      } else {
        if (!_supportedVideoFormats.contains(fileExtension.toLowerCase())) {
          CustomToast.showText('UnSupport Type');
          return false;
        }

        if (fileSize > _videoMaxSize) {
          CustomToast.showText('Video Size Limit 15M');
          return false;
        }
      }

      return true;
    } catch (e) {
      debugPrint('单资源验证错误: $e');
      return false;
    }
  }

  /// 获取文件扩展名
  static String _getFileExtension(String path) {
    final extension = path.toLowerCase().substring(path.lastIndexOf('.'));
    return extension;
  }

  /// 压缩图片文件
  static Future<File?> compressImageFile(AssetEntity assetEntity) async {
    if (assetEntity.type != AssetType.image) {
      return await assetEntity.originFile;
    }

    try {
      final originFile = await assetEntity.originFile;
      if (originFile == null) return null;

      final originalSize = originFile.lengthSync();
      debugPrint('原始图片大小: ${originalSize / 1024} KB');

      final compressFile = await CompressUtils.compressImage(
        file: originFile,
        fileWidth: assetEntity.width,
        fileHeight: assetEntity.height,
        maxCompressCount: 3,
      );

      final compressedSize = compressFile.lengthSync();
      debugPrint('压缩后图片大小: ${compressedSize / 1024} KB');
      debugPrint(
        '压缩率: ${((originalSize - compressedSize) / originalSize * 100).toStringAsFixed(2)}%',
      );

      return compressFile;
    } catch (e) {
      debugPrint('图片压缩错误: $e');
      return await assetEntity.originFile;
    }
  }

  /// 压缩视频文件
  static Future<File?> compressVideoFile(AssetEntity assetEntity) async {
    if (assetEntity.type != AssetType.video) {
      return await assetEntity.originFile;
    }

    try {
      final originFile = await assetEntity.originFile;
      assetEntity.file;
      if (originFile == null) return null;

      final originalSize = originFile.lengthSync();
      debugPrint(
        '原始视频大小: ${((originalSize / 1024) / 1024).toStringAsFixed(2)} M',
      );

      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        originFile.path,
        quality: VideoQuality.DefaultQuality,
        deleteOrigin: false,
      );

      final compressedSize = mediaInfo?.filesize ?? 0;
      debugPrint('压缩后视频大小: ${(compressedSize / 1024) / 1024} M');
      debugPrint(
        '压缩率: ${((originalSize - compressedSize) / originalSize * 100).toStringAsFixed(2)}%',
      );

      return mediaInfo?.file;
    } catch (e) {
      debugPrint('图片压缩错误: $e');
      return await assetEntity.originFile;
    }
  }

  /// 压缩图片文件2
  static Future<File?> compressImageFilePlus(MediaListItem media) async {
    if (media.type != 0) {
      return media.localFile;
    }

    try {
      final originFile = media.localFile;
      if (originFile == null) return null;

      final originalSize = originFile.lengthSync();
      debugPrint('原始图片大小: ${originalSize / 1024} KB');

      final compressFile = await CompressUtils.compressImage(
        file: originFile,
        // fileWidth: assetEntity.width,
        // fileHeight: assetEntity.height,
        maxCompressCount: 3,
      );

      final compressedSize = compressFile.lengthSync();
      debugPrint('压缩后图片大小: ${compressedSize / 1024} KB');
      debugPrint(
        '压缩率: ${((originalSize - compressedSize) / originalSize * 100).toStringAsFixed(2)}%',
      );

      return compressFile;
    } catch (e) {
      debugPrint('图片压缩错误: $e');
      return media.localFile;
    }
  }

  /// 压缩视频文件2
  static Future<File?> compressVideoFilePlus(MediaListItem media) async {
    if (media.type != 1) {
      return media.localFile;
    }

    try {
      final originFile = media.localFile;
      if (originFile == null) return null;

      final originalSize = originFile.lengthSync();
      debugPrint(
        '原始视频大小: ${((originalSize / 1024) / 1024).toStringAsFixed(2)} M',
      );

      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        originFile.path,
        quality: VideoQuality.DefaultQuality,
        deleteOrigin: false,
      );

      final compressedSize = mediaInfo?.filesize ?? 0;
      debugPrint('压缩后视频大小: ${(compressedSize / 1024) / 1024} M');
      debugPrint(
        '视频压缩率: ${((originalSize - compressedSize) / originalSize * 100).toStringAsFixed(2)}%',
      );

      return mediaInfo?.file;
    } catch (e) {
      debugPrint('视频压缩错误: $e');
      return media.localFile;
    }
  }

  /// 获取视频缩略图
  static Future<String?> getVideoThumbnail(String videoFilePath) async {
    return await FlutterVideoThumbnailPlus.thumbnailFile(
      video: videoFilePath,
      imageFormat: ImageFormat.jpeg,
      maxHeight: 150,
      quality: 100,
    );
  }

  /*  File? originImageFile = await e.originFile;
  int originSize = originImageFile?.lengthSync() ?? 0;
  debugPrint(
  "====>> originSize: ${((originSize / 1024) / 1024).toStringAsFixed(2)}M",
  );
  File? imageFile = await e.file;
  int currentSize = imageFile?.lengthSync() ?? 0;
  debugPrint(
  "====>> compressSize: ${((currentSize / 1024) / 1024).toStringAsFixed(2)}M",
  );

  File? imageFile2 = await GalleryTools.compressImageFile(e);
  int currentSize2 = imageFile2?.lengthSync() ?? 0;
  debugPrint(
  "====>> compressSize2: ${((currentSize2 / 1024) / 1024).toStringAsFixed(2)}M",
  );*/
}
