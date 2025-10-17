import 'package:flutter/material.dart';
import 'package:newbug/page/profile/album/preview/widget/build_multiple_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/build_single_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/build_single_video.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBody(state: 2);
  }

  Widget buildBody({required int state}) {
    return switch (state) {
      _ when state == 0 => BuildSinglePhoto(
        isPrivate: true,
        url:
            "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
      ),
      _ when state == 1 => BuildMultiplePhoto(
        isPrivate: true,
        urls: [
          "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
          "https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666",
          "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
        ],
      ),
      _ when state == 2 => BuildSingleVideo(
        isPrivate: true,
        url:
            "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      ),

      _ => SizedBox.shrink(),
    };
  }
}
