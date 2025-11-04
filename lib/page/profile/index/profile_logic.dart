import 'package:get/get.dart';
import 'package:newbug/core/helper/auth_helper.dart';
import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/reopsitory/account.dart';
import 'package:newbug/core/network/reopsitory/chat.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/profile/sheet/pay/pay_sheet.dart';

class ProfileLogic extends GetxController {
  UserEntity? user;
  String get avatar => user?.headimg ?? '';
  String get uid => user?.userId ?? '--';
  String get nickName => "${user?.nickName ?? ''},${user?.age}";
  bool get isVip => user?.right?.vip == 1;
  int get privacyVideo => user?.right?.privacyvideo ?? 0;
  int get privacyImage => user?.right?.privacyimage ?? 0;
  int get flashChat => user?.right?.flashchat ?? 0;

  UnreadDataEntity? unreadData;
  int get visitorNewCount => unreadData?.visitorNewNum ?? 0;
  int get visitorTotalCount => unreadData?.visitorTotalNum ?? 0;
  List<String> get headList => unreadData?.headList ?? <String>[];

  //int get wlmEntryTotalCount => unreadData?.wlmTotalNum ?? 0;
  //int get wlmEntryCount => unreadData?.wlmNewNum ?? 0;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
    /*CustomToast.loading();
    Future.wait([
      loadUserInfo(),
      loadWlmOrVisitorCount(),
    ]).whenComplete(() => CustomToast.dismiss());*/
  }

  void initData() {
    user = AppStores.getUserInfo();
  }

  /// 加载用户信息
  Future<void> loadUserInfo() async {
    //CustomToast.loading();
    user = await ProfileAPI.getUserInfo().whenComplete(() {
      // CustomToast.dismiss();
    });
    update();
  }

  ///获取wlm 或者 Visitor
  Future<void> loadWlmOrVisitorCount() async {
    unreadData = await ChatAPI.queryWlmOrVisitorCount().whenComplete(() {
      // CustomToast.dismiss();
    });
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

  ///点击私有视频
  void toPrivateVideo() {
    /* EventService.to.post(
                  ShowMatchCountTipEvent(isShow: true, count: 99),
                );*/
    showPaySheet(index: 0);
  }

  ///点击私有照片
  void toPrivatePhoto() {
    /*EventService.to.post(
                  ShowMatchCountTipEvent(isShow: false, count: 99),
                );*/
    showPaySheet(index: 1);
  }

  ///点击flash chat
  void toFlashChat() {
    showPaySheet(index: 2);
  }

  ///去订阅
  void toSubscribe() {
    RouteManager.toSubscribe();
  }
}
