import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create the 'call_channel' notification channel
  const AndroidNotificationChannel callChannel = AndroidNotificationChannel(
    'call_channel', // id
    'Call Channel', // name// description
    importance: Importance.high,
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(callChannel);
}

Future<void> sendNotification(String head, String body) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Configure the notification details
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'call_channel', // channel ID
          'Call Channel', // channel name// channel description

          ticker: 'ticker',
          importance: Importance.max,
          priority: Priority.max,
          enableLights: true,
          enableVibration: true,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.call,
          sound: RawResourceAndroidNotificationSound('your_sound_file'),
          playSound: true);

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Build the notification
  await flutterLocalNotificationsPlugin.show(
    0, // notification ID
    head, // notification title
    body, // notification body
    platformChannelSpecifics,
    payload: 'call_payload',
  );
}
