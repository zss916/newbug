import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';

class SwiperItem extends StatelessWidget {
  final int index;
  const SwiperItem({super.key, required this.index});

  static const List<String> images = [
    Assets.subscribeWhoLikeMe,
    Assets.subscribeIncognitoModel,
    Assets.subscribeUnlockYourVisitors,
    Assets.subscribeFlashChat,
    Assets.subscribeUnlimitedLikes,
    Assets.subscribePrivateVideos,
    Assets.subscribePrivatePhotos,
    Assets.subscribeYourPrivateAlbum,
  ];

  @override
  Widget build(BuildContext context) {
    return Image.asset(images[index], width: Get.width - 40.w);
  }
}
