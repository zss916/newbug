import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/im/utils/im_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/photo/mixin_upload.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumLogic extends GetxController with MixinUpload {
  List<MediaListItem?> mediaList = [];

  int? lastId;

  bool add = true;
  bool select = false;
  bool send = false;

  List<MediaListItem?> selectVideos = [];
  List<MediaListItem?> selectImages = [];

  late RefreshController refreshCtrl = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.canLoading,
  );

  StreamSubscription<ProfilePrivateAlbumEvent>? subs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      add = map['add'];
      select = map['select'];
      send = map['send'];
    }
    subs = EventService.to.listen<ProfilePrivateAlbumEvent>((event) {
      if (mediaList.isNotEmpty) {
        toRemove(event.media);
      }
    });

    if (lastId == null) {
      CustomToast.loading();
    }
  }

  @override
  void onReady() {
    super.onReady();
    lastId = null;
    loadPrivateList();
  }

  @override
  void onClose() {
    subs?.cancel();
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
  }

  ///删除私有图片
  Future<void> toRemove(MediaListItem? media) async {
    CustomToast.loading();
    bool isSuccessful = await ProfileAPI.deletePrivateMedia(
      id: media?.id ?? 0,
    ).whenComplete(() => CustomToast.dismiss());
    if (isSuccessful) {
      mediaList.remove(media);
      update();
    }
  }

  ///过滤数据
  void toFilter() {
    List<MediaListItem?> videos = mediaList
        .where((e) => e?.isChecked == true && e?.isVideo == true)
        .toList();
    selectVideos.assignAll(videos);
    List<MediaListItem?> images = mediaList
        .where((e) => e?.isChecked == true && e?.isVideo == false)
        .toList();
    selectImages.assignAll(images);
    update();
  }

  ///确认
  void toConfirm() {
    toFilter();
    if ((selectVideos.length + selectImages.length) == 1) {
      if (selectImages.length == 1) {
        String content = jsonEncode(selectImages.first);
        EventService.to.post(SendPrivateSingleMsgEvent(content: content));
        Get.back();
      }

      if (selectVideos.length == 1) {
        String content = jsonEncode(selectVideos.first);
        EventService.to.post(SendPrivateSingleMsgEvent(content: content));
        Get.back();
      }
    } else {
      //todo
      RouteManager.toSelectedAlbum(
        videos: selectVideos,
        images: selectImages,
      ).then((_) {
        toFilter();
      });
    }
  }
}
