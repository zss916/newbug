import 'package:get/get.dart';
import 'package:newbug/core/route/index.dart';

class ActionID {
  //打开webview
  static const String webview = "1";
  //私聊
  static const String chat = "3";
  //编辑资料
  static const String editUserInfo = "7";
  //他人主页
  static const String otherProfile = "8";
  //匹配成功
  static const String matchSuccess = "9";
  //flash chat
  static const String flashChat = "11";
  //私密相册列表
  static const String privacyAlbumList = "12";
  //访客列表
  static const String visitorList = "18";
  //到期提醒
  static const String renewVip = "20";
  //付费弹窗
  static const String payAlert = "1006";
  //私密相册引导弹框
  static const String privateAlbumAlert = "1007";
  //系统消息
  static const String wlmAlert = "1010";
  //评分弹窗
  static const String rateAlert = "1012";
  //重复订阅
  static const String payFailed = "1015";
  //错过的wlm
  static const String missWlm = "1016";
}

///接口返回的action 处理
extension ActionRouter on GetInterface {
  ///action
  void handAction(Map<String, dynamic>? action) {
    var pageId = action?['id'].toString();
    if (pageId == null) {
      return;
    }
    var params = action?['param'];
    switch (pageId) {
      case ActionID.webview:
        toNamed(AppRoutes.webview, arguments: params);
        break;
      case ActionID.chat:
        toNamed(AppRoutes.chat, arguments: params);
        break;
      case ActionID.flashChat:
        toNamed(AppRoutes.flashChat, arguments: params);
        break;
      case ActionID.visitorList:
        toNamed(AppRoutes.visitor, arguments: params);
        break;
      case ActionID.matchSuccess:
        break;
      case ActionID.renewVip:
        break;
      case ActionID.payAlert:
        break;
      case ActionID.privateAlbumAlert:
        break;
      case ActionID.wlmAlert:
        break;
      case ActionID.rateAlert:
        break;
      case ActionID.payFailed:
        break;
      case ActionID.missWlm:
        break;
    }
  }
}
