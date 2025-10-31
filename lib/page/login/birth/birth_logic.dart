part of 'index.dart';

class BirthLogic extends GetxController {
  UserInfo? userInfo;
  DateTime? get birthDateTime => userInfo?.user?.brithValue;

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

  /// 修改年龄
  Future<void> toEditAge({required String birthday}) async {
    CustomToast.loading();
    UserInfo? value = await AccountAPI.editInfo(step: 2, birthday: birthday)
        .whenComplete(() {
          CustomToast.dismiss();
        });

    if (value != null) {
      RouteManager.toGender(userInfo: value);
    }
  }
}
