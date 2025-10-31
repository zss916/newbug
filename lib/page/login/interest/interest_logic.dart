part of 'index.dart';

class InterestLogic extends GetxController {
  UserInfo? userInfo;

  List<TagEntity> tags = [];

  bool get isSelectTag => tags.where((e) => e.isSelected == true).isNotEmpty;

  String? sign;

  bool get isSign => (sign ?? "").trim().isNotEmpty;

  bool get isCanContinue => isSelectTag || (sign ?? "").trim().isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  void setData() {
    if (Get.arguments != null) {
      userInfo = Get.arguments as UserInfo;
      List<String> userTags = userInfo?.user?.tags ?? [];
      if (userTags.isNotEmpty) {
        tags = (userInfo?.tagList ?? [])
            .map(
              (e) => userTags.contains(e.title ?? "")
                  ? (e..isSelected = true)
                  : (e..isSelected = false),
            )
            .toList();
      }
      sign = userInfo?.user?.sign;
      update();
    }
  }

  Future<void> toContinue() async {
    String tagIds = tags
        .where((element) => element.id != null)
        .where((element) => (element.isSelected ?? false))
        .map((e) => e.id)
        .toList()
        .join(",");

    CustomToast.loading();
    UserInfo? value =
        await AccountAPI.editInfo(
          step: 9,
          tag: isSelectTag ? tagIds : null,
          sign: sign,
        ).whenComplete(() {
          CustomToast.dismiss();
        });

    if (value != null) {
      RouteManager.toMain();
    }
  }
}
