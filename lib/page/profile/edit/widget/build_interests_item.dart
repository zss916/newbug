import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/home/index/widget/wrap_interest.dart';

class BuildInterestsItem extends StatelessWidget {
  final Function onTap;
  final List<String> data;
  const BuildInterestsItem({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(
            start: 14.w,
            end: 14.w,
            bottom: 16.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.interests.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 14.w,
            end: 14.w,
            bottom: 60.h,
          ),
          width: double.maxFinite,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onTap.call();
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withValues(alpha: 0.10),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: WrapInterest(interests: data)),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10.w),
                    child: Image.asset(
                      Assets.imgArrowEnd,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
