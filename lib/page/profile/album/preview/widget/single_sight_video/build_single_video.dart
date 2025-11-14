import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/profile/album/preview/widget/single_sight_video/preview_video_plus.dart';

class BuildSingleVideo extends StatelessWidget {
  final String url;
  final Function? onFinished;
  final bool? isPrivate;
  final String? thumb;

  const BuildSingleVideo({
    super.key,
    required this.url,
    this.onFinished,
    this.isPrivate,
    this.thumb,
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
        padding: EdgeInsets.only(top: Get.statusBarHeight - 30.h),
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF504C43), Color(0xFF49443A)],
          ),
        ),
        child: PreviewVideoPlus(
          url: url,
          thumbUrl: thumb,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
            ),
            width: double.maxFinite,
            padding: EdgeInsetsDirectional.only(top: 12.h, bottom: 12.h),
            alignment: Alignment.center,
            child: CountDownWidget(
              totalDuration: 60,
              alpha: 0,
              onFinished: () {
                onFinished?.call();
              },
            ),
          ),
        ),
      ),
    );
  }
}
