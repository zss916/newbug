import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class BuildSubscribeAvatar extends StatelessWidget {
  const BuildSubscribeAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 56.r,
          height: 56.r,
          margin: EdgeInsetsDirectional.all(0),
          decoration: BoxDecoration(
            color: Colors.white70,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
              ),
            ),
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(56.r),
          ),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: Image.asset(Assets.imgDotOnline, width: 12, height: 12),
        ),
        PositionedDirectional(
          bottom: 0,
          start: 0,
          child: Image.asset(
            Assets.imgSubscribeLocation,
            width: 17,
            height: 17,
          ),
        ),
      ],
    );
  }
}
