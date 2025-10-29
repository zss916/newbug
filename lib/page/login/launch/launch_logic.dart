part of 'index.dart';

class LaunchLogic extends GetxController {
  bool isLogin = false;
  bool isComplete = false;
  bool isFirst = false;

  @override
  void onReady() {
    super.onReady();

    if (isLogin) {
      refreshToken();
      if (isComplete) {
        RouteManager.offAllToLogin();
      } else {
        loginAction();
        if (isFirst) {
          RouteManager.intoInitApp();
        } else {
          RouteManager.toLogin();
        }
      }
    } else {
      RouteManager.offAndToLogin();
    }
  }

  /// 刷新token
  void refreshToken() async {
    UserEntity? user = await AccountAPI.refreshToken();

    ///
  }

  /// 登录
  void loginAction() {
    ///
  }
}
