part of 'index.dart';

class EmailLogic extends GetxController {
  String email = "dddd";
  String password = "";

  @override
  void onReady() {
    super.onReady();
    // initData();
  }

  Future<void> initData() async {
    final (String account, String pwd) = await KeyChainTool.getKeyChain();
    email = account;
    password = pwd;
    update();
  }

  /// 邮箱登录
  void emailLogic({required String email, required String password}) async {
    CustomToast.loading();
    UserEntity? value = await AccountAPI.emailLogin(email: email, pwd: password)
        .whenComplete(() {
          CustomToast.dismiss();
        });
    if (value != null) {
      KeyChainTool.putKeyChain(account: email, password: password);
      TextInput.finishAutofillContext();
      AppStores.setUserInfo(value: value);
      Net.instance.updateHeaders(token: value.authToken ?? "");
      AuthHelper.instance.isTodayRegister = value.isTodaySign ?? true;
      if (value.isNeedEdit) {
        RouteManager.toName(user: value);
      } else {
        RouteManager.intoInitApp();
      }
    }
  }
}
