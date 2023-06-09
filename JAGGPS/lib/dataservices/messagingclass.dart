import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:JAGGPS/dataservices/awesome.dart';

Future<void> bbackgroundMessageHandlers(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String title = message.notification!.title.toString();
  String body = message.notification!.body.toString();
  await sendNotification(title, body);
  Future.delayed(const Duration(seconds: 5), () async {
    await flutterLocalNotificationsPlugin.cancel(0);
  });
}

class Messagingclass {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<String> gettoken() async {
    String token =
        await FirebaseMessaging.instance.getToken().then((value) async {
      return value.toString();
    });
    return token;
  }

  Future initializeNotificationService(context) async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // _messaging.getInitialMessage();
      FirebaseMessaging.onBackgroundMessage(bbackgroundMessageHandlers);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        String title = message.notification!.title.toString();
        String body = message.notification!.body.toString();
        await sendNotification(title, body);
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {});
      _messaging.subscribeToTopic('allusers');
    } else {
      return;
    }
  }
}
