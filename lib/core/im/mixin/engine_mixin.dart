import 'package:flutter/material.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class EngineMixin {
  ///创建引擎
  Future<RCIMIWEngine> createEngineMixin({required String appKey}) async {
    RCIMIWEngineOptions options = RCIMIWEngineOptions.create(
      logLevel: RCIMIWLogLevel.verbose,
    );
    options.naviServer = 'nav.us-light-edge.com';
    options.statisticServer = 'stats.us-light-edge.com';
    return await RCIMIWEngine.create(appKey, options);
  }

  ///连接
  Future<bool> connectMixin({
    RCIMIWEngine? engine,
    required String token,
    int timeout = 30,
    Function(int? code, String? userId)? onConnected,
  }) async {
    debugPrint("RongIM connect isTokenEmpty: ${token.isEmpty}");
    int? ret = await engine?.connect(
      token,
      timeout,
      callback: RCIMIWConnectCallback(
        onDatabaseOpened: (int? code) {
          debugPrint("RongIM connect onDatabaseOpened: $code");
        },
        onConnected: (int? code, String? userId) {
          debugPrint("RongIM connect onConnected code:$code, uid:$userId");
          onConnected?.call(code, userId);
        },
      ),
    );
    if (ret != 0) {
      debugPrint("RongIM connect code:$ret");
    }
    return ret == 0;
  }

  ///登出
  Future<bool> logoutMixin({
    RCIMIWEngine? engine,
    bool receivePush = true,
  }) async {
    int? ret = await engine?.disconnect(receivePush);
    if (ret != 0) {
      debugPrint("RongIM logout code:$ret");
    }
    return ret == 0;
  }

  ///销毁
  Future<void> destroy({RCIMIWEngine? engine}) async => await engine?.destroy();
}
