part of 'index.dart';

class NameLogic extends GetxController {
  UserEntity? user;
  String get nickName => user?.nickName ?? "";

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  void setData() {
    if (Get.arguments != null) {
      user = Get.arguments as UserEntity;
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
