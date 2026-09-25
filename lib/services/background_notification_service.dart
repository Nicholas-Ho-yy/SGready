import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

import '../firebase_options.dart';
import '../models/environmental_reading.dart';
import 'daily_task_service.dart';
import 'data_gov_sg_api.dart';
import 'mission_context_service.dart';
import 'notification_coordinator.dart';
import 'notification_service.dart';
import 'user_preferences_service.dart';
import 'user_progress_service.dart';

/// Manages SGReady's periodic background notification task on Android.
class BackgroundNotificationService {
  BackgroundNotificationService._();

  static const String taskName = 'sgreadyNotificationCheck';

  static const String uniqueTaskName = 'sgready_periodic_notification_check';

  /// Registers SGReady's periodic notification check.
  static Future<void> register() async {
    await Workmanager().registerPeriodicTask(
      uniqueTaskName,
      taskName,
      frequency: const Duration(hours: 5),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}

/// Runs SGReady's notification checks when triggered by WorkManager.
@pragma('vm:entry-point')
void notificationCallbackDispatcher() {
  Workmanager().executeTask(
    (task, inputData) async {
      DataGovSgApi? api;

      try {
        await NotificationService.instance.initForBackground();

        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        }

        final preferencesService = UserPreferencesService();
        final preferences = await preferencesService.getPreferences();

        if (!preferences.preparednessRemindersEnabled) {
          return true;
        }

        // Use the language selected by the user.
        final languageCode = preferences.languageCode;
        final now = DateTime.now();

        final isDue = await NotificationService.instance.isNotificationCheckDue(
          currentTime: now,
        );

        if (!isDue) {
          return true;
        }

        final isDaytime = now.hour >= 8 && now.hour < 22;
        final isAllDay = preferences.notificationScheduleMode.name == 'allDay';
        final allowWeather = isAllDay || isDaytime;

        if (!allowWeather) {
          return true;
        }

        // Fetch fresh conditions instead of relying on data cached by the app.
        api = DataGovSgApi();

        final snapshot = await api.fetchSnapshot();

        final region = _regionFromPreference(
          preferences.homeRegion,
        );

        const contextService = MissionContextService();
        final context = contextService.generate(
          snapshot: snapshot,
          region: region,
        );

        const coordinator = NotificationCoordinator();

        // Build the weather message in the user's selected language.
        final body = coordinator.buildWeatherPreparednessBody(
          context: context,
          languageCode: languageCode,
        );

        await NotificationService.instance.showWeatherPreparedness(
          body: body,
          languageCode: languageCode,
        );

        // Daily task reminders are daytime only.
        if (isDaytime) {
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            const taskService = DailyTaskService();

            final tasks = taskService.generateTasks(
              snapshot: snapshot,
              region: region,
              preferences: preferences,
            );

            final progressService = UserProgressService(
              userId: user.uid,
            );

            try {
              final progress = await progressService.getProgress();

              // Build the task reminder in the user's selected language.
              final taskBody = coordinator.buildDailyTaskReminderBody(
                tasks: tasks,
                progress: progress,
                languageCode: languageCode,
                currentTime: now,
              );

              if (taskBody != null) {
                await NotificationService.instance.showDailyTaskReminder(
                  body: taskBody,
                  languageCode: languageCode,
                );
              }
            } finally {
              progressService.dispose();
            }
          }
        }

        await NotificationService.instance.recordNotificationCheck(
          currentTime: now,
        );

        return true;
      } catch (error, stackTrace) {
        debugPrint(
          'SGReady background notification check failed: '
          '$error\n$stackTrace',
        );

        return false;
      } finally {
        api?.dispose();
      }
    },
  );
}

/// Converts the user's saved home region into the region
/// used when generating environmental guidance and daily tasks.
SingaporeRegion _regionFromPreference(
  String region,
) {
  switch (region.toLowerCase()) {
    case 'north':
      return SingaporeRegion.north;

    case 'south':
      return SingaporeRegion.south;

    case 'east':
      return SingaporeRegion.east;

    case 'west':
      return SingaporeRegion.west;

    case 'central':
    default:
      return SingaporeRegion.central;
  }
}
