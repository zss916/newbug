part of 'index.dart';

class NameLogic extends GetxController {
  AuthEntity? auth;
  String get nickName => auth?.nickName ?? "";

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  void setData() {
    if (Get.arguments != null) {
      auth = Get.arguments as AuthEntity;
      update();
    }
  }

  /// 修改昵称
  Future<void> toEditName({required String nickName}) async {
    CustomToast.loading();
    UserInfo? value = await AccountAPI.editInfo(step: 1, nickName: nickName)
        .whenComplete(() {
          CustomToast.dismiss();
        });
    if (value != null) {
      AppStores.setUserInfo(value: value.user);
      RouteManager.toBirth(userInfo: value);
    }
  }
}
