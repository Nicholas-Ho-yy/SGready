import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/daily_task.dart';
import '../models/environmental_reading.dart';
import '../models/gamification.dart';
import '../models/mission_context.dart';
import '../models/user_preferences.dart';
import '../services/daily_task_service.dart';
import '../services/data_gov_sg_api.dart';
import '../services/mission_context_service.dart';
import '../services/risk_engine.dart';
import '../services/user_preferences_service.dart';
import '../services/user_progress_service.dart';

/// Provides the Data.gov.sg API service.
final apiProvider = Provider<DataGovSgApi>((ref) {
  final api = DataGovSgApi();

  ref.onDispose(api.dispose);

  return api;
});

/// Stores the region currently selected by the user.
final selectedRegionProvider = StateProvider<SingaporeRegion>(
  (ref) => SingaporeRegion.central,
);

/// Retrieves the latest environmental information.
final snapshotProvider = FutureProvider<EnvironmentalSnapshot>((ref) async {
  final api = ref.watch(apiProvider);

  return api.fetchSnapshot();
});

/// Retrieves the latest rainfall readings from Data.gov.sg.
final rainfallProvider = FutureProvider<List<RainfallReading>>((ref) async {
  final api = ref.watch(apiProvider);

  return api.fetchRainfall();
});

/// Analyses the environmental snapshot for the selected region.
final riskSummaryProvider = Provider<AsyncValue<RiskSummary>>((ref) {
  final snapshotState = ref.watch(snapshotProvider);
  final selectedRegion = ref.watch(selectedRegionProvider);

  return snapshotState.whenData(
    (snapshot) => RiskEngine.analyze(
      snapshot: snapshot,
      region: selectedRegion,
    ),
  );
});

/// Provides the service responsible for generating personalised daily tasks.
final dailyTaskServiceProvider = Provider<DailyTaskService>((ref) {
  return const DailyTaskService();
});

/// Provides the service that interprets environmental data for the Today experience.
final missionContextServiceProvider = Provider<MissionContextService>((ref) {
  return const MissionContextService();
});

/// Generates the current mission context from the latest environmental
/// snapshot and the user's selected region.
final missionContextProvider = Provider<AsyncValue<MissionContext>>((ref) {
  final snapshotState = ref.watch(snapshotProvider);
  final selectedRegion = ref.watch(selectedRegionProvider);
  final contextService = ref.watch(missionContextServiceProvider);

  return snapshotState.whenData(
    (snapshot) => contextService.generate(
      snapshot: snapshot,
      region: selectedRegion,
    ),
  );
});

/// Generates the user's daily preparedness tasks from the latest
/// environmental conditions, selected region and saved preferences.
final dailyTasksProvider = Provider<AsyncValue<List<DailyTask>>>((ref) {
  final snapshotState = ref.watch(snapshotProvider);
  final selectedRegion = ref.watch(selectedRegionProvider);
  final taskService = ref.watch(dailyTaskServiceProvider);
  final preferencesState = ref.watch(userPreferencesProvider);

  return snapshotState.when(
    data: (snapshot) {
      return preferencesState.when(
        data: (preferences) {
          return AsyncValue.data(
            taskService.generateTasks(
              snapshot: snapshot,
              region: selectedRegion,
              preferences: preferences,
            ),
          );
        },
        loading: () => const AsyncValue<List<DailyTask>>.loading(),
        error: (error, stackTrace) => AsyncValue<List<DailyTask>>.error(
          error,
          stackTrace,
        ),
      );
    },
    loading: () => const AsyncValue<List<DailyTask>>.loading(),
    error: (error, stackTrace) => AsyncValue<List<DailyTask>>.error(
      error,
      stackTrace,
    ),
  );
});

/// Exposes Firebase authentication changes to the rest of the app.
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Creates a progress service for the currently authenticated user.
///
/// The service is recreated when authentication changes and disposed
/// automatically when it is no longer required.
final userProgressServiceProvider = Provider.autoDispose<UserProgressService>(
  (ref) {
    ref.watch(authStateProvider);

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw StateError(
        'UserProgressService requires an authenticated user.',
      );
    }

    final service = UserProgressService(
      userId: user.uid,
    );

    ref.onDispose(
      service.dispose,
    );

    return service;
  },
);

/// Streams the authenticated user's latest gamification and
/// preparedness progress.
final userProgressProvider = StreamProvider.autoDispose<UserProgress>((ref) {
  final service = ref.watch(userProgressServiceProvider);

  return service.watchProgress();
});

/// Provides access to the user's persisted application preferences.
final userPreferencesServiceProvider = Provider<UserPreferencesService>((ref) {
  return UserPreferencesService();
});

/// Loads the user's saved preferences.
final userPreferencesProvider = FutureProvider<UserPreferences>((ref) async {
  final service = ref.watch(userPreferencesServiceProvider);

  return service.getPreferences();
});

/// Applies the user's saved home region to the shared region state
/// when preferences are initialised.
final initialisePreferredRegionProvider = FutureProvider<void>((ref) async {
  final preferences = await ref.watch(userPreferencesProvider.future);

  final preferredRegion = regionFromPreference(
    preferences.homeRegion,
  );

  ref.read(selectedRegionProvider.notifier).state = preferredRegion;
});

/// Stores and exposes the application's current theme mode.
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

/// Manages theme selection and persists it between app sessions.
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  static const String _themeModeKey = 'theme_mode';

  /// Restores the previously selected theme, defaulting to the system theme.
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeModeKey);

    switch (savedMode) {
      case 'light':
        state = ThemeMode.light;
        break;

      case 'dark':
        state = ThemeMode.dark;
        break;

      case 'system':
      default:
        state = ThemeMode.system;
        break;
    }
  }

  /// Updates the active theme and saves the selection locally.
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;

    final prefs = await SharedPreferences.getInstance();

    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await prefs.setString(_themeModeKey, value);
  }
}

/// Stores the locally saved profile photo used by the Profile screen.
final profilePhotoProvider =
    StateNotifierProvider<ProfilePhotoNotifier, Uint8List?>(
  (ref) => ProfilePhotoNotifier(),
);

/// Manages loading, saving and removing the user's local profile photo.
class ProfilePhotoNotifier extends StateNotifier<Uint8List?> {
  ProfilePhotoNotifier() : super(null) {
    _loadPhoto();
  }

  static const String _photoKey = 'profile_photo';

  Future<void> _loadPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPhoto = prefs.getString(_photoKey);

    if (savedPhoto == null || savedPhoto.isEmpty) {
      return;
    }

    try {
      state = base64Decode(savedPhoto);
    } catch (_) {
      // Remove invalid saved data rather than repeatedly failing to decode it.
      await prefs.remove(_photoKey);
      state = null;
    }
  }

  Future<void> savePhoto(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _photoKey,
      base64Encode(bytes),
    );

    state = bytes;
  }

  Future<void> removePhoto() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_photoKey);

    state = null;
  }
}

/// Converts the saved region name into the corresponding SingaporeRegion.
///
/// Central is used as a safe fallback for an unknown value.
SingaporeRegion regionFromPreference(
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

/// Returns the display colour associated with a risk level.
Color riskColor(RiskLevel level) {
  switch (level) {
    case RiskLevel.good:
      return const Color(0xFF2E7D32);

    case RiskLevel.moderate:
      return const Color(0xFFF9A825);

    case RiskLevel.high:
      return const Color(0xFFEF6C00);

    case RiskLevel.veryHigh:
      return const Color(0xFFC62828);

    case RiskLevel.extreme:
      return const Color(0xFF6A1B9A);
  }
}
