import 'package:flutter/material.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class MessageMixin {
  ///发送消息
  Future<bool> sendBaseMessageMixin({
    RCIMIWEngine? engine,
    required RCIMIWMessage message,
    Function(bool)? onSendResult,
  }) async {
    int? ret = await engine?.sendMessage(
      message,
      callback: RCIMIWSendMessageCallback(
        onMessageSaved: (RCIMIWMessage? message) {
          debugPrint("RongIM onMessageSaved: ${message?.toJson()}");
        },
        onMessageSent: (int? code, RCIMIWMessage? message) {
          debugPrint(
            "RongIM onMessageSent code:$code, message:${message?.toJson()}",
          );
          onSendResult?.call(code == 0);
        },
      ),
    );
    if (ret != 0) {
      debugPrint("RongIM sendMessage code:$ret");
    }
    return ret == 0;
  }

  ///发送文字消息
  Future<bool> sendTextMessageMixin({
    RCIMIWEngine? engine,
    required String text,
    required String targetId,
    Function(bool)? onSendResult,
  }) async {
    RCIMIWTextMessage? textMessage = await engine?.createTextMessage(
      RCIMIWConversationType.private,
      targetId,
      null,
      text,
    );
    if (textMessage != null) {
      return sendBaseMessageMixin(
        engine: engine,
        message: textMessage,
        onSendResult: onSendResult,
      );
    } else {
      return Future.value(false);
    }
  }

  ///发送图片消息
  Future<bool> sendImageMessageMixin({
    RCIMIWEngine? engine,
    required String targetId,
    required String path,
  }) async {
    RCIMIWImageMessage? imageMessage = await engine?.createImageMessage(
      RCIMIWConversationType.private,
      targetId,
      null,
      path,
    );
    if (imageMessage != null) {
      return sendBaseMessageMixin(engine: engine, message: imageMessage);
    } else {
      return Future.value(false);
    }
  }

  ///发送视频消息
  Future<bool> sendVideoMessageMixin({
    RCIMIWEngine? engine,
    required String targetId,
    required String path,
    int? duration,
  }) async {
    RCIMIWSightMessage? videoMessage = await engine?.createSightMessage(
      RCIMIWConversationType.private,
      targetId,
      null,
      path,
      duration ?? 0,
    );
    if (videoMessage != null) {
      return sendBaseMessageMixin(engine: engine, message: videoMessage);
    } else {
      return Future.value(false);
    }
  }

  ///获取历史消息
  Future<bool> getHistoryMessagesMixin({
    RCIMIWEngine? engine,
    required String targetId,
    int sentTime = 0,
    Function(List<RCIMIWMessage>)? onHistoryMessage,
  }) async {
    int? ret = await engine?.getMessages(
      RCIMIWConversationType.private,
      targetId,
      null,
      sentTime,
      RCIMIWTimeOrder.before,
      RCIMIWMessageOperationPolicy.localRemote,
      20,
      callback: IRCIMIWGetMessagesCallback(
        onSuccess: (List<RCIMIWMessage>? t) {
          debugPrint("RongIM getHistoryMessages total:${t?.length}");
          List<RCIMIWMessage> messageList = t ?? [];
          onHistoryMessage?.call(messageList);
        },
        onError: (int? code) {
          debugPrint("RongIM getHistoryMessages onError:$code");
        },
      ),
    );
    return ret == 0;
  }
}
