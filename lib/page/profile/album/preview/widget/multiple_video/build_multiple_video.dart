import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:newbug/page/profile/album/preview/widget/multiple_video/preview_multiple_video.dart';

class BuildMultipleVideo extends StatefulWidget {
  final List<String> urls;
  final Function? onFinished;
  final bool? isPrivate;
  final List<String>? thumbs;

  const BuildMultipleVideo({
    super.key,
    required this.urls,
    this.onFinished,
    this.isPrivate,
    this.thumbs,
  });

  @override
  State<BuildMultipleVideo> createState() => _BuildMultipleVideoState();
}

class _BuildMultipleVideoState extends State<BuildMultipleVideo> {
  final PageController controller = PageController();

  int currentIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      for (var item in widget.urls)
                        PreviewMultipleVideo(
                          url: item,
                          child: SizedBox(height: 64.h),
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
                        itemCount: (widget.thumbs ?? []).length,
                        itemBuilder: (context, index) {
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
                                    borderRadius: BorderRadius.circular(4.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        (widget.thumbs ?? [])[index],
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
            if (widget.isPrivate == true)
              Container(
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
                    // onFinished?.call();
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
