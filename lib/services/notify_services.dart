import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyServices {
  static final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "PPFC",
          "PPFC channel",
          channelDescription: "This is the app's notifcation channel",
          importance: Importance.max,
          priority: Priority.high
        ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true
        )
      );
      await _notification.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data["route"]
      );
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }
  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          "PPFC",
          "PPFC channel",
          channelDescription: "This is the app's notifcation channel",
          importance: Importance.max,
          priority: Priority.high
      ),
      iOS: IOSNotificationDetails(
        presentSound: true,
        presentBadge: true,
        presentAlert: true
      ),
    );
  }

  static Future init({bool initScheduled = false }) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );
    const settings = InitializationSettings(android: android, iOS: ios);

    //when app is closed
    final details = await _notification.getNotificationAppLaunchDetails();
    if(details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notification.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification (
      {
        int id = 0,
        String? title,
        String? body,
        String? payload,
      }) async => _notification.show(id, title, body, await _notificationDetails(), payload: payload);

  static Future showScheduledNotification (
      {
        int id = 0,
        String? title,
        String? body,
        String? payload,
        required DateTime scheduledDate,
      }) async => _notification.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(scheduledDate, tz.local),
    await _notificationDetails(),
    payload: payload,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,

  );


  static Future showScheduledDailyNotification (
      {
        int id = 0,
        String? title,
        String? body,
        String? payload,
        required scheduledDate,
      }) async => _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduledDailyNotification(const Time(20, 01)),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time
  );

  static tz.TZDateTime _scheduledDailyNotification(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate;
  }

  static Future showScheduledWeeklyNotification (
      {
        int id = 0,
        String? title,
        String? body,
        String? payload,
        required scheduledDate,
      }) async => _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduledWeeklyNotification(const Time(17, 59), days: [DateTime.monday, DateTime.friday]),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
  );

  static tz.TZDateTime _scheduledWeeklyNotification(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduledDailyNotification(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}