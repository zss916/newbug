import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class BuildItemWidget extends StatefulWidget {
  final bool isVideo;
  const BuildItemWidget({super.key, required this.isVideo});

  @override
  State<BuildItemWidget> createState() => _BuildItemWidgetState();
}

class _BuildItemWidgetState extends State<BuildItemWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          image: const DecorationImage(
            image: CachedNetworkImageProvider(
              "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PositionedDirectional(
              top: 6.r,
              end: 6.r,
              child: Image.asset(
                isChecked ? Assets.imgCheckedIcon : Assets.imgUncheckIcon,
                width: 24,
                height: 24,
              ),
            ),
            if (widget.isVideo)
              PositionedDirectional(
                top: 6.r,
                start: 6.r,
                child: Image.asset(
                  Assets.imgIcVideo,
                  width: 32.w,
                  height: 29.h,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
