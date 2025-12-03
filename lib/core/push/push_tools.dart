import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newbug/core/crash/firebase_crash.dart';

import 'notification_permission_handler.dart';

class PushTools with NotificationPermissionHandler {
  PushTools._internal();

  static final PushTools _instance = PushTools._internal();

  static PushTools get instance => _instance;

  ///todo android 本地通知频道ID
  String androidLocalNotificationChannelID = "";

  ///todo android 本地通知频道名称
  String androidLocalNotificationChannelName = "";

  ///本地通知是否初始化
  static bool isFlutterLocalNotificationsInitialized = false;

  ///android 通知频道
  static late AndroidNotificationChannel channel;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ///常驻通知是否显示
  static bool notificationShow = false;

  ///初始化
  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseCrash.setRecord();

    ///初始化flutter通知插件
    await setupFlutterNotifications();

    ///后台消息
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    ///FCM 注册监听
    setFCMListen();

    ///权限请求
    requestNotificationPermission();
  }

  ///设置通知
  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    isFlutterLocalNotificationsInitialized = true;
  }

  void setFCMListen() {
    ///应用从终止状态打开
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      //todo
    });

    ///前台消息
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //todo
    });

    ///点击后台消息打开app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ///todo
    });
  }

  ///配置android 本地通知
  Future<void> setAndroidNotification() async {
    channel = AndroidNotificationChannel(
      androidLocalNotificationChannelID,
      androidLocalNotificationChannelName,
      description: 'Channel for Android.',
      importance: Importance.high,
      playSound: true,
    );

    ///android 推送配置
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    ///ios 推送配置
    /*final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );*/

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (NotificationResponse details) {
        debugPrint(
          "flutterLocalNotificationsPlugin---onDidReceiveBackgroundNotificationResponse---${details.payload}",
        );
        if (details.payload == "app") {
          notificationShow = false;
        }

        switch (details.notificationResponseType) {
          case NotificationResponseType.selectedNotification:

            ///点击本地推送触发这里
            // selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload == "app") {
          notificationShow = false;
        }
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    //await Firebase.initializeApp(options: getFirebaseOptions());
    //await setupFlutterNotifications();
    debugPrint("后台消息处理:${message.toString()}");
  }
}
