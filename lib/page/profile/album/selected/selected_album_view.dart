import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/profile/album/selected/widget/build_photos_widget.dart';
import 'package:newbug/page/profile/album/selected/widget/build_videos_widget.dart';

class SelectedAlbumView extends StatelessWidget {
  const SelectedAlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.selectedAlbumTitle.tr),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BuildPhotosWidget(),
                  Divider(height: 6.h, color: Colors.transparent),
                  BuildVideosWidget(),
                  Divider(height: 10.h, color: Colors.transparent),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              ///
            },
            child: Container(
              width: double.maxFinite,
              height: 48.h,
              margin: EdgeInsetsDirectional.only(
                start: 40.w,
                end: 40.w,
                bottom: 20.h,
                top: 10.h,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: ShapeDecoration(
                color: const Color(0xFFFF0092),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(63),
                ),
              ),
              child: Text(
                T.confirm.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopTip({required String title}) => Container(
    margin: EdgeInsetsDirectional.only(
      top: 10.h,
      bottom: 14.h,
      start: 10.w,
      end: 10.w,
    ),
    width: double.maxFinite,
    child: UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color: const Color(0xFFF0EDFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
