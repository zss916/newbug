import 'dart:convert';

import 'package:get/get.dart';
import 'package:newbug/core/im/utils/im_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/route/observer/routes_extend.dart';
import 'package:newbug/core/stores/event.dart';

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
      //debugPrint("images => ${images.toString()}");
    }
  }

  ///私有打包发送
  void toConfirm() {
    List<String> result = [];
    if (images.isNotEmpty) {
      images.removeWhere((e) => e?.isChecked != true);
      result.add(jsonEncode(images));
    }
    if (videos.isNotEmpty) {
      videos.removeWhere((e) => e?.isChecked != true);
      result.add(jsonEncode(videos));
    }
    EventService.to.post(SendPrivatePackageMsgEvent(content: result));
    Get.removeName(AppRoutes.selectedAlbum);
    Get.removeName(AppRoutes.privateAlbum);
  }
}
