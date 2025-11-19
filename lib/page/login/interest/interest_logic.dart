part of 'index.dart';

enum EditType { editSign, editInterests }

class InterestLogic extends GetxController {
  UserInfo? userInfo;
  FormType? type;
  EditType? subType;

  ///common 0, loading 1,empty 2
  int viewStatus = 0;

  List<TagEntity> tags = [];

  bool get isSelectTag => tags.where((e) => e.isSelected == true).isNotEmpty;

  String? sign;

  bool get isSign => (sign ?? "").trim().isNotEmpty;

  bool get isCanContinue => isSelectTag || (sign ?? "").trim().isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    setData();
    setView(1);
  }

  setView(int status) {
    if ((type == FormType.editProfile) &&
        (subType == EditType.editInterests && tags.isEmpty)) {
      viewStatus = status;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    if ((type == FormType.editProfile) &&
        (subType == EditType.editInterests) &&
        tags.isEmpty) {
      loadInterests();
    }
  }

  void setData() {
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      userInfo = map['userInfo'] as UserInfo?;
      type = map['form'] as FormType?;
      subType = map['subForm'] as EditType?;
      List<String> userTags = userInfo?.user?.tags ?? [];
      if (userTags.isNotEmpty) {
        tags = _handSelectTag((userInfo?.tagList ?? []), userTags);
      } else {
        tags = (userInfo?.tagList ?? []);
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
      AppStores.setUserInfo(value: value.user);
      if (type == FormType.editProfile) {
        EventService.to.post(RefreshUserEvent(user: value.user));
        Get.back();
      } else if (type == FormType.login) {
        RouteManager.toMain();
      }
    }
  }

  void toSkip() {
    RouteManager.toMain();
  }

  ///获取兴趣列表
  Future<void> loadInterests() async {
    final (bool isSuccessful, List<TagEntity> value) =
        await ProfileAPI.getTagList(type: 0);
    if (isSuccessful) {
      List<String> userTags = userInfo?.user?.tags ?? [];
      if (userTags.isNotEmpty) {
        List<TagEntity> tagList = _handSelectTag(value, userTags);
        tags.assignAll(tagList);
      } else {
        tags.assignAll(value);
      }
      viewStatus = tags.isEmpty ? 2 : 0;
      update();
    }
  }

  List<TagEntity> _handSelectTag(
    List<TagEntity> value,
    List<String> selectTags,
  ) {
    List<TagEntity> tagList = value
        .map(
          (e) => selectTags.contains(e.title ?? "")
              ? (e..isSelected = true)
              : (e..isSelected = false),
        )
        .toList();
    return tagList;
  }
}
