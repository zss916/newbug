import 'package:get/get.dart';
import 'package:newbug/core/helper/auth_helper.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/reopsitory/account.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/widget/index.dart';

class ProfileLogic extends GetxController {
  UserEntity? user;

  String get avatar => user?.headimg ?? '';
  String get uid => user?.userId ?? '--';
  String get nickName => "${user?.nickName ?? ''},${user?.age}";

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
    // loadUserInfo();
  }

  void initData() {
    user = AppStores.getUserInfo();
  }

  /// 加载用户信息
  void loadUserInfo() async {
    //CustomToast.loading();
    user = await ProfileAPI.getUserInfo().whenComplete(
      () => CustomToast.dismiss(),
    );
    update();
  }

  /// 退出登录
  Future<void> toLogOUt() async {
    CustomToast.loading();
    bool isLogout = await AccountAPI.exitLogin().whenComplete(
      () => CustomToast.dismiss(),
    );
    if (isLogout) {
      AuthHelper.instance.toHandleLogout();
      RouteManager.offAllToLogin();
    }
  }
}
