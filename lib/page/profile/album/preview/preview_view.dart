import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:newbug/page/profile/album/preview/widget/build_multiple_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/multiple_video/build_multiple_video.dart';
import 'package:newbug/page/profile/album/preview/widget/other.dart';
import 'package:newbug/page/profile/album/preview/widget/profile_private_album/profile_private_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_image_photo/build_single_image_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_private_photo/build_single_private_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_private_video/build_single_private_video.dart';
import 'package:newbug/page/profile/album/preview/widget/single_public_photo/build_single_public_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_sight_video/build_single_sight_video.dart';
import 'package:newbug/page/profile/album/preview/widget/single_sight_video/build_single_video.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewLogic>(
      init: PreviewLogic(),
      builder: (logic) {
        return buildBody(state: logic.viewType, logic: logic);
      },
    );
  }

  Widget buildBody({required int state, required PreviewLogic logic}) {
    return switch (state) {
      _ when state == PreviewViewType.singleImagePhoto.index =>
        BuildSingleImagePhoto(message: logic.imageMessage),
      _ when state == PreviewViewType.singlePublicPhoto.index =>
        BuildSinglePublicPhoto(url: logic.publicMessage?.data?.imageUrl ?? ""),
      _ when state == PreviewViewType.singlePrivatePhoto.index =>
        BuildSinglePrivatePhoto(
          url: logic.privatePhotoMessage?.data?.imageUrl ?? "",
        ),
      _ when state == PreviewViewType.singlePrivateVideo.index =>
        BuildSinglePrivateVideo(
          url: logic.privateVideoMessage?.data?.url ?? "",
          thumbUrl: logic.privateVideoMessage?.data?.thumbUrl ?? "",
        ),
      _ when state == PreviewViewType.singleSightVideo.index =>
        BuildSingleSightVideo(
          videoMessage: logic.videoMessage,
          isPrivate: false,
        ),
      _ when state == PreviewViewType.profilePrivateAlbum.index =>
        ProfilePrivatePhoto(media: logic.media),

      ///todo
      _ when state == PreviewViewType.multiplePhoto.index => BuildMultiplePhoto(
        isPrivate: true,
        urls: [
          "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
          "https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666",
          "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
        ],
      ),
      _ when state == PreviewViewType.singlePublicVideo.index => BuildSingleVideo(
        isPrivate: false,
        url:
            "https://szsl-normal.oss-cn-hangzhou.aliyuncs.com/%E9%A3%9E%E4%B9%A620250901-133635.mp4",
        thumb:
            "https://img0.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
      ),
      _ when state == PreviewViewType.singlePrivateVideo.index => BuildSingleVideo(
        isPrivate: true,
        url:
            "https://szsl-normal.oss-cn-hangzhou.aliyuncs.com/%E9%A3%9E%E4%B9%A620250901-133635.mp4",
        thumb:
            "https://img0.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
      ),
      _ when state == PreviewViewType.multipleVideo.index => BuildMultipleVideo(
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
      _ when state == PreviewViewType.other.index => OtherPage(),
      _ => SizedBox.shrink(),
    };
  }
}

//{"showAdd": true, "canSelect": true, "canSend": true}
// RouterBuilderHepler.openPrivateAlbumPage(context, showAdd: true, canSelect: false, canSend: false);
