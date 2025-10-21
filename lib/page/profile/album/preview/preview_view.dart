import 'package:flutter/material.dart';
import 'package:newbug/page/profile/album/preview/widget/build_multiple_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/build_single_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/multiple_video/build_multiple_video.dart';
import 'package:newbug/page/profile/album/preview/widget/single_video/build_single_video.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBody(state: 3);
  }

  Widget buildBody({required int state}) {
    return switch (state) {
      _ when state == 0 => BuildSinglePhoto(
        isPrivate: false,
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
            "https://szsl-normal.oss-cn-hangzhou.aliyuncs.com/%E9%A3%9E%E4%B9%A620250901-133635.mp4",
        thumb:
            "https://img0.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
      ),

      _ when state == 3 => BuildMultipleVideo(
        isPrivate: true,
        urls: [
          "https://szsl-normal.oss-cn-hangzhou.aliyuncs.com/%E9%A3%9E%E4%B9%A620250901-133635.mp4",
          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
          "https://wss3.emberer.com/users/awss3/251700337/upload/anchor/upload/video/6ea02d02d0dac53638021699d7c53af6.mp4",
        ],
        thumbs: [
          "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
          "https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666",
          "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
          "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
        ],
      ),

      _ => SizedBox.shrink(),
    };
  }
}
