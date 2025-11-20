import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

enum PreviewViewType {
  singleImagePhoto,
  singlePublicPhoto,
  singlePrivatePhoto,
  singleSightVideo,
  singlePublicVideo,
  singlePrivateVideo,
  multiplePhoto,
  multipleVideo,
  profilePrivateAlbum,
  other,
}

class PreviewLogic extends GetxController {
  int viewType = PreviewViewType.other.index;
  RCIMIWImageMessage? imageMessage;
  PublicMessage? publicMessage;
  PrivateMessage? privatePhotoMessage;
  PrivateMessage? privateVideoMessage;
  RCIMIWSightMessage? videoMessage;
  MediaListItem? media;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      viewType = Get.arguments["viewId"] as int;
      if (viewType == PreviewViewType.singleImagePhoto.index) {
        imageMessage = Get.arguments["data"]["message"] as RCIMIWImageMessage;
      } else if (viewType == PreviewViewType.singlePublicPhoto.index) {
        publicMessage = Get.arguments["data"]["message"] as PublicMessage;
      } else if (viewType == PreviewViewType.singlePrivatePhoto.index) {
        privatePhotoMessage =
            Get.arguments["data"]["message"] as PrivateMessage;
      } else if (viewType == PreviewViewType.singleSightVideo.index) {
        videoMessage = Get.arguments["data"]["message"] as RCIMIWSightMessage;
      } else if (viewType == PreviewViewType.singlePrivateVideo.index) {
        privateVideoMessage =
            Get.arguments["data"]["message"] as PrivateMessage;

        /* debugPrint(
          "privateVideoMessage ===>> ${privateVideoMessage?.data?.thumbUrl}",
        );*/
      } else if (viewType == PreviewViewType.profilePrivateAlbum.index) {
        media = Get.arguments["data"]["media"] as MediaListItem?;
      }
      debugPrint("viewType ===>> $viewType");
    }
  }
}
