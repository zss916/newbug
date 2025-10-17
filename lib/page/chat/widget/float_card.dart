import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:newbug/core/config/translation/index.dart';

class FloatCard extends StatelessWidget {
  const FloatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 22.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF7DEF9),
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(end: 8.w),
              decoration: BoxDecoration(
                color: Colors.white54,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
                  ),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              width: 32.r,
              height: 32.r,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    T.videosOrPhotos.trArgs(["(1/1)"]),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    T.desiresRunWild.tr,
                    style: TextStyle(
                      color: const Color(0xFF9C9C9C),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 5.w),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFF7D60FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                T.check.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
