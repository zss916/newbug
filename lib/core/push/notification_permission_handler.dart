import 'package:firebase_messaging/firebase_messaging.dart';
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

    /*PermissionAlertManager().pushNotDetermined = false;
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      PermissionAlertManager().pushEnabled = true;
      getFCMToken();
      _configureFCMListeners();
      return true;
    } else {
      print('User declined or has not accepted permission');
      var context = navigatorKey.currentContext;
      if (navigatorKey.currentContext != null && showDialog) {
        OpenNotificationWidget.show(navigatorKey.currentContext!);
      }
      return false;
    }*/

    return false;
  }
}
