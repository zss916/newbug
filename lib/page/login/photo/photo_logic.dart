part of 'index.dart';

class PhotoLogic extends GetxController with MixinUpload {
  UserInfo? userInfo;
  FormType? type;
  UserEntity? get user => userInfo?.user;

  List<MediaListItem?> selectList = [null, null, null, null, null, null];

  bool get isCanUpload => selectList.where((e) => e != null).isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  void setData() {
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      userInfo = map['userInfo'] as UserInfo?;
      type = map['form'] as FormType?;
      update();
    }
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
    selectList[index] = mediaList.first;
    update();
  }

  /// 编辑
  Future<void> onEdit(int index, {List<MediaListItem?>? selectList}) async {}

  ///编辑照片或视频
  Future<void> toEditMedia() async {
    ///测试20s
    debugPrint("toEditMedia start:${DateTime.now().timeFormatted}");

    CustomToast.loading();
    List<MediaListItem?> data = selectList.where((e) => e != null).toList();
    List<Map<String, dynamic>?> mediaListJson =
        await Future.wait(
          data.map((e) async {
            if (e?.type == 0) {
              File? compressImageFile =
                  await GalleryTools.compressImageFilePlus(e!);
              String? url = await toUpload(file: compressImageFile!);
              return (e..url = url).toJson();
            } else if (e?.type == 1) {
              File? compressVideoFile =
                  await GalleryTools.compressVideoFilePlus(e!);
              String? url = await toUpload(file: compressVideoFile!);
              return (e..url = url).toJson();
            }
          }),
        ).whenComplete(() {
          // CustomToast.dismiss();
        });

    /* List<String?> urls =
        await Future.wait(
          data.map((e) async {
            UploadEntity? entity = await SystemAPI.upLoadUrl(e!.localFile!);
            String? url = await HttpTools.upload(
              path: entity?.uploadUrl ?? "",
              file: e.localFile!,
              url: entity?.cdnUrl ?? "",
            );
            return url;
          }),
        ).whenComplete(() {
          CustomToast.dismiss();
        });*/
    debugPrint("toEditMedia data:${mediaListJson.toString()}");
    debugPrint("toEditMedia end:${DateTime.now().timeFormatted}");

    ///压缩图片和视频上传
    UserInfo? value =
        await AccountAPI.editInfo(
          step: 7,
          mediaList: jsonEncode(mediaListJson),
        ).whenComplete(() {
          CustomToast.dismiss();
          debugPrint("toEditMedia finish:${DateTime.now().timeFormatted}");
        });
    if (value != null) {
      value.tagList = userInfo?.tagList ?? [];
      AppStores.setUserInfo(value: value.user);
      RouteManager.toInterest(form: FormType.login, userInfo: value);
    }
  }

  void toNext() {
    RouteManager.toInterest(form: FormType.login, userInfo: userInfo);
  }
}
