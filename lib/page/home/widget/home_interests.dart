import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/home/widget/wrap_interest.dart';

class HomeInterests extends StatelessWidget {
  const HomeInterests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 16.h),
          child: Text(
            T.interests.tr,
            style: TextStyle(
              color: const Color(0xFF303133),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 8.h),
          child: WrapInterest(
            interests: [
              "ddddddd",
              "dsafdsaf",
              "dsf",
              "dsfdsafdsafsad",
              "sdfdsa",
            ],
          ),
        ),
      ],
    );
  }
}
