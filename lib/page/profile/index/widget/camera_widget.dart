import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 16.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          //todo
        },
        child: Image.asset(Assets.imgCamera, width: 34, height: 34),
      ),
    );
  }
}
