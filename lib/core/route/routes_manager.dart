part of 'index.dart';

/// 路由管理
class RouteManager {
  static toName({UserEntity? user}) =>
      Get.toNamed(AppRoutes.name, arguments: user);

  static toBirth({UserInfo? userInfo}) =>
      Get.toNamed(AppRoutes.birth, arguments: userInfo);

  static toGender({UserInfo? userInfo}) =>
      Get.toNamed(AppRoutes.gender, arguments: userInfo);

  static toSex({UserInfo? userInfo}) =>
      Get.toNamed(AppRoutes.sex, arguments: userInfo);

  static toPhoto({UserInfo? userInfo}) =>
      Get.toNamed(AppRoutes.photo, arguments: userInfo);

  static toInterest({UserInfo? userInfo}) =>
      Get.toNamed(AppRoutes.interest, arguments: userInfo);

  static toEmailLogin() => Get.toNamed(AppRoutes.email);

  static toGuide() => Get.toNamed(AppRoutes.guide);

  static toVisitor({required bool isUserVip}) =>
      Get.toNamed(AppRoutes.visitor, arguments: {"isUserVip": isUserVip});

  static toUnmatch() => Get.toNamed(AppRoutes.unmatch);

  static toNotification() => Get.toNamed(AppRoutes.notification);

  static toEditProfile() => Get.toNamed(AppRoutes.editProfile);

  static toDeleteAccount() => Get.toNamed(AppRoutes.deleteAccount);

  static toPrivateAlbum() => Get.toNamed(AppRoutes.privateAlbum);

  static toSubscribe() => Get.toNamed(AppRoutes.subscribe);

  static toFlashChat({HomeCardsMatchList? value}) =>
      Get.toNamed(AppRoutes.flashChat, arguments: {"match": value});

  static toChat({String? targetId, UserEntity? userInfo}) {
    Map<String, dynamic> map = {};
    if (targetId != null) {
      map["targetId"] = targetId;
    }
    if (userInfo != null) {
      map["userInfo"] = userInfo;
    }
    Get.toNamed(AppRoutes.chat, arguments: map);
  }

  static toSelectedAlbum() => Get.toNamed(AppRoutes.selectedAlbum);

  static toPreviewView({int? viewId, dynamic data}) => Get.toNamed(
    AppRoutes.previewView,
    arguments: {"viewId": viewId, "data": data},
  );

  static towWebview({required String title, required String url}) =>
      Get.toNamed(AppRoutes.webview, arguments: {"title": title, "url": url});

  /// 关闭所有页面并跳转至登录页面
  static offAndToLogin() => Get.offAndToNamed(AppRoutes.login);

  /// 关闭所有页面并跳转至登录页面
  static offAllToLogin() => Get.offAllNamed(AppRoutes.login);

  static toLogin() => Get.toNamed(AppRoutes.login);

  ///正常进入主页
  static toCommonMain() => Get.toNamed(AppRoutes.main);

  static toMain() {
    if (AuthHelper.instance.isFinishGuide) {
      ///完成引导
      toCommonMain();
    } else {
      ///有引导页面
      toCommonMain();
      toGuide();
    }
  }
}
