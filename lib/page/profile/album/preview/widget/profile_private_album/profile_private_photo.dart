import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/album/preview/widget/base_preview/preview_image.dart';
import 'package:newbug/page/profile/album/preview/widget/profile_private_album/private_album_video_plus.dart';

class ProfilePrivatePhoto extends StatelessWidget {
  final MediaListItem? media;

  const ProfilePrivatePhoto({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    String localFilePath = AppStores.getThumb(key: media?.url ?? "");
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF504C43), Color(0xFF49443A)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.back(),
            child: UnconstrainedBox(
              child: Image.asset(
                Assets.imgToBack,
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsetsDirectional.only(end: 15.w),
              child: InkWell(
                onTap: () {
                  EventService.to.post(ProfilePrivateAlbumEvent(media: media));
                  Get.back();
                },
                child: Icon(Icons.delete_forever, color: Colors.white),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            if (!(media?.isVideo ?? false))
              PreviewImage(url: media?.url ?? "", type: ImageType.network),

            if ((media?.isVideo ?? false))
              PrivateAlbumVideoPlus(
                url: media?.url ?? "",
                //thumbUrl: media?.thumbUrl ?? "",
              ),
          ],
        ),
      ),
    );
  }
}
