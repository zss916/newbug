import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///网络图片预加载缓存
class ImageCacheHelper {
  ///设置缓存参数
  static setImageCache() {
    final ImageCache imageCache = PaintingBinding.instance.imageCache;
    imageCache.clear();
    imageCache.maximumSize = 100; // 最大缓存图片数量
    imageCache.maximumSizeBytes = 350 * 1024 * 1024; // 最大缓存容量 350MB
  }

  ///在dispose使用
  static clear() {
    PaintingBinding.instance.imageCache.clear();
  }

  ///预加载
  static precache({required String url, BuildContext? context}) async {
    if ((url).isEmpty) return;
    if (!GetUtils.isURL(url)) return;
    if (GetUtils.isVideo(url)) return;

    final imageProvider = CachedNetworkImageProvider(
      url,
      // cache: true,
      // timeRetry: Duration(seconds: 1),
    );
    await precacheImage(imageProvider, context ?? (Get.context!));
  }
}
