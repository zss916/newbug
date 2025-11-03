import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';

class ProfileVisitor extends StatelessWidget {
  final int visitorsCount;
  final int visitorTotalCount;
  final List<String> list;
  final bool isBlur;
  const ProfileVisitor({
    super.key,
    required this.visitorsCount,
    required this.visitorTotalCount,
    required this.list,
    required this.isBlur,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RouteManager.toVisitor(isUserVip: !isBlur);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 19.h),
        padding: EdgeInsetsDirectional.all(16.r),
        width: double.maxFinite,
        constraints: BoxConstraints(minHeight: 70.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Color(0xFF7E61FF)),
                borderRadius: BorderRadius.circular(40),
              ),
              margin: EdgeInsetsDirectional.only(end: 10.w),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(Assets.imgVisitors, width: 22, height: 22),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      T.visitedTitle.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (visitorsCount <= 0)
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        visitorsCount == 0
                            ? T.visitorsTotal.trArgs(["$visitorTotalCount"])
                            : T.visitorsCountTr.trArgs(["$visitorsCount"]),
                        style: TextStyle(
                          color: const Color(0xFF8C8C8C),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            VerticalDivider(width: 5.w, color: Colors.transparent),
            buildStackAvatar(isBlur: isBlur, data: list),
            Container(
              margin: EdgeInsetsDirectional.only(start: 4.w),
              child: Image.asset(Assets.imgToNext, width: 20, height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStackAvatar({required bool isBlur, required List<String> data}) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        if (data.length >= 3)
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              blurAvatar(
                isBlur: isBlur,
                url: data[2],
                margin: EdgeInsetsDirectional.only(end: 48.r - 12.r),
              ),

              blurAvatar(
                isBlur: isBlur,
                url: data[1],
                margin: EdgeInsetsDirectional.only(end: 24.r - 6.r),
              ),
              blurAvatar(isBlur: isBlur, url: data.first),
            ],
          ),
        if (data.length >= 2)
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              blurAvatar(
                isBlur: isBlur,
                url: data[1],
                margin: EdgeInsetsDirectional.only(end: 24.r - 6.r),
              ),
              blurAvatar(isBlur: isBlur, url: data.first),
            ],
          ),

        if (data.length == 1) blurAvatar(isBlur: isBlur, url: data.first),
      ],
    );
  }

  Widget blurAvatar({
    required bool isBlur,
    required String url,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      width: 24.r,
      height: 24.r,
      margin: margin ?? EdgeInsetsDirectional.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: isBlur ? 5 : 0,
                  sigmaY: isBlur ? 5 : 0,
                ),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
