import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';

class SelectedAlbumLogic extends GetxController {
  List<MediaListItem?> videos = [];
  List<MediaListItem?> images = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      videos = map['selectVideos'] as List<MediaListItem?>;
      images = map['selectImages'] as List<MediaListItem?>;
      debugPrint("images => ${images.toString()}");
    }
  }

  ///私有打包发送
  void toConfirm() {}
}
