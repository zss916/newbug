part of 'index.dart';

/// 路由管理
class RouteManager {
  static toEmailLogin() => Get.toNamed(AppRoutes.email);

  static toSex() => Get.toNamed(AppRoutes.sex);

  static toName() => Get.toNamed(AppRoutes.name);

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

  /// 第一次打开初始化App
  static intoInitApp() {
    RouteManager.toMain();
    RouteManager.toGuide();
  }
}
