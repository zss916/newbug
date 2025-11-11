import 'package:newbug/core/im/mixin/conversation_mixin.dart';
import 'package:newbug/core/im/mixin/custom_message_mixin.dart';
import 'package:newbug/core/im/mixin/engine_mixin.dart';
import 'package:newbug/core/im/mixin/listener_mixin.dart';
import 'package:newbug/core/im/mixin/message_mixin.dart';
import 'package:newbug/core/im/utils/im_event.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class RongIM
    with
        CustomMessageMixin,
        ConversationMixin,
        MessageMixin,
        ListenerMixin,
        EngineMixin {
  RongIM._internal();

  static final RongIM _instance = RongIM._internal();

  static RongIM get instance => _instance;

  RCIMIWEngine? engine;

  /// 初始化
  Future<void> init({required String appKey}) async {
    engine = await createEngineMixin(appKey: appKey);

    ///注册自定义消息
    registerCustomMessages(engine: engine);

    ///连接状态监听
    setOnConnectStatus(engine: engine);

    ///消息监听
    setOnMessageReceived(
      engine: engine,
      onReceiveMsg: (RCIMIWMessage? message) {
        ///todo 新消息触发会话列表和消息页面刷新
        EventService.to.post(ReceiveMsgEvent(message));
      },
    );

    ///远程扩展消息更新
    setOnRemoteMessageExpansionUpdated(engine: engine);

    ///撤回消息监听
    setOnRemoteMessageRecalled(engine: engine);
  }

  ///连接
  Future<bool> connect({
    required String token,
    Function(int? code, String? userId)? onConnected,
  }) async {
    return await connectMixin(
      engine: engine,
      token: token,
      onConnected: onConnected,
    );
  }

  ///退出登录
  Future<bool> logout({bool receivePush = true}) async {
    return await logoutMixin(engine: engine, receivePush: receivePush);
  }

  ///获取会话列表
  Future<bool> getConversations({
    int startTime = 0,
    int count = 50,
    Function(List<RCIMIWConversation>)? onGetConversationsList,
  }) async {
    return await getConversationsMixin(
      engine: engine,
      startTime: startTime,
      count: count,
      onGetConversations: onGetConversationsList,
    );
  }

  ///删除指定会话
  Future<bool> removeConversation({
    required String targetId,
    Function(bool)? onRemoveCallback,
  }) async {
    return await removeConversationMixin(
      engine: engine,
      targetId: targetId,
      onRemoveCallback: onRemoveCallback,
    );
  }

  ///会话置顶
  Future<bool> setConversationTop({
    required String targetId,
    required bool top,
    Function(bool)? onSetConversationTop,
  }) async {
    return await setConversationTopMixin(
      engine: engine,
      targetId: targetId,
      top: top,
      onSetConversationTop: onSetConversationTop,
    );
  }

  ///发送消息
  Future<bool> sendBaseMessage({required RCIMIWMessage message}) async {
    return await sendBaseMessageMixin(engine: engine, message: message);
  }

  ///发送Text消息
  Future<bool> sendTextMessage({
    required String targetId,
    required String text,
    Function(bool)? onSendResult,
  }) async {
    return await sendTextMessageMixin(
      engine: engine,
      targetId: targetId,
      text: text,
      onSendResult: onSendResult,
    );
  }

  ///获取历史消息
  Future<bool> getHistoryMessages({
    required String targetId,
    Function(List<RCIMIWMessage>)? onHistoryMessage,
  }) async {
    return getHistoryMessagesMixin(
      engine: engine,
      targetId: targetId,
      onHistoryMessage: onHistoryMessage,
    );
  }
}
