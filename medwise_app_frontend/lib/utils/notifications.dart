import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void initializeTimeZones() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Taipei'));
}

void initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        print('Notification payload: ${response.payload}');
        // 進入指定頁面或執行其他操作
      }
    },
  );
}

Future<void> scheduleNotification(DateTime scheduledDate, String medicineName) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    DateTime.now().millisecondsSinceEpoch.remainder(100000), // 使用唯一 ID
    'Medicine Reminder',
    'It\'s time to take your $medicineName',
    tz.TZDateTime.from(scheduledDate, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id', // 渠道 ID
        'Your channel name', // 渠道名稱
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // 根據需求設置模式
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

List<Map<String, dynamic>> medicationLogs = [];

void logUserAction(String action, DateTime scheduledDate) {
  final logEntry = {
    'date': DateTime.now(),
    'scheduledDate': scheduledDate,
    'action': action,
  };
  medicationLogs.add(logEntry);
  print('Log Entry: $logEntry');
}

Future<void> checkUserResponse(DateTime scheduledDate) async {
  await Future.delayed(const Duration(minutes: 30));
  bool responseRecorded = medicationLogs.any((log) =>
  log['scheduledDate'] == scheduledDate &&
      (log['action'] == 'open' || log['action'] == 'close' || log['action'] == 'skip'));

  if (!responseRecorded) {
    logUserAction('missed', scheduledDate);
  }
}

Widget buildLogList() {
  return ListView.builder(
    itemCount: medicationLogs.length,
    itemBuilder: (context, index) {
      final log = medicationLogs[index];
      return ListTile(
        title: Text('Scheduled: ${log['scheduledDate']}'),
        subtitle: Text('Action: ${log['action']} at ${log['date']}'),
      );
    },
  );
}
