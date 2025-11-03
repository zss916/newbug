part of 'index.dart';

class GenderLogic extends GetxController {
  UserInfo? userInfo;
  int get gender => userInfo?.user?.sex ?? 0;

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

  /// 修改性别
  Future<void> toEditGender({required int sex}) async {
    CustomToast.loading();
    UserInfo? value = await AccountAPI.editInfo(step: 3, sex: sex).whenComplete(
      () {
        CustomToast.dismiss();
      },
    );
    if (value != null) {
      AppStores.setUserInfo(value: value.user);
      RouteManager.toSex(userInfo: value);
    }
  }
}
