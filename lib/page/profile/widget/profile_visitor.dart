import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class ProfileVisitor extends StatelessWidget {
  final String visitorsCount;
  const ProfileVisitor({super.key, required this.visitorsCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 19.h),
      padding: EdgeInsetsDirectional.all(16.r),
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 70.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    T.visitorsCountTr.trArgs([visitorsCount]),
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
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Container(
                width: 24.r,
                height: 24.r,
                margin: EdgeInsetsDirectional.only(end: 48.r - 12.r),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 24.r,
                height: 24.r,
                margin: EdgeInsetsDirectional.only(end: 24.r - 6.r),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 24.r,
                height: 24.r,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 4.w),
            child: Image.asset(Assets.imgToNext, width: 20, height: 20),
          ),
        ],
      ),
    );
  }
}
