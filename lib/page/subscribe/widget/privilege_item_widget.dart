import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class PrivilegeItemWidget extends StatelessWidget {
  final int index;
  const PrivilegeItemWidget({super.key, required this.index});

  static const List<String> imgs = [
    Assets.subscribeIcLikes,
    Assets.subscribeIcLimits,
    Assets.subscribeIcVideos,
    Assets.subscribeIcPhotos,
    Assets.subscribeIcChat,
    Assets.subscribeIcAlbum,
    Assets.subscribeIcVisitors,
  ];

  static List<String> get titles => [
    T.privilege1.tr,
    T.privilege2.tr,
    T.privilege3.tr,
    T.privilege4.tr,
    T.privilege5.tr,
    T.privilege6.tr,
    T.privilege7.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(end: 5.w),
          child: Image.asset(imgs[index], width: 18, height: 18),
        ),
        Text(
          titles[index],
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
