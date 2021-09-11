import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static sendNotification([String? title, String? body]) async {
    DateTime now = DateTime.now();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name', 'channel_desc',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, title ?? 'plain title',
        body ?? 'plain body --- $now', platformChannelSpecifics,
        payload: 'item x');
  }

  static sendReminderNotification() {
    sendNotification("Time to drink!", "You've not reach your goal yet.");
  }
}
