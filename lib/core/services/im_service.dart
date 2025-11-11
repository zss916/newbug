/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/im/rong_im.dart';
import 'package:newbug/core/im/utils/base64.dart';
import 'package:newbug/core/im/utils/im_event.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class ImService extends GetxService {
  static ImService get to => Get.find();

  static String imConnectKey = "Y3BqMnhhcmx+jOGFobg==";

  ///初始化
  Future<ImService> init() async {
    String appKey = Base64.decode(imConnectKey.replaceAll("+", ""));
    RongIM.instance.init(appKey: appKey);
    return this;
  }

  ///连接融云
  void connect(String? token) {
    if (token != null) {
      debugPrint("token is null");
      return;
    }
    RongIM.instance.connect(
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

  ///获取会话列表
  void getConversations({
    Function(List<RCIMIWConversation>)? onGetConversations,
  }) {
    RongIM.instance.getConversations(
      onGetConversationsList: (List<RCIMIWConversation> conversations) {
        onGetConversations?.call(conversations);
      },
    );
  }

  ///发送消息
  void toSend({required String targetId, required String text}) {
    RongIM.instance.sendTextMessage(text: text, targetId: targetId).then((
      value,
    ) {
      EventService.to.post(SendEvent());
    });
  }

  ///退出登录
  void logout() {
    RongIM.instance.logout();
  }
}
*/
