part of 'index.dart';

class SexLogic extends GetxController {
  UserInfo? userInfo;

  ///处理错误数据
  int get sexuality => (userInfo?.user?.sexuality ?? 0) > 3
      ? 3
      : (userInfo?.user?.sexuality ?? 0);

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
      if (type == FormType.editProfile) {
        EventService.to.post(RefreshUserEvent(user: value.user));
        Get.back();
      } else if (type == FormType.login) {
        RouteManager.toPhoto(form: FormType.login, userInfo: value);
      }
    }
  }
}
