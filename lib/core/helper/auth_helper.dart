import 'package:newbug/core/purchase/product_storage_utils.dart';
import 'package:newbug/core/stores/app_stores.dart';

class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();
  static AuthHelper get instance => AuthHelper();
  factory AuthHelper() => _instance;
  AuthHelper._internal();

  /// 是否今天注册，因为 请求个人信息 或者 编辑个人信息 接口有时候不返回is_today_sign，只能以login和refreshtoken为主
  bool isTodayRegister = false;

  ///是否登录
  bool get isLogin => (AppStores.getAuthorization() ?? "").isNotEmpty;

  ///是否完成引导
  bool get isFinishGuide => AppStores.getGuideStatus();

  ///处理退出登录
  void toHandleLogout() {
    ProductStorageUtils.clear();
    AppStores.removeUserInfo();
  }

  ///处理删除账号
  void toHandleDeleteAccount() {
    ProductStorageUtils.clear();
    AppStores.removeAllData();
  }

  ///设置引导状态
  void setGuideStatus(bool isFinishGuide) {
    AppStores.setGuideStatus(isFinishGuide: isFinishGuide);
  }
}
