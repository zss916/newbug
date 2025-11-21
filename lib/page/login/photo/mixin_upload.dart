import 'dart:io';

import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/upload_entity.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/core/network/utils/http_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin class MixinUpload {
  /// 上传
  Future<String?> toUpload({required File file}) async {
    UploadEntity? entity = await SystemAPI.upLoadUrl(file);
    String? url = await HttpTools.upload(
      path: entity?.uploadUrl ?? "",
      file: file,
      url: entity?.cdnUrl ?? "",
    );
    return url;
  }

  ///添加到私有相册
  Future<num?> addPrivate({
    required int type,
    required String url,
    int? duration,
  }) async {
    return await ProfileAPI.addPrivateImage(
      type: type,
      url: url,
      duration: duration,
    );
  }

  ///处理多个媒体
  Future<void> handMultipleMedia(List<AssetEntity> assets) async {
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

    List<MediaListItem?> data = mediaList.where((e) => e != null).toList();

    List<MediaListItem?> medias = await Future.wait(
      data.map((e) async {
        if (e?.type == 0) {
          File? compressImageFile = await GalleryTools.compressImageFilePlus(
            e!,
          );
          String? url = await toUpload(file: compressImageFile!);
          return (e..url = url);
        } else if (e?.type == 1) {
          File? compressVideoFile = await GalleryTools.compressVideoFilePlus(
            e!,
          );
          String? url = await toUpload(file: compressVideoFile!);
          return (e..url = url);
        }
      }),
    );
  }
}
