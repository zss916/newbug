import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/profile/album/preview/widget/profile_private_album/private_album_video_plus.dart';

class BuildSinglePrivateVideo extends StatelessWidget {
  final String url;
  final String? thumbUrl;
  final Function? onFinished;
  final bool? isCountDown;
  final int? countDown;

  const BuildSinglePrivateVideo({
    super.key,
    required this.url,
    this.thumbUrl,
    this.onFinished,
    this.isCountDown,
    this.countDown,
  });

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
          child: Column(
            children: [
              Expanded(
                child: PrivateAlbumVideoPlus(
                  url: url,
                  thumbUrl: thumbUrl ?? "",
                ),
              ),
              if (isCountDown == true)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsetsDirectional.only(top: 12.h, bottom: 12.h),
                  alignment: Alignment.center,
                  child: CountDownWidget(
                    totalDuration: countDown ?? 0,
                    alpha: 0,
                    onFinished: () {
                      onFinished?.call();
                    },
                  ),
                ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).padding.bottom,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
