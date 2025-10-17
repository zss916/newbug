import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/profile/album/selected/widget/build_item_widget.dart';
import 'package:newbug/page/profile/album/selected/widget/build_top_title.dart';

class BuildVideosWidget extends StatelessWidget {
  const BuildVideosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTopTitle(title: T.selectedVideoTitle.trArgs(["5"])),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            childAspectRatio: 113 / 150,
          ),
          itemBuilder: (context, index) {
            return BuildItemWidget(isVideo: true);
          },
        ),
      ],
    );
  }
}
