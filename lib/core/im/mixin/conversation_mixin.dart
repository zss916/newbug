import 'package:flutter/material.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class ConversationMixin {
  ///获取会话
  Future<bool> getConversationsMixin({
    RCIMIWEngine? engine,
    int startTime = 0,
    int count = 50,
    Function(List<RCIMIWConversation>)? onGetConversations,
  }) async {
    int? ret = await engine?.getConversations(
      [RCIMIWConversationType.private],
      null,
      startTime,
      count,
      callback: IRCIMIWGetConversationsCallback(
        onSuccess: (List<RCIMIWConversation>? t) {
          debugPrint("RongIM Conversation getList total:${t?.length ?? 0}");
          List<RCIMIWConversation> conversations = t ?? <RCIMIWConversation>[];
          onGetConversations?.call(conversations);
        },
        onError: (int? code) {
          debugPrint("RongIM Conversation onError: $code");
        },
      ),
    );
    return ret == 0;
  }

  ///删除指定会话
  Future<bool> removeConversationMixin({
    RCIMIWEngine? engine,
    required String targetId,
    Function(bool)? onRemoveCallback,
  }) async {
    int? ret = await engine?.removeConversation(
      RCIMIWConversationType.private,
      targetId,
      null,
      callback: IRCIMIWRemoveConversationCallback(
        onConversationRemoved: (int? code) {
          debugPrint("RongIM Conversation remove: $code");
          onRemoveCallback?.call(code == 0);
        },
      ),
    );
    return ret == 0;
  }

  ///会话置顶
  Future<bool> setConversationTopMixin({
    RCIMIWEngine? engine,
    required String targetId,
    required bool top,
    Function(bool)? onSetConversationTop,
  }) async {
    int? ret = await engine?.changeConversationTopStatus(
      RCIMIWConversationType.private,
      targetId,
      null,
      top,
      callback: IRCIMIWChangeConversationTopStatusCallback(
        onConversationTopStatusChanged: (int? code) {
          debugPrint("RongIM Conversation setTop: $code");
          onSetConversationTop?.call(code == 0);
        },
      ),
    );
    return ret == 0;
  }
}
