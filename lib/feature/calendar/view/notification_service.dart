import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // ignore: prefer_const_declarations
    final AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        // ignore: prefer_const_constructors
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'TEST',
    'Hatırlatıcı',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  /* Future<void> showNotifications(String content, String saat) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "Hatırlatma",
      content + '\nSaat : ' + saat,
      NotificationDetails(android: _androidNotificationDetails),
    );
  } */

  Future<void> scheduleNotifications(
      DateTime noteTime, String text, int id) async {
    DateTime now = DateTime.now();

    Duration difference = now.isAfter(noteTime)
        ? now.difference(noteTime)
        : noteTime.difference(now);

    print(difference);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Hatırlatıcı",
        text,
        tz.TZDateTime.now(tz.local).add(difference),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

void selectNotification(String? payload) async {
  //handle your logic here
}
