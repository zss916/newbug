import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/common_thumbnail_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/profile/album/preview/widget/profile_private_album/private_album_video_plus.dart';

class BuildMultipleVideo extends StatefulWidget {
  final Function? onFinished;
  final int? countDown;
  final PackageMediaModel? data;

  const BuildMultipleVideo({
    super.key,
    this.data,
    this.countDown,
    this.onFinished,
  });

  @override
  State<BuildMultipleVideo> createState() => _BuildMultipleVideoState();
}

class _BuildMultipleVideoState extends State<BuildMultipleVideo> {
  final PageController controller = PageController();

  int currentIndex = 0;

  List<PackageMediaItem> medias = [];

  @override
  void initState() {
    super.initState();
    medias = widget.data?.list ?? [];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      ...medias.map(
                        (e) => PrivateAlbumVideoPlus(
                          key: ValueKey(e.url),
                          url: e.url,
                          thumbUrl: e.thumb_url,
                          child: SizedBox(height: 64.h),
                        ),
                      ),
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  PositionedDirectional(
                    start: 0,
                    end: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                      height: 64.h,
                      child: ListView.separated(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: medias.length,
                        itemBuilder: (context, index) {
                          PackageMediaItem item = medias[index];
                          return _buildSmallImage(index, item);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            VerticalDivider(
                              width: 4.w,
                              color: Colors.transparent,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if ((widget.countDown ?? 0) > 0)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                width: double.maxFinite,
                padding: EdgeInsetsDirectional.only(top: 12.h, bottom: 12.h),
                alignment: Alignment.center,
                child: CountDownWidget(
                  totalDuration: widget.countDown ?? 0,
                  alpha: 0,
                  onFinished: () {
                    widget.onFinished?.call();
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
    );
  }

  Widget _buildSmallImage(int index, PackageMediaItem item) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
          controller.jumpToPage(index);
        });
      },

      child: item.thumb_url == null
          ? CommonThumbnailWidget(
              videoPath: item.url,
              builder: (String? thumbnailPath) {
                item.thumb_url = thumbnailPath;
                return _buildSmallCustomUI(index, thumbnailPath);
              },
            )
          : _buildSmallCustomUI(index, item.thumb_url),
    );
  }

  Widget _buildSmallCustomUI(int index, String? thumbPath) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 42.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: currentIndex == index
            ? Border.all(width: 2.r, color: Color(0xFFFF0092))
            : null,
        borderRadius: BorderRadius.circular(4.r),
        image: thumbPath == null
            ? null
            : DecorationImage(
                image: ExtendedFileImageProvider(File(thumbPath)),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
