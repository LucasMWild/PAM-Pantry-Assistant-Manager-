import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'dart:io' show Platform;
import 'package:permission_handler/permission_handler.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  try{
    tz.initializeTimeZones();
    print('Time zone initialized. ');
  

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: DarwinInitializationSettings(), // iOS-specific settings
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // Request iOS permissions
  if (Platform.isIOS || Platform.isMacOS){
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
  if (Platform.isAndroid){
    //Android
    final status = await Permission.notification.request();
    print('🔔 Notification permission status: $status');
  }
  }
  catch (e){
    print('Error in initNotifications: $e');
  }
}


Future<void> scheduleNotification(DateTime expirationDate, String itemName) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    itemName.hashCode,
    'Expiration Alert',
    '$itemName expires today!',
    tz.TZDateTime.from(expirationDate, tz.local),
    NotificationDetails(
      android: AndroidNotificationDetails(
        'pantry_channel',
        'Pantry Alerts',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}


