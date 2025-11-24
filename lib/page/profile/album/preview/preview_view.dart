import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/route/observer/routes_extend.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:newbug/page/profile/album/preview/widget/multipe_photo/build_multiple_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/multiple_video/build_multiple_video.dart';
import 'package:newbug/page/profile/album/preview/widget/other.dart';
import 'package:newbug/page/profile/album/preview/widget/profile_private_album/profile_private_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_image_photo/build_single_image_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_private_photo/build_single_private_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_private_video/build_single_private_video.dart';
import 'package:newbug/page/profile/album/preview/widget/single_public_photo/build_single_public_photo.dart';
import 'package:newbug/page/profile/album/preview/widget/single_sight_video/build_single_sight_video.dart';

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
          countDown: logic.countDown,
          onFinished: () {
            Get.removeName(AppRoutes.previewView);
          },
        ),
      _ when state == PreviewViewType.singlePrivateVideo.index =>
        BuildSinglePrivateVideo(
          url: logic.privateVideoMessage?.data?.url ?? "",
          thumbUrl: logic.privateVideoMessage?.data?.thumbUrl ?? "",
          countDown: logic.countDown,
          onFinished: () {
            Get.removeName(AppRoutes.previewView);
          },
        ),
      _ when state == PreviewViewType.singleSightVideo.index =>
        BuildSingleSightVideo(
          videoMessage: logic.videoMessage,
          isPrivate: false,
        ),
      _ when state == PreviewViewType.profilePrivateAlbum.index =>
        ProfilePrivatePhoto(media: logic.media),

      _ when state == PreviewViewType.multiplePhoto.index => BuildMultiplePhoto(
        data: logic.privatePackageMessage?.data,
      ),
      _ when state == PreviewViewType.multipleVideo.index => BuildMultipleVideo(
        data: logic.privatePackageMessage?.data,
      ),

      ///todo
      /*      _ when state == PreviewViewType.singlePublicVideo.index => BuildSingleVideo(
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
      ),*/
      _ when state == PreviewViewType.other.index => OtherPage(),
      _ => SizedBox.shrink(),
    };
  }
}

//{"showAdd": true, "canSelect": true, "canSend": true}
// RouterBuilderHepler.openPrivateAlbumPage(context, showAdd: true, canSelect: false, canSend: false);
