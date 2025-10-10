import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/subscribe/widget/swiper_item.dart';

class CommonMembershipWidget extends StatelessWidget {
  ///是否到期
  final bool isExpire;

  ///是否充值
  final bool isRecharge;

  const CommonMembershipWidget({
    super.key,
    required this.isExpire,
    required this.isRecharge,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFEE30),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(isRecharge ? 0 : 34.r),
              bottomRight: Radius.circular(isRecharge ? 0 : 34.r),
            ),
          ),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
          width: double.maxFinite,
          height: 330.h,
          constraints: BoxConstraints(minHeight: 320.h),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              PositionedDirectional(
                start: 0,
                top: 0,
                child: Image.asset(Assets.decorationKing, width: 280),
              ),
              PositionedDirectional(
                bottom: 0,
                start: 0,
                end: 0,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 240.h,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) =>
                        SwiperItem(index: index),
                    itemCount: 8,
                    autoplay: true,
                    autoplayDelay: 4500,
                    duration: 1000,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 10.h),
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.black,
                        color: Colors.black.withValues(alpha: 0.20),
                        size: 6,
                        activeSize: 6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isRecharge)
          Container(
            width: double.maxFinite,
            margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(34.r),
                bottomRight: Radius.circular(34.r),
              ),
              color: Color(0xFFFFF8AB),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    start: 10.w,
                    end: 10.w,
                    bottom: 12.h,
                  ),
                  width: double.maxFinite,
                  child: Text(
                    T.subscriptionRenewal.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Container(
                  width: double.maxFinite,
                  margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: T.renewal1.tr,
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.50),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.18,
                            letterSpacing: -0.30,
                          ),
                        ),
                        TextSpan(
                          text: isExpire
                              ? T.endsOn.trArgs(["August 15, 2024"])
                              : T.expireOn.trArgs(["August 15, 2024"]),
                          style: TextStyle(
                            color: const Color(0xFFFF0092),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.18,
                            letterSpacing: -0.30,
                          ),
                        ),
                        TextSpan(
                          text: T.renewal2.tr,
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.50),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.18,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
