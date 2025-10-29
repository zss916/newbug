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
          // AccountAPI.updateAdjust();

          // AccountAPI.config();

          /*HomeAPI.getHomeSwiperCards(tab: 1).then((value) {
            value.$2.first.nickName;
          });*/

          // AccountAPI.emailLogin(email: "12234566@qq.com", pwd: "12345678");
        },
        child: Image.asset(Assets.imgCamera, width: 34, height: 34),
      ),
    );
  }
}
