import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:newbug/core/widget/app_blur_widget.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/home/index/widget/lose_touch.dart';
import 'package:newbug/page/home/index/widget/no_action.dart';
import 'package:newbug/page/home/index/widget/video/better_net_video.dart';

class SwiperAndPlayWidget extends StatefulWidget {
  final List<String> items;
  const SwiperAndPlayWidget({super.key, required this.items});

  @override
  State<SwiperAndPlayWidget> createState() => _SwiperAndPlayWidgetState();
}

class _SwiperAndPlayWidgetState extends State<SwiperAndPlayWidget> {
  late final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final SwiperController swiperController = SwiperController();

  @override
  void dispose() {
    super.dispose();
    selectedIndex.dispose();
    swiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double ratio = constraints.maxWidth / constraints.maxHeight;
            return Swiper(
              controller: swiperController,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  key: ValueKey(widget.items[index]),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: widget.items[index].contains(".mp4")
                        ? null
                        : DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              widget.items[index],
                            ),
                          ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (widget.items[index].contains(".mp4"))
                        BetterNetVideo(
                          video: widget.items[index],
                          ratio: ratio,
                          onVideoStatus: (isPlaying) {
                            if (isPlaying) {
                              setState(() {
                                swiperController.stopAutoplay();
                              });
                            }
                          },
                        ),
                    ],
                  ),
                );
              },
              itemCount: widget.items.length,
              autoplay: false,
              autoplayDelay: 4500,
              duration: 1000,
              onIndexChanged: (index) {
                selectedIndex.value = index;
              },
            );
          },
        ),

        buildStatus(-1),

        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          child: Container(
            margin: EdgeInsetsDirectional.only(
              start: 30.w,
              end: 30.w,
              top: 20.h,
            ),
            width: double.maxFinite,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final len = widget.items.length;
                final screenWidth = MediaQuery.of(context).size.width;
                double itemWidth =
                    (screenWidth - 28.w - 60.w - ((len - 1) * 4.w)) / len;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(widget.items.length, (index) {
                    return ValueListenableBuilder<int>(
                      builder: (context, value, child) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: itemWidth,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: value == index
                                ? Colors.white
                                : Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                      valueListenable: selectedIndex,
                    );
                  }),
                );
              },
            ),
          ),
        ),

        ///isBlur
        AppBlurWidget(
          isBlur: false,
          sigma: 25,
          foreground: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.imgWildPhotoIc, width: 56, height: 56),
                Divider(height: 18.h, color: Colors.transparent),
                Text(
                  'Wild Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStatus(int status) {
    return switch (status) {
      _ when status == 0 => LoseTouch(),
      _ when status == 1 => NotAction(),
      _ => SizedBox.shrink(),
    };
  }
}
