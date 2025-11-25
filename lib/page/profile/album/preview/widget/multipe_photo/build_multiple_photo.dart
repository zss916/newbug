import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/profile/album/preview/widget/base_preview/preview_image.dart';

class BuildMultiplePhoto extends StatefulWidget {
  final PackageMediaModel? data;
  final int? countDown;
  final Function? onFinished;
  const BuildMultiplePhoto({
    super.key,
    this.data,
    this.countDown,
    this.onFinished,
  });

  @override
  State<BuildMultiplePhoto> createState() => _BuildMultiplePhotoState();
}

class _BuildMultiplePhotoState extends State<BuildMultiplePhoto> {
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
          centerTitle: true,
          title: Text(
            "${currentIndex + 1} of ${medias.length}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
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
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Positioned.fill(
                    child: PageView(
                      controller: controller,
                      children: [
                        ...medias.map(
                          (e) =>
                              PreviewImage(url: e.url, type: ImageType.network),
                        ),
                      ],
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),

                  PositionedDirectional(
                    bottom: 0,
                    start: 0,
                    end: 0,
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
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                    controller.jumpToPage(index);
                                  });
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: 42.w,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    border: currentIndex == index
                                        ? Border.all(
                                            width: 2.r,
                                            color: Color(0xFFFF0092),
                                          )
                                        : null,
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4.r),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        item.url,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
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
}
