import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressUtils {
  /// 压缩配置常量
  static const int _maxFileSize = 300 * 1024; // 300KB
  static const int _maxWidth = 800;
  static const int _minQuality = 70;
  static const int _maxCompressCount = 5;

  /// 支持的图片格式映射
  static final Map<String, CompressFormat> _formatMap = {
    '.jpg': CompressFormat.jpeg,
    '.jpeg': CompressFormat.jpeg,
    '.png': CompressFormat.png,
    '.webp': CompressFormat.webp,
    '.heic': CompressFormat.heic,
    '.heif': CompressFormat.heic,
  };

  ///图片压缩方法
  static Future<File> compressImage({
    required File file,
    int? fileWidth,
    int? fileHeight,
    int maxCompressCount = _maxCompressCount,
  }) async {
    // 参数验证
    if (maxCompressCount <= 0) {
      throw ArgumentError('压缩次数必须大于0');
    }

    return await _compressRecursive(
      file: file,
      fileWidth: fileWidth,
      fileHeight: fileHeight,
      remainingCount: maxCompressCount,
    );
  }

  /// 递归压缩核心逻辑
  static Future<File> _compressRecursive({
    required File file,
    int? fileWidth,
    int? fileHeight,
    required int remainingCount,
  }) async {
    // 退出条件检查
    if (remainingCount <= 0) {
      debugPrint('达到最大压缩次数，返回当前文件');
      return file;
    }

    // 检查文件大小
    final fileSize = await file.length();
    if (fileSize <= _maxFileSize) {
      debugPrint('文件已小于$_maxFileSize字节，无需压缩');
      return file;
    }

    // 生成目标文件路径
    final originPath = file.path;
    final targetPath = _generateTargetPath(originPath);

    try {
      // 计算目标尺寸
      final (targetWidth, targetHeight) = _calculateTargetSize(
        fileWidth: fileWidth,
        fileHeight: fileHeight,
      );

      // 获取压缩格式
      final format = _getCompressFormat(originPath);

      // 执行压缩
      final result = await FlutterImageCompress.compressAndGetFile(
        originPath,
        targetPath,
        quality: _minQuality,
        format: format,
        minWidth: targetWidth,
        minHeight: targetHeight,
      );

      if (result == null) {
        throw Exception('图片压缩失败');
      }

      final compressedFile = File(result.path);
      final compressedSize = await compressedFile.length();

      debugPrint('压缩完成: ${fileSize ~/ 1024}KB -> ${compressedSize ~/ 1024}KB');

      // 递归检查是否需要继续压缩
      return await _compressRecursive(
        file: compressedFile,
        fileWidth: fileWidth,
        fileHeight: fileHeight,
        remainingCount: remainingCount - 1,
      );
    } catch (e) {
      debugPrint('压缩过程中发生错误: $e');
      return file; // 发生错误时返回原文件
    }
  }

  /// 生成目标文件路径
  static String _generateTargetPath(String originPath) {
    final extension = _getFileExtension(originPath);
    final baseName = originPath.substring(0, originPath.lastIndexOf('.'));
    return '$baseName-compressed$extension';
  }

  /// 获取文件扩展名
  static String _getFileExtension(String path) {
    final dotIndex = path.lastIndexOf('.');
    if (dotIndex == -1) return '.jpeg';
    return path.substring(dotIndex).toLowerCase();
  }

  /// 获取压缩格式
  static CompressFormat _getCompressFormat(String path) {
    final extension = _getFileExtension(path);
    return _formatMap[extension] ?? CompressFormat.jpeg;
  }

  /// 计算目标尺寸
  static (int, int) _calculateTargetSize({int? fileWidth, int? fileHeight}) {
    if (fileWidth == null || fileHeight == null || fileWidth <= 0) {
      return (_maxWidth, _maxWidth);
    }

    final scale = _maxWidth / fileWidth;
    final targetWidth = _maxWidth;
    final targetHeight = (fileHeight * scale).round();

    return (targetWidth, targetHeight);
  }

  /// 批量压缩图片
  static Future<List<File>> compressMultipleImages({
    required List<File> files,
    int? fileWidth,
    int? fileHeight,
    int maxCompressCount = _maxCompressCount,
  }) async {
    final results = <File>[];

    for (final file in files) {
      try {
        final compressedFile = await compressImage(
          file: file,
          fileWidth: fileWidth,
          fileHeight: fileHeight,
          maxCompressCount: maxCompressCount,
        );
        results.add(compressedFile);
      } catch (e) {
        print('文件 ${file.path} 压缩失败: $e');
        results.add(file); // 失败时保留原文件
      }
    }

    return results;
  }
}
