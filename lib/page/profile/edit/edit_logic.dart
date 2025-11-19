import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/model/user_info.dart';
import 'package:newbug/core/network/reopsitory/account.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/photo/mixin_upload.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EditLogic extends GetxController with MixinUpload {
  UserEntity? user;
  List<String> get tags => user?.tags ?? [];
  String get nickName => user?.nickName ?? "N/A";
  String get gender => user?.toGender ?? "N/A";
  String get birthday => user?.showBirthday ?? "N/A";
  String get sexual => user?.toSexual ?? "N/A";
  String get sign => user?.sign ?? "";

  ///显示的数据
  List<MediaListItem?> medias = [null, null, null, null, null, null];

  StreamSubscription<RefreshUserEvent>? refreshUserSubs;

  @override
  void onClose() {
    super.onClose();
    refreshUserSubs?.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      user = map["user"] as UserEntity?;
      if ((user?.mediaList ?? []).isNotEmpty) {
        for (int i = 0; i < (user?.mediaList ?? []).length; i++) {
          medias[i] = (user?.mediaList ?? [])[i];
        }
      }
    }
    refreshUserSubs = EventService.to.listen<RefreshUserEvent>((event) {
      user = event.user;
      update();
    });
  }

  /// 添加
  Future<void> onAdd(int index) async {
    List<AssetEntity> assets = await GalleryTools.openGallery(
      context: Get.context!,
      maxAssets: index == 0 ? 1 : 1,
      type: index == 0 ? RequestType.image : RequestType.common,
    );

    if (assets.isEmpty) {
      debugPrint("没有选择，操作取消");
      return;
    }

    List<MediaListItem?> mediaList = await Future.wait(
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
            ..thumbUrl = thumbUrl
            ..type = 1;
        } else {
          return null;
        }
      }),
    );
    medias[index] = mediaList.first;
    update();
    toEditMedia();
  }

  ///编辑照片或视频
  Future<void> toEditMedia() async {
    CustomToast.loading();
    List<MediaListItem?> data = medias
        .where((e) => e != null)
        .where(
          (e) =>
              File(e?.localFile?.path ?? "").existsSync() || (e?.url != null),
        )
        .toList();
    //debugPrint("data:${data.length}");
    List<Map<String, dynamic>?> mediaListJson = await Future.wait(
      data.map((e) async {
        if (e?.type == 0) {
          // debugPrint("file : ${File(e?.localFile?.path ?? "").existsSync()}
          if ((e?.url ?? "").isNotEmpty) {
            return e?.toJson();
          } else {
            if (File(e?.localFile?.path ?? "").existsSync()) {
              File? compressImageFile =
                  await GalleryTools.compressImageFilePlus(e!);
              // debugPrint("compressImageFile : ${File(compressImageFile?.path ?? "").existsSync()}",);
              String? url = await toUpload(file: compressImageFile!);
              return (e..url = url).toJson();
            } else {
              return e?.toJson();
            }
          }
        } else if (e?.type == 1) {
          if ((e?.url ?? "").isNotEmpty) {
            return e?.toJson();
          } else {
            if (File(e?.localFile?.path ?? "").existsSync()) {
              File? compressVideoFile =
                  await GalleryTools.compressVideoFilePlus(e!);
              String? url = await toUpload(file: compressVideoFile!);
              return (e..url = url).toJson();
            } else {
              return e?.toJson();
            }
          }
        } else {
          return e?.toJson();
        }
      }),
    );

    ///压缩图片和视频上传
    UserInfo? value =
        await AccountAPI.editInfo(
          step: 7,
          mediaList: jsonEncode(mediaListJson),
        ).whenComplete(() {
          CustomToast.dismiss();
        });
    if (value != null) {
      AppStores.setUserInfo(value: value.user);
      EventService.to.post(RefreshUserEvent(user: value.user));
    }
  }
}
