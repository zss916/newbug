import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/like/widget/like_avatar.dart';
import 'package:newbug/page/like/widget/like_blur_widget.dart';
import 'package:newbug/page/like/widget/like_left.dart';
import 'package:newbug/page/like/widget/like_new_label.dart';

class LikedItem extends StatelessWidget {
  final int index;
  const LikedItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 144 / 192,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
            ),
            fit: BoxFit.cover,
          ),
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
            topRight: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
            bottomLeft: index == 0
                ? Radius.circular(22.r)
                : Radius.circular(8.r),
            bottomRight: index == 0
                ? Radius.circular(59.r)
                : Radius.circular(8.r),
          ),
        ),
        height: double.maxFinite,
        child: LikeBlurWidget(
          isBlur: index == 0,
          index: index,
          child: index == 0 ? buildFirstItem() : buildOtherItem(),
        ),
      ),
    );
  }

  Widget buildFirstItem() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LikeAvatar(),
      LikeNewLabel(margin: EdgeInsetsDirectional.only(top: 6.h)),
      Container(
        margin: EdgeInsetsDirectional.only(top: 4.h),
        width: double.maxFinite,
        child: Text(
          'Amanda,29',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Container(
        margin: EdgeInsetsDirectional.only(top: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        decoration: ShapeDecoration(
          color: const Color(0xFFF7DEF9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.80,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.imgLocation, width: 11.r, height: 11.r),
            Text(
              'New York',
              style: TextStyle(
                color: const Color(0xFF7D60FF),
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      Spacer(),
      LikeLeft(),
    ],
  );

  Widget buildOtherItem() => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [LikeNewLabel()],
  );
}
