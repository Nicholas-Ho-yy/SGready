import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../models/environmental_reading.dart';
import '../models/user_preferences.dart';
import '../providers/app_providers.dart';
import '../services/notification_coordinator.dart';
import '../services/notification_service.dart';

import 'explore_screen.dart';
import 'home_screen.dart';
import 'learn_screen.dart';
import 'profile_screen.dart';
import 'today_screen.dart';

/// Hosts SGReady's five main sections and coordinates notification
/// checks while the app is open or returns to the foreground.
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell>
    with WidgetsBindingObserver {
  int _index = 0;

  Timer? _notificationTimer;
  bool _isCheckingNotifications = false;

  static const Duration _notificationInterval = Duration(hours: 5);

  static const NotificationCoordinator _notificationCoordinator =
      NotificationCoordinator();

  static const List<Widget> _screens = [
    HomeScreen(),
    TodayScreen(),
    ExploreScreen(),
    LearnScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runNotificationCheck();
      _startNotificationTimer();
    });
  }

  /// Starts the periodic notification check while the app remains open.
  void _startNotificationTimer() {
    _notificationTimer?.cancel();

    _notificationTimer = Timer.periodic(
      _notificationInterval,
      (_) {
        _runNotificationCheck();
      },
    );
  }

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    if (state == AppLifecycleState.resumed) {
      _runNotificationCheck();
    }
  }

  /// Checks whether notifications are due and sends the appropriate
  /// weather or daily task reminders based on the user's preferences.
  Future<void> _runNotificationCheck() async {
    if (_isCheckingNotifications) {
      return;
    }

    _isCheckingNotifications = true;

    try {
      final preferencesService = ref.read(userPreferencesServiceProvider);

      final preferences = await preferencesService.getPreferences();

      if (!preferences.preparednessRemindersEnabled) {
        return;
      }

      final now = DateTime.now();

      final notificationService = NotificationService.instance;

      final isDue = await notificationService.isNotificationCheckDue(
        currentTime: now,
      );

      if (!isDue) {
        return;
      }

      final isDaytime = now.hour >= 8 && now.hour < 22;

      final allowWeather = preferences.notificationScheduleMode ==
              NotificationScheduleMode.allDay ||
          isDaytime;

      final allowTasks = isDaytime;

      if (!allowWeather && !allowTasks) {
        return;
      }

      // Force a fresh environmental-data request for this
      // notification cycle instead of reusing cached data.
      ref.invalidate(snapshotProvider);

      final snapshot = await ref.read(snapshotProvider.future);

      if (allowWeather) {
        await _sendWeatherPreparednessNotification(
          snapshot: snapshot,
          preferences: preferences,
        );
      }

      if (allowTasks) {
        await _sendDailyTaskNotification(
          snapshot: snapshot,
          preferences: preferences,
          currentTime: now,
        );
      }

      await notificationService.recordNotificationCheck(
        currentTime: now,
      );
    } catch (error) {
      debugPrint(
        'Notification check failed: $error',
      );
    } finally {
      _isCheckingNotifications = false;
    }
  }

  /// Builds and sends a weather preparedness notification using
  /// the latest environmental conditions and selected region.
  Future<void> _sendWeatherPreparednessNotification({
    required EnvironmentalSnapshot snapshot,
    required UserPreferences preferences,
  }) async {
    final region = ref.read(selectedRegionProvider);

    final contextService = ref.read(missionContextServiceProvider);

    final context = contextService.generate(
      snapshot: snapshot,
      region: region,
    );

    final languageCode = preferences.languageCode;

    final body = _notificationCoordinator.buildWeatherPreparednessBody(
      context: context,
      languageCode: languageCode,
    );

    await NotificationService.instance.showWeatherPreparedness(
      body: body,
      languageCode: languageCode,
    );
  }

  /// Builds and sends a reminder for unfinished daily preparedness tasks.
  Future<void> _sendDailyTaskNotification({
    required EnvironmentalSnapshot snapshot,
    required UserPreferences preferences,
    required DateTime currentTime,
  }) async {
    final region = ref.read(selectedRegionProvider);

    final taskService = ref.read(dailyTaskServiceProvider);

    final tasks = taskService.generateTasks(
      snapshot: snapshot,
      region: region,
      preferences: preferences,
    );

    final progressService = ref.read(userProgressServiceProvider);

    final progress = await progressService.getProgress();

    final languageCode = preferences.languageCode;

    final body = _notificationCoordinator.buildDailyTaskReminderBody(
      tasks: tasks,
      progress: progress,
      languageCode: languageCode,
      currentTime: currentTime,
    );

    if (body == null) {
      return;
    }

    await NotificationService.instance.showDailyTaskReminder(
      body: body,
      languageCode: languageCode,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _notificationTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _screens,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(
              Icons.dashboard_outlined,
            ),
            selectedIcon: const Icon(Icons.dashboard),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.today_outlined,
            ),
            selectedIcon: const Icon(Icons.today),
            label: l10n.navToday,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.map_outlined,
            ),
            selectedIcon: const Icon(Icons.map),
            label: l10n.navExplore,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.school_outlined,
            ),
            selectedIcon: const Icon(Icons.school),
            label: l10n.navLearn,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.person_outline,
            ),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
