part of 'index.dart';

class SexLogic extends GetxController {
  UserInfo? userInfo;

  ///处理错误数据
  int get sexuality => (userInfo?.user?.sexuality ?? 0) > 3
      ? 3
      : (userInfo?.user?.sexuality ?? 0);

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  void setData() {
    if (Get.arguments != null) {
      userInfo = Get.arguments as UserInfo;
      update();
    }
  }

  /// 修改性取向
  Future<void> toEditSexuality({required int sex}) async {
    CustomToast.loading();
    UserInfo? value = await AccountAPI.editInfo(step: 4, sexuality: sex)
        .whenComplete(() {
          CustomToast.dismiss();
        });
    if (value != null) {
      // AppStores.setTagsList(data:value.tagList??[]);
      AppStores.setUserInfo(value: value.user);
      RouteManager.toPhoto(userInfo: value);
    }
  }
}
