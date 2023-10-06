import 'package:fe/detail/detail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 백그라운드 메세지
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) {}

void initializeNotification(context) async {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      ),
      // foreground일 때 알림 눌렀을 때
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(category: details.payload)));
  }, onDidReceiveBackgroundNotificationResponse: backgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(category: message.data['id'])));
  }

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(category: event.data['id'])));
  });
}

getMyDeviceToken() async {
  final firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.requestPermission();
  final token = await firebaseMessaging.getToken();

  return token.toString();
}

void foregroundMessage(RemoteMessage message) {
  RemoteNotification? notification = message.notification;

  if (notification != null) {
    FlutterLocalNotificationsPlugin().show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'high_importance_notification',
            importance: Importance.max,
          ),
        ),
        // local notification에 메세지 전달은 이걸로
        payload: message.data['id']);
  }
}
