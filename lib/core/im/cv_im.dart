import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:newbug/core/im/rong_im.dart';
import 'package:newbug/core/im/utils/base64.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class CvIM extends GetxService {
  static String imConnectKey = "Y3BqMnhhcmx+jOGFobg==";

  ///初始化
  static Future<void> init() async {
    String appKey = Base64.decode(imConnectKey.replaceAll("+", ""));
    await RongIM.instance.init(appKey: appKey);
  }

  ///登录后连接
  static Future<void> connect(String? token) async {
    debugPrint("CvIM connect :$token");
    if ((token ?? "").isEmpty) {
      debugPrint("token is null");
      return;
    }

    await RongIM.instance.connect(
      token: token ?? "",
      onConnected: (int? code, String? userId) {
        bool isSuccessful = code == 0 || code == 34001;
        if (isSuccessful) {
          // _connectionStatus = RCIMIWConnectionStatus.connected;
          Future.delayed(Duration(seconds: 1), () {
            /// todo _loadConversations();1
          });
        }

        if (code == 31004 || code == 31020) {
          ///todo 刷新imToken
          ///refreshImTokenFunc(true);
        }
      },
    );
  }

  ///发送 (自己10011052) （主播10004891，10000727，10004888）
  static Future<bool> toSend({
    required String targetId,
    required String text,
    Function(bool)? onSendResult,
  }) async {
    return await RongIM.instance.sendTextMessage(
      text: text,
      targetId: targetId,
      onSendResult: onSendResult,
    );
  }

  ///获取会话列表
  static Future<void> getConversations({
    int startTime = 0,
    Function(List<RCIMIWConversation>)? onGetConversations,
  }) async {
    await RongIM.instance.getConversations(
      startTime: startTime,
      onGetConversationsList: (List<RCIMIWConversation> conversations) {
        onGetConversations?.call(conversations);
      },
    );
  }

  ///删除会话
  static Future<void> removeConversationItem({
    required String targetId,
    Function(bool)? onRemoveCallback,
  }) async {
    await RongIM.instance.removeConversation(
      targetId: targetId,
      onRemoveCallback: onRemoveCallback,
    );
  }

  ///会话置顶
  static Future<void> setConversationItemTop({
    required String targetId,
    required bool top,
    Function(bool)? onSetConversationTop,
  }) async {
    await RongIM.instance.setConversationTop(
      targetId: targetId,
      top: top,
      onSetConversationTop: onSetConversationTop,
    );
  }

  ///获取历史消息
  static void getHistoryMessageList() {
    int? uid = AppStores.getUid();
    if (uid == null) {
      debugPrint("CvIM getHistoryMessageList => uid is null");
      return;
    }
    RongIM.instance.getHistoryMessages(targetId: "$uid");
  }

  ///退出登录
  static void logout() {
    RongIM.instance.logout();
  }
}
