import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsReceiving {
  FlutterLocalNotificationsPlugin? fltNotification =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void initMessaging() async {
    var androidInit =
        const AndroidInitializationSettings("drawable/ic_launcher");
    var iosInit = const DarwinInitializationSettings();

    var initSetting =
        InitializationSettings(android: androidInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification!.initialize(initSetting);

    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      autoCancel: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.notification?.title);
      print(message.notification?.body);
      await fltNotification!.show(
        0,
        message.notification!.title!,
        message.notification!.body!,
        platformChannelSpecifics,
        // payload: jsonEncode(message.data),
        // Replace with your desired payload data
      );
    });

    await fltNotification!.initialize(initSetting,
        onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse,
        ) async {});
    await fltNotification!.initialize(initSetting,
        onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse,
        ) async {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {});
  }

  Future<void> disableAutomaticPushNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.setAutoInitEnabled(false);
  }
}
