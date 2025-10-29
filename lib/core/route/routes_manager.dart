part of 'index.dart';

/// 路由管理
class RouteManager {
  static toName({UserEntity? user}) =>
      Get.toNamed(AppRoutes.name, arguments: user);

  static toEmailLogin() => Get.toNamed(AppRoutes.email);

  static toSex() => Get.toNamed(AppRoutes.sex);

  static toGender() => Get.toNamed(AppRoutes.gender);

  static toPhoto() => Get.toNamed(AppRoutes.photo);

  static toInterest() => Get.toNamed(AppRoutes.interest);

  static toBirth() => Get.toNamed(AppRoutes.birth);

  static toGuide() => Get.toNamed(AppRoutes.guide);

  static toMain() => Get.toNamed(AppRoutes.main);

  static toVisitor() => Get.toNamed(AppRoutes.visitor);

  static toUnmatch() => Get.toNamed(AppRoutes.unmatch);

  static toNotification() => Get.toNamed(AppRoutes.notification);

  static toEditProfile() => Get.toNamed(AppRoutes.editProfile);

  static toDeleteAccount() => Get.toNamed(AppRoutes.deleteAccount);

  static toPrivateAlbum() => Get.toNamed(AppRoutes.privateAlbum);

  static toSubscribe() => Get.toNamed(AppRoutes.subscribe);

  static toHomeDetail() => Get.toNamed(AppRoutes.homeDetail);

  static toChat() => Get.toNamed(AppRoutes.chat);

  static toSelectedAlbum() => Get.toNamed(AppRoutes.selectedAlbum);

  static toPreviewView() => Get.toNamed(AppRoutes.previewView);

  /// 关闭所有页面并跳转至登录页面
  static offAndToLogin() => Get.offAndToNamed(AppRoutes.login);

  /// 关闭所有页面并跳转至登录页面
  static offAllToLogin() => Get.offAllNamed(AppRoutes.login);

  static toLogin() => Get.toNamed(AppRoutes.login);

  /// 第一次打开初始化App
  static intoInitApp() {
    RouteManager.toMain();
    RouteManager.toGuide();
  }
}
