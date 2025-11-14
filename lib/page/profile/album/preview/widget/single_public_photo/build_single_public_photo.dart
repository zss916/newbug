import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/album/preview/widget/preview_image.dart';

class BuildSinglePublicPhoto extends StatelessWidget {
  final String url;

  const BuildSinglePublicPhoto({super.key, required this.url});

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
        body: SizedBox.expand(
          child: PreviewImage(url: url, type: ImageType.network),
        ),
      ),
    );
  }
}
