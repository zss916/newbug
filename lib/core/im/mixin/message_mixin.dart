import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class MessageMixin {
  ///发送普通消息
  Future<bool> sendBaseMessageMixin({
    RCIMIWEngine? engine,
    required RCIMIWMessage message,
    Function(RCIMIWMessage? message)? onSendStart,
    Function(int? code, RCIMIWMessage? message)? onSendResult,
  }) async {
    int? ret = await engine?.sendMessage(
      message,
      callback: RCIMIWSendMessageCallback(
        onMessageSaved: (RCIMIWMessage? message) {
          debugPrint("RongIM onMessageSaved: ${message?.toJson()}");
          onSendStart?.call(message);
        },
        onMessageSent: (int? code, RCIMIWMessage? message) {
          debugPrint(
            "RongIM onMessageSent code:$code, message:${message?.toJson()}",
          );
          onSendResult?.call(code, message);
        },
      ),
    );
    if (ret != 0) {
      debugPrint("RongIM sendMessage code:$ret");
    }
    return ret == 0;
  }

  ///发送媒体消息
  Future<bool> sendMediaMessageMixin({
    RCIMIWEngine? engine,
    required RCIMIWMediaMessage message,
    Function(int? code, RCIMIWMediaMessage? message)? onSendMsgSent,
    Function(RCIMIWMediaMessage? message)? onSendMsgSending,
    Function(RCIMIWMediaMessage? message)? onSendMsgSaved,
    Function(RCIMIWMediaMessage? message)? onSendMsgCanceled,
  }) async {
    int? ret = await engine?.sendMediaMessage(
      message,
      listener: RCIMIWSendMediaMessageListener(
        onMediaMessageSaved: (RCIMIWMediaMessage? message) {
          debugPrint(
            "RongIM sendMediaMsgSaved step1 message:${message?.toJson()}",
          );
          onSendMsgSaved?.call(message);
        },
        onMediaMessageSending: (RCIMIWMediaMessage? message, int? progress) {
          debugPrint(
            "RongIM sendMediaMsgSending step2 message:${message?.toJson()} \n progress:$progress",
          );
          onSendMsgSending?.call(message);
        },
        onMediaMessageSent: (int? code, RCIMIWMediaMessage? message) {
          debugPrint(
            "RongIM sendMediaMsgSent step3 code:$code,\n message:${message?.toJson()}",
          );
          onSendMsgSent?.call(code, message);
        },
        onSendingMediaMessageCanceled: (RCIMIWMediaMessage? message) {
          debugPrint(
            "RongIM sendMediaMsgCanceled message:${message?.toJson()}",
          );
          onSendMsgCanceled?.call(message);
        },
      ),
    );
    if (ret != 0) {
      debugPrint("RongIM sendMessage code:$ret");
    }
    return ret == 0;
  }

  ///发送自定义消息 ???
  Future<bool> sendCustomMessageMixin({
    RCIMIWEngine? engine,
    required String targetId,
    String? channelId,
    required RCIMIWCustomMessagePolicy policy,
    required String messageIdentifier,
    required Map fields,
  }) async {
    RCIMIWCustomMessage? customMessage = await engine?.createCustomMessage(
      RCIMIWConversationType.private,
      targetId,
      null,
      policy,
      messageIdentifier,
      fields,
    );
    if (customMessage != null) {
      return sendBaseMessageMixin(engine: engine, message: customMessage);
    } else {
      return Future.value(false);
    }
  }

  ///发送文字消息
  Future<bool> sendTextMessageMixin({
    RCIMIWEngine? engine,
    required String text,
    required String targetId,
    Function(RCIMIWMessage? message)? onSendStart,
    Function(int? code, RCIMIWMessage? message)? onSendResult,
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
        onSendStart: onSendStart,
        onSendResult: onSendResult,
      );
    } else {
      return Future.value(false);
    }
  }

  ///发送图片消息（path 是图像的本地路径）
  Future<bool> sendImageMessageMixin({
    RCIMIWEngine? engine,
    required String targetId,
    required String path,
    Function(int? code, RCIMIWMediaMessage? message)? onSendMsgSent,
    Function(RCIMIWMediaMessage? message)? onSendMsgSending,
    Function(RCIMIWMediaMessage? message)? onSendMsgSaved,
    Function(RCIMIWMediaMessage? message)? onSendMsgCanceled,
  }) async {
    RCIMIWImageMessage? imageMessage = await engine?.createImageMessage(
      RCIMIWConversationType.private,
      targetId,
      null,
      path,
    );

    if (imageMessage == null || File(path).existsSync() != true) {
      CustomToast.showText("Send image failed, please try again");
      return Future.value(false);
    }

    return sendMediaMessageMixin(
      engine: engine,
      message: imageMessage,
      onSendMsgSent: onSendMsgSent,
      onSendMsgSending: onSendMsgSending,
      onSendMsgSaved: onSendMsgSaved,
      onSendMsgCanceled: onSendMsgCanceled,
    );
  }

  ///发送视频消息
  Future<bool> sendVideoMessageMixin({
    RCIMIWEngine? engine,
    required String targetId,
    required String path,
    int? duration,
    Function(int? code, RCIMIWMediaMessage? message)? onSendMsgSent,
    Function(RCIMIWMediaMessage? message)? onSendMsgSending,
    Function(RCIMIWMediaMessage? message)? onSendMsgSaved,
    Function(RCIMIWMediaMessage? message)? onSendMsgCanceled,
  }) async {
    RCIMIWSightMessage? videoMessage = await engine?.createSightMessage(
      RCIMIWConversationType.private,
      targetId,
      null,
      path,
      duration ?? 0,
    );
    if (videoMessage != null) {
      return sendMediaMessageMixin(
        engine: engine,
        message: videoMessage,
        onSendMsgSent: onSendMsgSent,
        onSendMsgSending: onSendMsgSending,
        onSendMsgSaved: onSendMsgSaved,
        onSendMsgCanceled: onSendMsgCanceled,
      );
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
      9,
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
