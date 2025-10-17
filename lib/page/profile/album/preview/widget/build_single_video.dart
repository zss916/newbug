import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/album/preview/widget/preview_video_plus.dart';

class BuildSingleVideo extends StatelessWidget {
  final String url;
  final Function? onFinished;
  final bool? isPrivate;

  const BuildSingleVideo({
    super.key,
    required this.url,
    this.onFinished,
    this.isPrivate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: Get.statusBarHeight),
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF504C43), Color(0xFF49443A)],
          ),
        ),
        child: PreviewVideoPlus(url: url, isPrivate: isPrivate),
      ),
    );
  }
}
