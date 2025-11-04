part of 'index.dart';

class LaunchLogic extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    if (AuthHelper.instance.isLogin) {
      bool isNeedEdit = await refreshToken();
      if (isNeedEdit) {
        RouteManager.offAllToLogin();
      } else {
        loginAction();
        if (AppStores.getUserInfo() == null) {
          await ProfileAPI.getUserInfo();
        }
        RouteManager.toMain();
      }
    } else {
      RouteManager.offAndToLogin();
    }
  }

  /// 刷新token
  Future<bool> refreshToken() async {
    AuthEntity? auth = await AccountAPI.refreshToken();
    if (auth != null) {
      //1.保存登录信息
      //2.更新状态
      AppStores.setAuthData(value: auth);
      AuthHelper.instance.isTodayRegister = auth.isTodaySign ?? false;
    } else {
      AuthHelper.instance.toHandleLogout();
    }
    return (auth?.isNeedEdit ?? false);
  }

  /// 登录
  void loginAction() {
    //1.刷新Authorization
    //2.IM容云链接
    //3.开启在线用户状态更新
    //4.开启状态上报
  }
}
