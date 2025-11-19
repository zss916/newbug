import 'dart:io';

import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/photo/mixin_upload.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumLogic extends GetxController with MixinUpload {
  List<MediaListItem?> mediaList = [];

  int? lastId;

  late RefreshController refreshCtrl = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.canLoading,
  );

  @override
  void onInit() {
    super.onInit();
    CustomToast.loading();
  }

  @override
  void onReady() {
    super.onReady();
    lastId = null;
    loadPrivateList();
  }

  @override
  void onClose() {
    refreshCtrl.dispose();
    super.onClose();
  }

  Future<void> loadPrivateList() async {
    final (
      bool isSuccessful,
      List<MediaListItem> value,
    ) = await ProfileAPI.getPrivateAlbumList(
      from: 1,
      lastId: lastId,
    ).whenComplete(() => CustomToast.dismiss());
    if (isSuccessful) {
      if (lastId == null) {
        mediaList.assignAll(value);
      } else {
        mediaList.addAll(value);
      }
      if (mediaList.isNotEmpty) {
        lastId = mediaList.last?.id;
      }
      if (value.isEmpty) {
        refreshCtrl.loadNoData();
      } else {
        refreshCtrl.loadComplete();
      }
      update();
    }
  }

  ///添加私有照片
  Future<void> toAdd(List<AssetEntity> assets) async {
    List<MediaListItem?> medias = await Future.wait(
      assets.map((e) async {
        if (e.type == AssetType.image) {
          File? imageFile = await e.file;
          return MediaListItem()
            ..localFile = imageFile
            ..localFilePath = imageFile?.path ?? ""
            ..type = 0;
        } else if (e.type == AssetType.video) {
          File? videoFile = await e.file;
          String? thumbUrl = await GalleryTools.getVideoThumbnail(
            videoFile?.path ?? "",
          );
          return MediaListItem()
            ..localFile = videoFile
            ..localFilePath = videoFile?.path ?? ""
            ..thumbUrl = thumbUrl
            ..type = 1
            ..duration = e.duration;
        } else {
          return null;
        }
      }),
    );
    if (medias.isNotEmpty) {
      lastId = medias.first?.id;
      mediaList.insert(0, medias.first);
      update();
    }

    /* for (MediaListItem? value in medias) {
      if (value != null) {
        mediaList.add(value);
      }
    }*/

    //CustomToast.loading();
    /* List<MediaListItem?> data = mediaList.where((e) => e != null).toList();
    List<Map<String, dynamic>?> mediaListJson = await Future.wait(
      data.map((e) async {
        if (e?.type == 0) {
          File? compressImageFile = await GalleryTools.compressImageFilePlus(
            e!,
          );
          String? url = await toUpload(file: compressImageFile!);
          return (e..url = url).toJson();
        } else if (e?.type == 1) {
          File? compressVideoFile = await GalleryTools.compressVideoFilePlus(
            e!,
          );
          String? url = await toUpload(file: compressVideoFile!);
          return (e..url = url).toJson();
        }
      }),
    );
*/
    //num? id = await ProfileAPI.addPrivateImage(type: 0, url: "");
  }
}
