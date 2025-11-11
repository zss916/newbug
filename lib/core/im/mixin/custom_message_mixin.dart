import 'package:newbug/core/im/custom_message/connected_message.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/im/custom_message/data_sync_message.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/core/im/custom_message/system_message.dart';
import 'package:newbug/core/im/custom_message/system_tips_message.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class CustomMessageMixin {
  ///注册自定义消息
  void registerCustomMessages({RCIMIWEngine? engine}) {
    ///建联消息
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.connected.name,
      (json) => ConnectedMessage.fromJson(json)..decode(json['content']),
    );

    ///公开消息
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.public.name,
      (json) => PublicMessage.fromJson(json)..decode(json['content']),
    );

    ///私密消息
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.private.name,
      (json) => PrivateMessage.fromJson(json)..decode(json['content']),
    );

    ///多张私密消息
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.packagePrivate.name,
      (json) => PrivatePackageMessage.fromJson(json)..decode(json['content']),
    );

    ///系统触发的行为消息
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.system.name,
      (json) => SystemMessage.fromJson(json)..decode(json['content']),
    );

    ///消息同步数据
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.sync.name,
      (json) => DataSyncMessage.fromJson(json)..decode(json['content']),
    );

    ///系统提示消息
    _registerSomeoneCustomMsg(
      engine,
      CustomMessageType.systemTips.name,
      (json) => SystemTipsMessage.fromJson(json)..decode(json['content']),
    );
  }

  /// 注册某一个自定义消息
  void _registerSomeoneCustomMsg(
    RCIMIWEngine? engine,
    String objectName,
    RCIMIWUserCustomMessage Function(Map<String, dynamic> json) messageDcoder,
  ) {
    engine?.registerCustomMessage(objectName, messageDcoder);
  }
}
