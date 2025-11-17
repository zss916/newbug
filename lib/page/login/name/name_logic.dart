part of 'index.dart';

class NameLogic extends GetxController {
  UserEntity? user;
  String get nickName => user?.nickName ?? "";
  FormType? type;

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  void setData() {
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      user = map['user'] as UserEntity?;
      type = map['form'] as FormType?;
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
      if (type == FormType.login) {
        RouteManager.toBirth(form: FormType.login, userInfo: value);
      } else if (type == FormType.editProfile) {
        EventService.to.post(RefreshUserEvent(user: value.user));
        Get.back();
      }
    }
  }
}
