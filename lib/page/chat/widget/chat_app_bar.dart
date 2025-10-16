import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/generated/assets.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 4.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: 12.w,
                    horizontal: 10.h,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(Assets.imgToBack, width: 24.r, height: 24.r),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(end: 10.w),
            padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
                      ),
                    ),
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                if (true)
                  PositionedDirectional(
                    top: 1,
                    end: 1,
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: Color(0xFF18CD00),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amanda,29',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Assets.imgLocation, width: 14.r, height: 14.r),
                    Text(
                      'Columbusddd',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF7D60FF),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 10.w, end: 4.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  ///
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: 12.h,
                    horizontal: 10.w,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(Assets.imgMore, width: 24.r, height: 24.r),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
