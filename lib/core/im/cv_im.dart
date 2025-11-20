import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/rong_im.dart';
import 'package:newbug/core/im/utils/base64.dart';
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

  ///文字消息
  static Future<bool> toSendText({
    required String targetId,
    required String text,
    Function(RCIMIWMessage? message)? onSendStart,
    Function(int? code, RCIMIWMessage? message)? onSendResult,
  }) async {
    return await RongIM.instance.sendTextMessage(
      text: text,
      targetId: targetId,
      onSendStart: onSendStart,
      onSendResult: onSendResult,
    );
  }

  ///发送图片消息
  static Future<bool> toSendImage({
    required String targetId,
    required String path,
    Function(RCIMIWMediaMessage? message)? onSendMsgSaved,
    Function(RCIMIWMediaMessage? message)? onSendMsgSending,
    Function(int? code, RCIMIWMediaMessage? message)? onSendMsgSent,
    Function(RCIMIWMediaMessage? message)? onSendMsgCanceled,
  }) async {
    return await RongIM.instance.sendImageMessage(
      path: path,
      targetId: targetId,
      onSendMsgSent: onSendMsgSent,
      onSendMsgSending: onSendMsgSending,
      onSendMsgSaved: onSendMsgSaved,
      onSendMsgCanceled: onSendMsgCanceled,
    );
  }

  ///发送视频消息
  static Future<bool> toSendVideo({
    required String targetId,
    required String path,
    int? duration,
    Function(int? code, RCIMIWMediaMessage? message)? onSendMsgSent,
    Function(RCIMIWMediaMessage? message)? onSendMsgSending,
    Function(RCIMIWMediaMessage? message)? onSendMsgSaved,
    Function(RCIMIWMediaMessage? message)? onSendMsgCanceled,
  }) async {
    return await RongIM.instance.sendVideoMessage(
      path: path,
      duration: duration,
      targetId: targetId,
      onSendMsgSent: onSendMsgSent,
      onSendMsgSending: onSendMsgSending,
      onSendMsgSaved: onSendMsgSaved,
      onSendMsgCanceled: onSendMsgCanceled,
    );
  }

  ///私有单个消息
  static Future<bool> toSendPrivateMsg({
    required String targetId,
    required String content,
    Function(RCIMIWMessage? message)? onSendStart,
    Function(int? code, RCIMIWMessage? message)? onSendResult,
  }) async {
    PrivateMessage message = PrivateMessage(
      RCIMIWConversationType.private,
      targetId,
      content,
    );
    message.expansion = {};
    return await RongIM.instance.sendCustomMessage(customMessage: message);
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
  static Future<void> getHistoryMessageList({
    String? targetId,
    int sentTime = 0,
    Function(List<RCIMIWMessage>)? onHistoryMessage,
  }) async {
    if (targetId == null) {
      debugPrint("CvIM getHistoryMessageList => uid is null,$targetId");
      return;
    }
    await RongIM.instance.getHistoryMessages(
      targetId: targetId,
      sentTime: sentTime,
      onHistoryMessage: onHistoryMessage,
    );
  }

  ///退出登录
  static void logout() {
    RongIM.instance.logout();
  }
}
