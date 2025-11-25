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
        BuildSingleImagePhoto(message: logic.imageMsg),
      _ when state == PreviewViewType.singlePublicPhoto.index =>
        BuildSinglePublicPhoto(url: logic.publicMsg?.data?.url ?? ""),
      _ when state == PreviewViewType.singlePublicVideo.index =>
        BuildSinglePrivateVideo(
          url: logic.publicMsg?.data?.url ?? "",
          thumbUrl: logic.publicMsg?.data?.thumbUrl ?? "",
        ),
      _ when state == PreviewViewType.singlePrivatePhoto.index =>
        BuildSinglePrivatePhoto(
          url: logic.privateMsg?.data?.url ?? "",
          countDown: logic.countDown,
          onFinished: () {
            Get.removeName(AppRoutes.previewView);
          },
        ),
      _ when state == PreviewViewType.singlePrivateVideo.index =>
        BuildSinglePrivateVideo(
          url: logic.privateMsg?.data?.url ?? "",
          thumbUrl: logic.privateMsg?.data?.thumbUrl ?? "",
          countDown: logic.countDown,
          onFinished: () {
            Get.removeName(AppRoutes.previewView);
          },
        ),
      _ when state == PreviewViewType.singleSightVideo.index =>
        BuildSingleSightVideo(videoMessage: logic.videoMsg, isPrivate: false),
      _ when state == PreviewViewType.profilePrivateAlbum.index =>
        ProfilePrivatePhoto(media: logic.media),

      _ when state == PreviewViewType.multiplePhoto.index => BuildMultiplePhoto(
        countDown: logic.countDown,
        data: logic.privatePkgMsg?.data,
        onFinished: () {
          Get.removeName(AppRoutes.previewView);
        },
      ),
      _ when state == PreviewViewType.multipleVideo.index => BuildMultipleVideo(
        countDown: logic.countDown,
        data: logic.privatePkgMsg?.data,
        onFinished: () {
          Get.removeName(AppRoutes.previewView);
        },
      ),
      _ when state == PreviewViewType.other.index => OtherPage(),
      _ => SizedBox.shrink(),
    };
  }
}
