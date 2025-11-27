part of 'index.dart';

enum FormType { login, editProfile }

/// 路由管理
class RouteManager {
  static toName({FormType? form, UserEntity? user}) =>
      Get.toNamed(AppRoutes.name, arguments: {"form": form, "user": user});

  static toBirth({FormType? form, UserInfo? userInfo}) => Get.toNamed(
    AppRoutes.birth,
    arguments: {"form": form, "userInfo": userInfo},
  );

  static toGender({FormType? form, UserInfo? userInfo}) => Get.toNamed(
    AppRoutes.gender,
    arguments: {"form": form, "userInfo": userInfo},
  );

  static toSex({FormType? form, UserInfo? userInfo}) => Get.toNamed(
    AppRoutes.sex,
    arguments: {"form": form, "userInfo": userInfo},
  );

  static toPhoto({FormType? form, UserInfo? userInfo}) => Get.toNamed(
    AppRoutes.photo,
    arguments: {"form": form, "userInfo": userInfo},
  );

  static toInterest({FormType? form, EditType? subForm, UserInfo? userInfo}) =>
      Get.toNamed(
        AppRoutes.interest,
        arguments: {"form": form, "subForm": subForm, "userInfo": userInfo},
      );

  static toEmailLogin() => Get.toNamed(AppRoutes.email);

  static toGuide() => Get.toNamed(AppRoutes.guide);

  static toVisitor({required bool isUserVip}) =>
      Get.toNamed(AppRoutes.visitor, arguments: {"isUserVip": isUserVip});

  static toEditProfile({UserEntity? user}) {
    if (user != null) {
      Get.toNamed(AppRoutes.editProfile, arguments: {"user": user});
    }
  }

  static toOtherProfile({String? uid}) =>
      Get.toNamed(AppRoutes.otherProfile, arguments: {"uid": uid});

  static toUnmatch() => Get.toNamed(AppRoutes.unmatch);

  static toNotification() => Get.toNamed(AppRoutes.notification);

  static toDeleteAccount() => Get.toNamed(AppRoutes.deleteAccount);

  static toPrivateAlbum({
    required bool add,
    required bool select,
    required bool send,
  }) => Get.toNamed(
    AppRoutes.privateAlbum,
    arguments: {"add": add, "select": select, "send": send},
  );

  static toSubscribe() => Get.toNamed(AppRoutes.subscribe);

  static toFlashChat({HomeCardsMatchList? value}) =>
      Get.toNamed(AppRoutes.flashChat, arguments: {"match": value});

  static toChat({
    String? targetId,
    UserEntity? userInfo,
    ChatType chatType = ChatType.chat,
  }) {
    Map<String, dynamic> map = {};
    if (targetId != null) {
      map["targetId"] = targetId;
    }
    if (userInfo != null) {
      map["userInfo"] = userInfo;
    }
    map["chatType"] = chatType;
    Get.toNamed(AppRoutes.chat, arguments: map);
  }

  static Future<void> toSelectedAlbum({
    required List<MediaListItem?> videos,
    required List<MediaListItem?> images,
  }) async {
    await Get.toNamed(
      AppRoutes.selectedAlbum,
      arguments: {"selectVideos": videos, "selectImages": images},
    );
  }

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

  static offAndToMain() => Get.offAndToNamed(AppRoutes.main);

  static toMain() {
    if (AuthHelper.instance.isFinishGuide) {
      ///完成引导
      offAndToMain();
    } else {
      ///有引导页面
      offAndToMain();
      toGuide();
    }
  }
}
