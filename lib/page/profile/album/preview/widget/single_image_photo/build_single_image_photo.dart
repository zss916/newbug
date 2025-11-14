import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/album/preview/widget/preview_image.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class BuildSingleImagePhoto extends StatelessWidget {
  final RCIMIWImageMessage? message;
  const BuildSingleImagePhoto({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF504C43), Color(0xFF49443A)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.back(),
            child: UnconstrainedBox(
              child: Image.asset(
                Assets.imgToBack,
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(child: buildPreview(message)),
      ),
    );
  }

  Widget buildPreview(RCIMIWImageMessage? message) {
    ///先加载thumbnailBase64String 再remote
    if (message?.thumbnailBase64String != null) {
      return PreviewImage(
        url: message?.thumbnailBase64String ?? "",
        type: ImageType.memory,
      );
    } else {
      if (message?.remote != null) {
        return PreviewImage(
          url: message?.remote ?? "",
          type: ImageType.network,
        );
      } else if (File(message?.local ?? "").existsSync()) {
        return PreviewImage(url: message?.local ?? "", type: ImageType.file);
      } else if (message?.thumbnailBase64String != null) {
        return PreviewImage(
          url: message?.thumbnailBase64String ?? "",
          type: ImageType.memory,
        );
      } else {
        return SizedBox.shrink();
      }
    }
  }
}
