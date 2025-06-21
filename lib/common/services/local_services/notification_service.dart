import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _permissions = [
    Permission.notification,
    Permission.scheduleExactAlarm,
  ];

  Future<void> init(BuildContext context) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Prague'));

    // Initialise local notifications, for Android, iOS, Linux and macOS
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOInitializationSettings =
        DarwinInitializationSettings(requestAlertPermission: true);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) => {
        onDidReceiveNotificationResponse(response, context),
      },
    );

    // Check if we have permission to send notifications
    if (await checkNotificationPermission()) {
      await askPermissions();
    }
  }

  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
    BuildContext context,
  ) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      context.go("/task/$payload");
    }
  }

  Future<bool> checkNotificationPermission() async {
    final storeService = GetIt.instance.get<ServiceSettingsStore>();
    final settings = await storeService.getSettings;
    if (settings == null) {
      return false;
    }

    final status = await Permission.notification.status;
    return settings.notifications && status.isGranted;
  }

  Future<void> _scheduleNotification(
    TZDateTime when,
    String title,
    String subtitle,
    String? payload,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      Random.secure().nextInt(1000000),
      title,
      subtitle,
      when,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      payload: payload ?? '',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleNotificationForTask(Task task, Duration minutes) async {
    // Check if we have permission to send notifications
    if (!await checkNotificationPermission()) {
      return;
    }

    final tzNow = tz.TZDateTime.now(tz.local);
    final tzStart = tz.TZDateTime.from(task.startsAt, tz.local);
    final tzEnd = tz.TZDateTime.from(task.endsAt, tz.local);
    final before = tzStart.subtract(minutes);
    final after = tzEnd.subtract(minutes);

    if (tzNow.isBefore(tzStart)) {
      await _scheduleNotification(
        before,
        "Task '${task.name}' is about to start",
        "Task '${task.name}' starts at ${task.startsAt}. Click this notification to open the app.",
        task.id,
      );
    }

    if (tzNow.isAfter(tzStart) && tzNow.isBefore(tzEnd)) {
      await _scheduleNotification(
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
        "Task '${task.name}' has started",
        "Task '${task.name}' has started. "
            "Task started at ${task.startsAt} and ends at ${task.endsAt}."
            " Click this notification to open the app.",
        task.id,
      );

      await _scheduleNotification(
        after,
        "Task '${task.name}' is about to end",
        "Task '${task.name}' ends at ${task.endsAt}. Click this notification to open the app.",
        task.id,
      );
    }
  }

  Future<void> askPermissions() async {
    for (final permission in _permissions) {
      final status = await permission.status;
      if (status.isDenied) {
        await permission.request();
      }
    }

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
