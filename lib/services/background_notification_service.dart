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

/// Handles periodic background notification checks on Android.
class BackgroundNotificationService {
  BackgroundNotificationService._();

  static const String taskName = 'sgreadyNotificationCheck';
  static const String uniqueTaskName = 'sgready_periodic_notification_check';

  /// Registers the background notification task.
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

/// Called by WorkManager when the background task runs.
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

        // Fetch current conditions instead of using cached app data.
        api = DataGovSgApi();
        final snapshot = await api.fetchSnapshot();


        final region = _regionFromPreference(preferences.homeRegion);

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

        // Only send daily task reminders during the daytime.
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

/// Converts the saved home region into a SingaporeRegion value.
SingaporeRegion _regionFromPreference(String region) {
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