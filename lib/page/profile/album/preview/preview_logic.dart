import 'package:get/get.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
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
  RCIMIWImageMessage? imageMsg;
  RCIMIWSightMessage? videoMsg;
  PublicMessage? publicMsg;
  PrivateMessage? privateMsg;
  MediaListItem? media;
  PrivatePackageMessage? privatePkgMsg;
  int? countDown;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      viewType = Get.arguments["viewId"] as int;
      if (viewType == PreviewViewType.singleImagePhoto.index) {
        imageMsg = Get.arguments["data"]["message"] as RCIMIWImageMessage;
      } else if (viewType == PreviewViewType.singlePublicPhoto.index) {
        publicMsg = Get.arguments["data"]["message"] as PublicMessage;
      } else if (viewType == PreviewViewType.singlePublicVideo.index) {
        publicMsg = Get.arguments["data"]["message"] as PublicMessage;
      } else if (viewType == PreviewViewType.singlePrivatePhoto.index) {
        privateMsg = Get.arguments["data"]["message"] as PrivateMessage;
        countDown = handCountDown(privateMsg?.expansion ?? {});
      } else if (viewType == PreviewViewType.singleSightVideo.index) {
        videoMsg = Get.arguments["data"]["message"] as RCIMIWSightMessage;
      } else if (viewType == PreviewViewType.singlePrivateVideo.index) {
        privateMsg = Get.arguments["data"]["message"] as PrivateMessage;
        countDown = handCountDown(privateMsg?.expansion ?? {});
      } else if (viewType == PreviewViewType.profilePrivateAlbum.index) {
        media = Get.arguments["data"]["media"] as MediaListItem?;
      } else if (viewType == PreviewViewType.multiplePhoto.index) {
        privatePkgMsg =
            Get.arguments["data"]["message"] as PrivatePackageMessage;
        countDown = handCountDown(privatePkgMsg?.expansion ?? {});
      } else if (viewType == PreviewViewType.multipleVideo.index) {
        privatePkgMsg =
            Get.arguments["data"]["message"] as PrivatePackageMessage;
        countDown = handCountDown(privatePkgMsg?.expansion ?? {});
      }
    }
  }

  ///处理倒计时
  int handCountDown(Map expansion) {
    PrivacyExtraData extra = PrivacyExtraData.fromJson(expansion);
    if (extra.status == "1") {
      DateTime targetDateTime = DateTime.fromMillisecondsSinceEpoch(
        (int.parse(extra.del_time ?? "0")) * 1000,
      );
      final difference = targetDateTime.difference(DateTime.now());

      return difference.inSeconds;
    } else {
      return 0;
    }
  }
}
