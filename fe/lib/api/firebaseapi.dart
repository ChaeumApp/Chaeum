import 'package:dio/dio.dart';
import 'package:fe/detail/detail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 백그라운드 메세지
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) {
  print('뭔데');
}

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
    // print('데이터는 ${details.payload}');
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
    // print('${message.data['name']}');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(category: message.data['name'])));
  }

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(category: event.data['name'])));
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
        payload: message.data['name']);
  }
}




// Future<void> sendNotificationToDevice({
//   required String deviceToken,
//   required String title,
//   required String content,
//   required Map<String, dynamic> data
// }) async{
//   Dio dio = Dio(BaseOptions(
//     baseUrl: 'POST https://fcm.googleapis.com/v1/projects/chaeum-2e60e/messages:send',
//     headers: {'Authorization': 'Bearer ya29.a0AfB_byDrMhSNljBWNXhBL55KcbrjczmEvfvZ5jhBGSaCiX1yusDvYkDCwGhwaCqV-ezm_YPAst1DLsCag1dxn7yPMmWrsZWOTpBCF9lM4g-1Rg-tAily6Wt8FLKYAYque8gh85r6w7hAMsiJOD-Q2vUvEED_rBFnPTRqaCgYKAd4SARESFQGOcNnCNVzx0zk0kB8aSIwieRoYPA0171'},
//   ));
//
//   final body = {
//     'notification': {'title': title, 'body': content, 'data':data},
//     'to':deviceToken
//   };
//
//   final response = await dio.post('/');
//
//   if(response.statusCode == 200){
//     print('성공적으로 전송되었습니다');
//     print('$title $content');
//   }
// }