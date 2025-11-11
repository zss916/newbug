part of 'index.dart';

class EmailLogic extends GetxController {
  String email = "";
  String password = "";

  /* @override
  void onReady() {
    super.onReady();
    // initData();
  }

  Future<void> initData() async {
    final (String account, String pwd) = await KeyChainTool.getKeyChain();
    email = account;
    password = pwd;
    update();
  }*/

  /// 邮箱登录
  void emailLogic({required String email, required String password}) async {
    CustomToast.loading();
    AuthEntity? value = await AccountAPI.emailLogin(email: email, pwd: password)
        .whenComplete(() {
          CustomToast.dismiss();
        });
    if (value != null) {
      KeyChainTool.putKeyChain(account: email, password: password);
      TextInput.finishAutofillContext();
      AppStores.setAuthData(value: value);
      CvIM.connect(value.imToken);

      ///AppStores.setUserInfo(value: UserEntity()..authToken = value.authToken);
      // Net.instance.updateHeaders(token: value.authToken ?? "");
      AuthHelper.instance.isTodayRegister = value.isTodaySign ?? true;
      if (value.isNeedEdit) {
        RouteManager.toName(user: null);
      } else {
        ///todo 优化一下
        /* if (AppStores.getUserInfo() == null) {
          await ProfileAPI.getUserInfo();
        }*/
        RouteManager.toMain();
      }
    }
  }
}
