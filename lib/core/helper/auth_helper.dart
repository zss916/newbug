class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();
  static AuthHelper get instance => AuthHelper();
  factory AuthHelper() => _instance;
  AuthHelper._internal();

  /// 是否今天注册，因为 请求个人信息 或者 编辑个人信息 接口有时候不返回is_today_sign，只能以login和refreshtoken为主
  bool isTodayRegister = false;
}
