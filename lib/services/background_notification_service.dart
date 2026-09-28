// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific background notification scheduling, environmental
// checks and reminder logic in this file were developed by me.
//
// WorkManager is an external Flutter package used to run periodic background
// tasks on Android. Firebase Authentication and Firebase Core are external
// Firebase services used by the application.

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
    // Schedule a periodic Android background check. The notification
    // service performs its own checks before deciding whether to notify the user.
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

        // Background tasks can run separately from the main app, so make
        // sure Firebase has been initialised before accessing Firebase services.
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        }

        final preferencesService = UserPreferencesService();
        final preferences = await preferencesService.getPreferences();

        // Stop the background check if the user has disabled preparedness reminders.
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

        // Follow the user's notification schedule. Daytime reminders are
        // limited to 8 AM to 10 PM unless all-day notifications are enabled.
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

        // Turn the latest environmental readings into the preparedness
        // context used to decide what information should be shown.
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

              // A null message means there are no unfinished tasks that need a reminder.
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