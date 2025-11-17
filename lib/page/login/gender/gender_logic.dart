part of 'index.dart';

class GenderLogic extends GetxController {
  UserInfo? userInfo;
  int get gender => userInfo?.user?.sex ?? 0;
  FormType? type;

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
      if (type == FormType.editProfile) {
        EventService.to.post(RefreshUserEvent(user: value.user));
        Get.back();
      } else if (type == FormType.login) {
        RouteManager.toSex(form: FormType.login, userInfo: value);
      }
    }
  }
}
