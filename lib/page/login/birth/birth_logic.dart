part of 'index.dart';

class BirthLogic extends GetxController {
  UserInfo? userInfo;
  DateTime? get birthDateTime => userInfo?.user?.brithValue;
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

  /// 修改年龄
  Future<void> toEditAge({required String birthday}) async {
    CustomToast.loading();
    UserInfo? value = await AccountAPI.editInfo(step: 2, birthday: birthday)
        .whenComplete(() {
          CustomToast.dismiss();
        });

    if (value != null) {
      AppStores.setUserInfo(value: value.user);
      if (type == FormType.editProfile) {
        EventService.to.post(RefreshUserEvent(user: value.user));
        Get.back();
      } else if (type == FormType.login) {
        RouteManager.toGender(form: FormType.login, userInfo: value);
      }
    }
  }
}
