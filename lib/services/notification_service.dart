import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Handles local notifications, notification permissions,
/// and notification timing for SGReady.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const int _weatherNotificationId = 100;
  static const int _taskNotificationId = 101;

  static const String _lastCheckKey = 'notification_last_check';

  static const Duration notificationInterval = Duration(hours: 5);

  static const NotificationDetails _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'sgready_general',
      'SGReady Notifications',
      channelDescription: 'General SGReady preparedness notifications',
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  /// Initializes notifications for the main application.
  ///
  /// This also sets the local timezone and requests notification permission
  /// on supported Android versions.
  Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
    );

    await _notificationsPlugin.initialize(
      settings: settings,
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation('Asia/Singapore'),
    );

    await _requestAndroidPermission();
  }

  /// Initializes notifications when the app is running in the background.
  ///
  /// Permission is not requested here because background tasks should not
  /// trigger permission prompts.
  Future<void> initForBackground() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
    );

    await _notificationsPlugin.initialize(
      settings: settings,
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation('Asia/Singapore'),
    );
  }

  /// Requests permission to show notifications on Android.
  Future<void> _requestAndroidPermission() async {
    final androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();
  }

  /// Displays a weather and preparedness notification.
  Future<void> showWeatherPreparedness({
    required String body,
    String languageCode = 'en',
  }) async {
    final title = _weatherTitle(languageCode);

    final androidDetails = AndroidNotificationDetails(
      'sgready_weather',
      'Weather & Preparedness',
      channelDescription: 'Environmental conditions and preparedness advice',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
      ),
    );

    final details = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      id: _weatherNotificationId,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  /// Displays a reminder for unfinished daily preparedness tasks.
  Future<void> showDailyTaskReminder({
    required String body,
    String languageCode = 'en',
  }) async {
    final title = _dailyTaskTitle(languageCode);

    await _notificationsPlugin.show(
      id: _taskNotificationId,
      title: title,
      body: body,
      notificationDetails: _details,
    );
  }

  /// Returns the localized weather notification title.
  String _weatherTitle(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return 'SGReady 天气与防灾准备';

      case 'ms':
        return 'Cuaca & Kesiapsiagaan SGReady';

      case 'en':
      default:
        return 'SGReady Weather & Preparedness';
    }
  }

  /// Returns the localized daily task notification title.
  String _dailyTaskTitle(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return 'SGReady 每日任务';

      case 'ms':
        return 'Tugas Harian SGReady';

      case 'en':
      default:
        return 'SGReady Daily Tasks';
    }
  }

  /// Cancels the current weather preparedness notification.
  Future<void> cancelWeatherPreparedness() async {
    await _notificationsPlugin.cancel(
      id: _weatherNotificationId,
    );
  }

  /// Cancels the current daily task reminder.
  Future<void> cancelDailyTaskReminder() async {
    await _notificationsPlugin.cancel(
      id: _taskNotificationId,
    );
  }

  /// Checks whether enough time has passed since the last notification check.
  Future<bool> isNotificationCheckDue({
    DateTime? currentTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final savedTimestamp = prefs.getInt(_lastCheckKey);

    if (savedTimestamp == null) {
      return true;
    }

    final lastCheck = DateTime.fromMillisecondsSinceEpoch(
      savedTimestamp,
    );

    final now = currentTime ?? DateTime.now();

    return now.difference(lastCheck) >= notificationInterval;
  }

  /// Saves the time of the latest notification check.
  Future<void> recordNotificationCheck({
    DateTime? currentTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final now = currentTime ?? DateTime.now();

    await prefs.setInt(
      _lastCheckKey,
      now.millisecondsSinceEpoch,
    );
  }
}
