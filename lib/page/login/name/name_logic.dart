part of 'index.dart';

class NameLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      UserEntity value = Get.arguments as UserEntity;
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
      RouteManager.toBirth();
    }
  }
}
