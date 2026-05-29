import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

    static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    
    static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('notification_icon');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

     await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings);
    }


    static Future<void> showNotification({
  required String title,
  required String body,
}) async {

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'expense_channel',
      'Expense Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails =
    DarwinNotificationDetails();

    const NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
  id: 0,
  title: title,
  body: body,
  notificationDetails: notificationDetails,
);

}
}
