import 'package:flutter/material.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class ListenerMixin {
  ///连接状态监听
  void setOnConnectStatus({RCIMIWEngine? engine}) {
    engine?.onConnectionStatusChanged = (RCIMIWConnectionStatus? status) {
      switch (status) {
        case RCIMIWConnectionStatus.networkUnavailable:
          debugPrint("RongIM 网络不可用");
          break;
        case RCIMIWConnectionStatus.connected:
          debugPrint("RongIM 连接成功");
          break;
        case RCIMIWConnectionStatus.connecting:
          debugPrint("RongIM 连接中");
          break;
        case RCIMIWConnectionStatus.unconnected:
          debugPrint("RongIM 未连接");
          break;
        case RCIMIWConnectionStatus.kickedOfflineByOtherClient:
          debugPrint("RongIM 用户账户在其他设备登录，本机会被踢掉线");
          break;
        case RCIMIWConnectionStatus.tokenIncorrect:
          debugPrint("RongIM Token 不正确");

          ///todo 触发刷新imToken
          break;
        case RCIMIWConnectionStatus.connUserBlocked:
          debugPrint("RongIM 用户被开发者后台封禁");
          break;
        case RCIMIWConnectionStatus.signOut:
          debugPrint("RongIM 用户主动调用 disconnect 或 logout 接口断开连接");
          break;
        case RCIMIWConnectionStatus.suspend:
          debugPrint("RongIM 连接暂时挂起（多是由于网络问题导致），SDK 会在合适时机进行自动重连");
          break;
        case RCIMIWConnectionStatus.timeout:
          debugPrint(
            "RongIM 自动连接超时，SDK 将不会继续连接，用户需要做超时处理，再自行调用 connectWithToken 接口进行连接",
          );
          break;
        case RCIMIWConnectionStatus.unknown:
          debugPrint("RongIM 异常情况");
          break;
        default:
          debugPrint("RongIM 未知状态");
          break;
      }
    };
  }

  ///设置接受消息监听
  void setOnMessageReceived({
    RCIMIWEngine? engine,
    Function(RCIMIWMessage? message)? onReceiveMsg,
  }) {
    debugPrint("RongIM setOnMessageReceived ");
    engine?.onMessageReceived =
        (RCIMIWMessage? message, int? left, bool? offline, bool? hasPackage) {
          debugPrint("RongIM 接受消息监听 message:${message?.toJson()} ");
          if (offline == true) {
            debugPrint("RongIM 离线消息不处理");
            return;
          }
          onReceiveMsg?.call(message);
        };
  }

  ///远程扩展消息更新
  void setOnRemoteMessageExpansionUpdated({
    RCIMIWEngine? engine,
    Function(Map? expansion, RCIMIWMessage? message)?
    onReceiveMsgExpansionUpdated,
  }) {
    engine?.onRemoteMessageExpansionUpdated =
        (Map? expansion, RCIMIWMessage? message) {
          debugPrint(
            "RongIM 远程扩展消息更新 message:${message?.toJson()}, expansion:$expansion",
          );

          onReceiveMsgExpansionUpdated?.call(expansion, message);
        };
  }

  ///撤回消息监听
  void setOnRemoteMessageRecalled({RCIMIWEngine? engine}) {
    engine?.onRemoteMessageRecalled = (message) {
      debugPrint("RongIM 撤回消息监听 ${message?.toJson()}");
    };
  }
}
