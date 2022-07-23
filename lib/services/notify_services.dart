import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyServices {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    // final largeIconPath = await Utils.downloadFile(
    //   "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
    //   'largeIcon',
    // );
    // final bigPicturePath = await Utils.downloadFile(
    //   "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
    //   'bigPicture',
    // )

    // final styleInformation = BigPictureStyleInformation(
    //   FilePathAndroidBitmap(bigPicturePath),
    //   largeIcon: FilePathAndroidBitmap(largeIconPath),
    // );

    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        // styleInformation: styleInformation,
        priority: Priority.high
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false }) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings();
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
    _scheduledDailyNotification(const Time(9)),
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
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    return scheduledDate;
      }

}
