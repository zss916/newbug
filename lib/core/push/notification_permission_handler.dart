import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/page/dialog/trun_on_notification.dart';
import 'package:permission_handler/permission_handler.dart';

mixin class NotificationPermissionHandler {
  ///通知权限
  Future<void> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      registerNotification();
    }
  }

  ///通知权限处理
  Future<bool> registerNotification({bool showDialog = true}) async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      // PermissionAlertManager().pushEnabled = true;
      getFCMToken();
      //_configureFCMListeners();
      return true;
    } else {
      debugPrint('User declined or has not accepted permission');
      showTurnOnNotification();
      return false;
    }
  }

  ///更新fcmToken
  void getFCMToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      updateTokenToServer(fcmToken ?? "");
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        updateTokenToServer(fcmToken);
      });
    } catch (error) {
      debugPrint("error:$error");
    }
  }

  ///更新token 到服务器
  Future<bool> updateTokenToServer(String pushToken) async {
    bool isSuccessful = await SystemAPI.updatePushToken(pushToken: "");
    return isSuccessful;
  }
}
